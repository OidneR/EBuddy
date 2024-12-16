//
//  UserHelper.swift
//  EBuddy(Development)
//
//  Created by Eldrick Loe on 15/12/24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

final class UserHelper {
    func fetchUser() async throws -> [UserJSON]? {
        let db = Firestore.firestore()
        let snapshot = try await db.collection("USERS").getDocuments()
        return snapshot.documents.compactMap {
            try? Firestore.Decoder().decode(UserJSON.self, from: $0.data())
        }
    }
    
    func uploadProfilePicture(userID: String, image: UIImage) async -> ImageUploadStatus {
        let storage: Storage = Storage.storage()
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return .failed
        }
        
        let storageRef = storage.reference().child("profilePictures/\(userID).jpg")
        
        do {
            _ = try await storageRef.putDataAsync(imageData, metadata: nil)
            let downloadURL = try await storageRef.downloadURL()
            return .success(downloadURL.absoluteString)
        } catch {
            return .error(error.localizedDescription)
        }
    }
    
}

enum ImageUploadStatus {
    case failed
    case success(String)
    case error(String)
}


