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
    
    @ViewBuilder
    var body: some View {
        VStack {
            HStack {
                Text("EBuddy")
                    .font(.title)
            }
            if let users: [UserJSON] = viewModel.user,
               users.count != 0 {
                gridView(users: users)
            }
            
        }
        .padding()
        
        .background(Color("Background"))
        .task {
            await viewModel.onViewAppear()
        }
    }
    
    @ViewBuilder
    func gridView(users: [UserJSON]) -> some View {
        ScrollView {
            Grid {
                ForEach(0..<users.count/2, id: \.self) { index in
                    GridRow {
                        CardView(model: CardModel(userJSON: users[index * 2]))
                            .frame(maxWidth: 180)
                        if index*2 + 1 < users.count {
                            CardView(model: CardModel(userJSON: users[index + 1]))
                                .frame(maxWidth: 180)
                        }
                    }
                }
            }
        }
       
    }
}
