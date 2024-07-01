//
//  ContentView.swift
//  AI chatbot
//
//  Created by Afeez Yunus on 18/06/2024.
//

import SwiftUI
import GoogleGenerativeAI
import SwiftData
import RiveRuntime

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    @Query var messages:[Message]
    
    
    let geminiModel = GenerativeModel(name: "gemini-1.5-flash", apiKey:APIKey.default )
    @State var violet = RiveViewModel(fileName: "violet", fit: .contain)
    @State var loader = RiveViewModel(fileName: "loader", fit: .contain)
    @State var userMessage = ""
    @State var response = ""
    @FocusState var isFocused:Bool
    @State var isLoading = false
    var body: some View {
        VStack (spacing:0){
            HStack{Spacer()
                VStack(spacing:8){
                    violet.view()
                        .frame(height: 44)
                        .padding(.bottom)
                }
                Spacer()
            }.background(.white)
            Divider()
                .foregroundStyle(.gray.opacity(0.3))
            ScrollViewReader{proxy in
                ScrollView{
                    VStack{
                        ForEach (messages) { text in
                            ChatBubble(isSentByYou: text.isSentByYou, textInBubble:LocalizedStringKey( text.content), sender: text.sender, timeSent: text.time)
                                .padding(.bottom, 12)
                                .id(text.id)
                                .contextMenu(ContextMenu(menuItems: {
                                    Button("Delete") {
                                        context.delete(text)
                                    }
                                }))
                        }
                        if isLoading == true {
                         HStack{
                               loader.view()
                                   .frame(width:50,height: 24)
                                   .padding(.bottom)
                                   
                                Spacer()
                            }
                            
                        }
                    }.onChange(of: messages.count) { _, _ in
                        withAnimation {
                            proxy.scrollTo(messages.last?.id, anchor: .bottom)
                        }
                    }
                    .padding(.vertical,16)
                }.padding(.horizontal)
                    .onTapGesture {
                        isFocused = false
                    }
                    .scrollIndicators(.hidden)
                    .defaultScrollAnchor(.bottom)
                
            }.id("scroller")
                .animation(.bouncy, value: "scroller")
            HStack(alignment:.bottom){
                TextField("Talk to Violet...", text: $userMessage, axis: .vertical)
                    .lineLimit(4)
                    .font(.system(size: 16))
                    .tint(Color("user text"))
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 32))
                    .focused($isFocused)
                    .onSubmit {
                        if !userMessage.isEmpty {
                            withAnimation{
                                sendMessage()
                                generateResponse()
                            }
                        }
                    }
                Button(action: {
                    withAnimation{
                        sendMessage()
                        generateResponse()
                    }
                    
                }, label: {
                    Image(systemName: "arrow.up")
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                        .padding(10)
                        .background(Color("user text"))
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                })
                .disabled(userMessage.isEmpty ? true : false)
            }.padding(12)
                .background(.white)
            
        }
        .onAppear{
            isFocused = true
        }
        .preferredColorScheme(.light)
        
        
    }
    
    func sendMessage() {
        let newMessage = Message()
        newMessage.content = userMessage
        newMessage.time = Date()
        newMessage.isSentByYou = true
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
        isFocused = true
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
                geminiMessage.isSentByYou = false
                geminiMessage.sender = "Violet"
                context.insert(geminiMessage)
                withAnimation {
                    isLoading = false
                }
                
            } catch {
                response = "something went wrong\(error.localizedDescription)"
                let geminiMessage = Message()
                geminiMessage.content = response
                geminiMessage.time = Date()
                geminiMessage.isSentByYou = false
                geminiMessage.sender = "Violet"
                context.insert(geminiMessage)
                withAnimation {
                    isLoading = false
                }
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
