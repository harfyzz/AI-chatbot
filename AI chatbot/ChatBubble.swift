//
//  ChatBubble.swift
//  AI chatbot
//
//  Created by Afeez Yunus on 22/06/2024.
//

import SwiftUI

struct ChatBubble: View {
    
    @State var isSentByYou:Bool
    @State var bubbleColor:String
    @State var message = Message()
    
    var body: some View {
        HStack{
            Spacer()
            VStack{
                Text("Hello, World!")
                    .font(.title2)
                    .padding()
                    .foregroundStyle(.white)
                    .background(Color(bubbleColor))
                    .clipShape(RoundedRectangle(cornerRadius: 32))
                    .padding(.leading, 64)
                    .padding()
                HStack{
                    Text(message.sender.first ?? "")
                }
            }
            
        }
    }
}

#Preview {
    ChatBubble(isSentByYou: true, bubbleColor: "user")
}
