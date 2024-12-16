//
//  ContentView.swift
//  EBuddy
//
//  Created by Eldrick Loe on 14/12/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if let users: [UserJSON] = viewModel.user,
               users.count != 0 {
                ForEach(users, id: \.self) { user in
                    VStack(alignment: .leading, spacing: 8) {
                        Text("gender: \(user.gender?.string ?? "unknown")")
                        Text("Phone Number: \(user.phoneNumber ?? "unknown")")
                        Text("Email: \(user.email ?? "unknown")")
                        Text("UID: \(user.uid ?? "unknown")")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }
            }
            
        }
        .padding()
        .task {
            await viewModel.onViewAppear()
        }
    }
}

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
