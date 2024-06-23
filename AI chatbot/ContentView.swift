//
//  ContentView.swift
//  AI chatbot
//
//  Created by Afeez Yunus on 18/06/2024.
//

import SwiftUI
import GoogleGenerativeAI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    @Query var messages:[Message]
    
    
    @State var isSentByYou = true
    let geminiModel = GenerativeModel(name: "gemini-1.5-flash", apiKey:APIKey.default )
    @State var userMessage = ""
    @State var response = ""
    @State var savedQuestion = ""
    @State var isLoading = false
    var body: some View {
        VStack {
            Text("Chat with Gemini")
                .font(.title)
                .padding()
            ScrollViewReader{proxy in
                ScrollView{
                    ForEach (messages) { text in
                        VStack{
                            ChatBubble(isSentByYou: isSentByYou, textInBubble: text.content, sender: text.sender, timeSent: text.time)
                            Divider()
                        }
                    }
                    if isLoading {
                        ZStack{
                            HStack{
                                HStack{
                                    Circle()
                                        .frame(height: 4)
                                    Circle()
                                        .frame(height: 4)
                                    Circle()
                                        .frame(height: 4)
                                }.foregroundStyle(.gray)
                                    .padding(8)
                                    .background(.gray.opacity(0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 32))
                                Spacer()
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .defaultScrollAnchor(.bottom)
                .onChange(of: messages) { oldValue, newValue in
                    withAnimation {
                        proxy.scrollTo(newValue, anchor: .bottom)
                    }
                }
            }
            HStack(alignment:.bottom){
                TextField("enter message here", text: $userMessage, axis: .vertical)
                    .lineLimit(4)
                    .padding(12)
                    .background(.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 32))
                Button(action: {
                    sendMessage()
                    generateResponse()
                    
                    
                }, label: {
                    Image(systemName: "arrow.up")
                        .foregroundStyle(.white)
                        .padding()
                        .background(.blue)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                })
                .disabled(userMessage.isEmpty ? true : false)
            }
        }.padding()
        
    }
    
    func sendMessage() {
        let newMessage = Message()
        newMessage.content = userMessage
        newMessage.time = Date()
        newMessage.sender = "You"
        context.insert(newMessage)
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
        
        withAnimation {
            userMessage = ""
            isLoading = true
        }
    }
    
    func generateResponse() {
        let userPrompt = messages.last?.content ?? ""
        Task {
            do {
                let geminiAnswer = try await geminiModel.generateContent(userPrompt)
                response = geminiAnswer.text ?? "Nothing to display here..."
                let geminiMessage = Message()
                geminiMessage.content = response
                geminiMessage.time = Date()
                geminiMessage.sender = "Gemini"
                context.insert(geminiMessage)
                withAnimation {
                    isLoading = false
                }
                
            } catch {
                print("something went wrong\(error.localizedDescription)")
            }
        }
        withAnimation(.bouncy){
            try? context.save()
        }
        
    }
    
    
}

#Preview {
    ContentView()
}
