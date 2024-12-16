//
//  UserHelper.swift
//  EBuddy(Development)
//
//  Created by Eldrick Loe on 15/12/24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import SwiftUI

@MainActor
final class UserHelper {
    @Published var uploadStatus: ImageUploadStatus = .failed
    
    func fetchUser() async throws -> [UserJSON]? {
        let db = Firestore.firestore()
        let snapshot = try await db.collection("USERS").getDocuments()
        return snapshot.documents.compactMap {
            try? Firestore.Decoder().decode(UserJSON.self, from: $0.data())
        }
    }
    
    func uploadProfilePicture(userID: String, image: UIImage) async -> ImageUploadStatus {
        await withCheckedContinuation { continuation in
            var taskID: UIBackgroundTaskIdentifier = .invalid

            taskID = UIApplication.shared.beginBackgroundTask(withName: "UploadProfilePicture") {
                // Handle if the system terminates the task
                UIApplication.shared.endBackgroundTask(taskID)
            }
            Task {
                let status = await self.performUpload(userID: userID, image: image)
                DispatchQueue.main.async {
                    self.uploadStatus = status
                    continuation.resume(returning: status)
                }
                UIApplication.shared.endBackgroundTask(taskID)
            }
        }
    }

    private func performUpload(userID: String, image: UIImage) async -> ImageUploadStatus {
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
    case inProgress
}
