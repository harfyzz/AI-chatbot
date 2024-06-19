//
//  DataService.swift
//  AI chatbot
//
//  Created by Afeez Yunus on 18/06/2024.
//

import Foundation

    enum APIKey {
      // Fetch the API key 
        static var `default`: String = Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
    }

