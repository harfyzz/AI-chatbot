//
//  ContentView.swift
//  AI chatbot
//
//  Created by Afeez Yunus on 18/06/2024.
//

import SwiftUI
import GoogleGenerativeAI

struct ContentView: View {
    
    let model = GenerativeModel(name: "gemini-1.5-flash", apiKey:APIKey.default )
    @State var userMessage = ""
    @State var response:LocalizedStringKey = "How can I help you today?"
    @State var isLoading = false
    var body: some View {
        VStack {
            Text("Chat with Gemini")
                .font(.title)
                .padding()
            if isLoading == false {
                ScrollView{
                    Text(response)
                        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: response)
                        .contentTransition(.numericText())
                        .font(.callout)
                        .foregroundStyle(.gray)
                }
                .scrollIndicators(.hidden)
            } else {
                Spacer()
                HStack{Spacer()
                    ProgressView()
                        .progressViewStyle(.circular)
                    Spacer()
                }
                Spacer()
            }
                Spacer()
            HStack(alignment:.bottom){
                TextField("enter message here", text: $userMessage, axis: .vertical)
                    .lineLimit(4)
                    .padding(12)
                    .background(.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 32))
                    .onSubmit {
                        generateResponse()
                    }
                Button(action: {
                    generateResponse()
                }, label: {
                    Image(systemName: "arrow.up")
                        .foregroundStyle(.white)
                        .padding()
                        .background(.blue)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                })
            }
        }.padding()
    }
    func generateResponse() {
        isLoading = true
        Task {
            do {
                let geminiAnswer = try await model.generateContent(userMessage)
                isLoading = false
                response = LocalizedStringKey( geminiAnswer.text ?? "")
                userMessage = ""
            } catch {
                response = "something went wrong\(error.localizedDescription)"
            }
        }
        
    }
}

#Preview {
    ContentView()
}
