//
//  ContentModel.swift
//  EBuddy
//
//  Created by Eldrick Loe on 17/12/24.
//

import Foundation

struct CardModel {
    let name: String
    let isOnline: Bool
    let isVerified: Bool
    let instagramUsername: String?
    let isAvailable: Bool
    let playedGames: [String]
    let rating: Double
    let ratingCount: Int
    let price: Double
    let voice: String?
    let profilePicture: String?
    
    init(userJSON: UserJSON) {
        //Should change to real data fetched from Firebase
        name = userJSON.uid ?? "Dummy"
        isOnline = true
        isVerified = true
        instagramUsername = "dummy"
        isAvailable = true
        playedGames = ["https://github.com/OidneR/EBuddy/blob/main/Asset/games1.png?raw=true", "https://github.com/OidneR/EBuddy/blob/main/Asset/games2.png?raw=true"]
        rating = 4.5
        ratingCount = 100
        price = 1.0
        voice = "dummy"
        
        let femaleProfilePicture = "https://github.com/OidneR/EBuddy/blob/main/Asset/female.png?raw=true"
        let maleProfilePicture = "https://github.com/OidneR/EBuddy/blob/main/Asset/male.png?raw=true"
        profilePicture = userJSON.gender == .female ? femaleProfilePicture : maleProfilePicture
    }
}
