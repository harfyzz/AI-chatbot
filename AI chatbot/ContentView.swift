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
    @State var yourMessage = ""
    var body: some View {
        VStack {
            HStack{
                TextField("enter message here", text: $yourMessage)
                    .textFieldStyle(.roundedBorder)
                Button(action: {
                    
                }, label: {
                    Text("Send")
                })
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
