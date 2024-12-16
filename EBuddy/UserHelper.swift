//
//  UserHelper.swift
//  EBuddy(Development)
//
//  Created by Eldrick Loe on 15/12/24.
//

import Foundation
import FirebaseFirestore

final class UserHelper {
    func fetchUser() async throws -> [UserJSON]? {
        let db = Firestore.firestore()
        let snapshot = try await db.collection("USERS").getDocuments()
        return snapshot.documents.compactMap {
            try? Firestore.Decoder().decode(UserJSON.self, from: $0.data())
        }
    }
}


