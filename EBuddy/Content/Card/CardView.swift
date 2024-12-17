//
//  CardView.swift
//  EBuddy
//
//  Created by Eldrick Loe on 17/12/24.
//

import Foundation
import SwiftUI

struct CardView: View {
    
    let model: CardModel
    
    var body: some View {
        VStack {
            header()
            profile()
            footer()
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 8)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("CardGeneral"))
                
        }
    }
    
    func header() -> some View {
        HStack {
            
            Text(model.name)
                .font(.system(size: 16, weight: .bold))
                .lineLimit(1)
            if model.isOnline {
                Image(systemName: "circle.fill")
                    .foregroundColor(.green)
            }
            
            Spacer()
            if model.isVerified {
                Image("verified")
            }
            if let instagramUsername = model.instagramUsername {
                Image("instagram")
                    .tint(.white)
            }
            
        }
    }
    func profile() -> some View {
        ZStack {
            AsyncImage(url: URL(string: model.profilePicture ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 168, height: 146)
            }
            placeholder: {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray)
                    .padding(.bottom, 20)
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.bottom, 20)
            
            VStack {
                Spacer()
                HStack {
                    HStack(spacing: -10) {
                        if model.playedGames.count > 2 {
                            AsyncImage(url: URL(string: model.playedGames[0])) { image in
                                if let image: Image = image.image {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                }
                                else {
                                    Circle()
                                        .frame(width: 40, height: 40)
                                }
                            }
                            .clipShape(Circle())
                            .frame(width: 40, height: 40)
                            
                            AsyncImage(url: URL(string: model.playedGames[1])) { image in
                                if let image: Image = image.image {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .overlay {
                                            Circle()
                                                .fill(Color.gray.opacity(0.5))
                                                .frame(width: 40, height: 40)
                                                .overlay {
                                                    Text("+\(model.playedGames.count - 2)")
                                                }
                                        }
                                }
                                else {
                                    Circle()
                                        .frame(width: 40, height: 40)
                                }
                            }
                        }
                        else {
                            ForEach(model.playedGames, id: \.self) { game in
                                AsyncImage(url: URL(string: game)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Circle()
                                        .frame(width: 40, height: 40)
                                }
                                .clipShape(Circle())
                                .frame(width: 40, height: 40)
                            }
                        }
                    }
                    Spacer()
                    if let voice = model.voice {
                        // Should play the voice when tapped
                        Image("voice")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal, 8)
            }
            
        }
    }
    func footer() -> some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Image("star")
                Text("\(model.rating, specifier: "%.1f")")
                Text("(\(model.ratingCount))")
            }
            HStack(spacing: 0) {
                Image("mana")
                Text("\(model.price, specifier: "%.2f")/1Hr")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}
