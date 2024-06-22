//
//  ChatBubble.swift
//  AI chatbot
//
//  Created by Afeez Yunus on 22/06/2024.
//

import Foundation
import SwiftData

@Model
class Message:Identifiable {
    var id = UUID()
    var sender = ["you", "Gemini"]
    var content = ""
    var time = Date()
    var bubbleColor = ""
    
    init(id: UUID = UUID(), sender: [String] = ["you", "Gemini"], content: String = "", time: Date = Date(), bubbleColor: String = "") {
        self.id = id
        self.sender = sender
        self.content = content
        self.time = time
        self.bubbleColor = bubbleColor
    }
}
