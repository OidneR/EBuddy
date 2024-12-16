//
//  EBuddyApp.swift
//  EBuddy
//
//  Created by Eldrick Loe on 14/12/24.
//

import SwiftUI
import FirebaseCore

@main
struct EBuddyApp: App {
    
    init() {
        FirebaseApp.configure()
    }


  var body: some Scene {
    WindowGroup {
      NavigationView {
          ContentView(viewModel: ContentViewModel(userHelper: UserHelper()))
      }
    }
  }
}
