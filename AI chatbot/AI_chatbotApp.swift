//
//  AI_chatbotApp.swift
//  AI chatbot
//
//  Created by Afeez Yunus on 18/06/2024.
//

import SwiftUI
import SwiftData

@main
struct AI_chatbotApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for:Message.self)
    }
}
