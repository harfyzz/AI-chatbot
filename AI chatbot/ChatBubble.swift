//
//  ChatBubble.swift
//  AI chatbot
//
//  Created by Afeez Yunus on 22/06/2024.
//

import SwiftUI

struct ChatBubble: View {
    
    @State var isSentByYou:Bool
    @State var textInBubble:String
    @State var sender:String
    @State var timeSent:Date
    
    var body: some View {
        
                VStack{
                    Text(textInBubble)
                        .foregroundStyle(.gray)
                    HStack{Spacer()
                        Text("\(sender)")
                            .font(.caption)
                            
                    }
                }.padding(.horizontal)
    }

}
/*
#Preview {
    ChatBubble(isSentByYou: true)
}
*/
