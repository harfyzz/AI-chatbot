//
//  ContentView.swift
//  AI chatbot
//
//  Created by Afeez Yunus on 18/06/2024.
//

import SwiftUI

struct ContentView: View {
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
        }.onAppear{
            print(Bundle.main.infoDictionary? ["API_KEY"] as? String)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
