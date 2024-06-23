//
//  ChatBubble.swift
//  AI chatbot
//
//  Created by Afeez Yunus on 22/06/2024.
//

import SwiftUI

struct ChatBubble: View {
    
    @State var isSentByYou:Bool
    @State var textInBubble:LocalizedStringKey
    @State var sender:String
    @State var timeSent:Date
    
    var body: some View {
        VStack(alignment:.trailing){
            HStack{
                if isSentByYou == true { Spacer()
                }
                VStack(alignment:isSentByYou ? .trailing: .leading){
                    Text(textInBubble)
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundStyle(isSentByYou ? .white:.black)
                        .padding()
                        .background(Color(isSentByYou ? "user": "gemini"))
                        .clipShape(
                            .rect(
                                topLeadingRadius: 28,
                                bottomLeadingRadius:isSentByYou ? 28 : 4,
                                bottomTrailingRadius: isSentByYou ? 4 : 28,
                                topTrailingRadius: 28
                            ))
                        .frame(maxWidth: 330, alignment:isSentByYou ? .trailing: .leading)
                    
                    
                    HStack{
                        Text("\(sender), \(timeFromDate(input: timeSent))")
                            .padding(isSentByYou ? .trailing: .leading, 8)
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                    }
                }
                if isSentByYou == false {
                    Spacer()
                }
            }
        }
    }
    func timeFromDate(input:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let formattedDate = dateFormatter.string(from: input)
        return formattedDate
    }
    
}

#Preview {
    ChatBubble(isSentByYou: false, textInBubble: "Hello You", sender: "You", timeSent: Date())
}

