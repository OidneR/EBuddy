//
//  User.swift
//  EBuddy(Development)
//
//  Created by Eldrick Loe on 15/12/24.
//

import Foundation

struct UserJSON: Codable, Hashable {
    var uid: String?
    var email: String?
    var phoneNumber: String?
    var gender: GenderEnum?
}

enum GenderEnum: Int, Codable, Hashable {
    case female = 0
    case male = 1
    
    var string: String {
        switch self {
        case .female:
            //TODO: change to localized string instead
            return "Female"
        case .male:
            return "Male"
        }
    }
}
