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
    let modelContainer: ModelContainer
       init() {
           do {
               modelContainer = try ModelContainer(for: Message.self)
           } catch {
               fatalError("Could not initialize ModelContainer")
           }
       }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
        }
    }
}
