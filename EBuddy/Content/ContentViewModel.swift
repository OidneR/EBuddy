//
//  ContentViewModel.swift
//  EBuddy
//
//  Created by Eldrick Loe on 17/12/24.
//

import Foundation

final class ContentViewModel: ObservableObject {
    @Published var user: [UserJSON]?
    
    private let userHelper: UserHelper
    
    init(userHelper: UserHelper) {
        self.userHelper = userHelper
    }
    
    @MainActor
    func onViewAppear() async {
        do {
            user = try await userHelper.fetchUser()
        }
        catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
