//
//  Config.swift
//  EBuddy(Development)
//
//  Created by Eldrick Loe on 15/12/24.
//

import Foundation

struct Config {
    static let baseURL: String = {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            fatalError("BASE_URL is not set in the plist for this environment.")
        }
        return baseURL
    }()

    static let firebaseAPIKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "FIREBASE_API_KEY") as? String else {
            fatalError("FIREBASE_API_KEY is not set in the plist for this environment.")
        }
        return apiKey
    }()
}
