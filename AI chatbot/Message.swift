//
//  ChatBubble.swift
//  AI chatbot
//
//  Created by Afeez Yunus on 22/06/2024.
//

import Foundation
import SwiftData

@Model
final class Message:Identifiable {
    @Attribute(.unique)
    var id:UUID
    var content:String
    var time:Date
    var sender:String
    
    
    init() {
        id = UUID()
        content = ""
        time = Date()
        sender = ""
        
    }
    
    func timeFromDate(input:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let formattedDate = dateFormatter.string(from: input)
        return formattedDate
    }
}

