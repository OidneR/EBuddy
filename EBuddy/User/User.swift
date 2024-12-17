//
//  User.swift
//  EBuddy(Development)
//
//  Created by Eldrick Loe on 15/12/24.
//

import Foundation

struct UserJSON: Decodable, Hashable {
    var uid: String?
    var email: String?
    var phoneNumber: String?
    var gender: GenderEnum?
    
    enum CodingKeys: CodingKey {
        case uid
        case email
        case phoneNumber
        case ge
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uid = try container.decode(String.self, forKey: .uid)
        email = try? container.decode(String.self, forKey: .email)
        phoneNumber = try? container.decode(String.self, forKey: .phoneNumber)
        gender = try? container.decode(GenderEnum.self, forKey: .ge)
    }
        
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
