    //
//  UserPokemonCell.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 02/02/2024.
//

import SwiftUI

struct UserPokemonCell: View {
    var userPokemon: UserPokemon

    var body: some View {

        HStack {

            AsyncImage(url: userPokemon.pokemon.imageURL) { image in
                image
                    .image?
                    .resizable()
            }
            .scaledToFit()
            .frame(width: 100, height: 100)

            Spacer()

            VStack {
                Text(userPokemon.nickname)
                    
                    .font(.title)
                Text(userPokemon.pokemon.name)

            }

        }
        .padding()
        .foregroundColor(.black)
        .background(silverGradient())
        .cornerRadius(16)
        .shadow(color: .primary, radius: 4)
    }

    func silverGradient() -> LinearGradient {
        var colors: [Color] = []

        if let color0 = UIColor(hex: "#70706F"),
           let color1 = UIColor(hex: "#7D7D7A"),
           let color2 = UIColor(hex: "#B3B6B5"),
           let color3 = UIColor(hex: "#8E8D8D"),
           let color4 = UIColor(hex: "#B3B6B5"),
           let color5 = UIColor(hex: "#A1A2A3")
        {
            colors.append(Color(color0))
            colors.append(Color(color1))
            colors.append(Color(color2))
            colors.append(Color(color3))
            colors.append(Color(color4))
            colors.append(Color(color5))
        }
        else {
            colors.append(.gray)
            colors.append(.primary)
        }

        return LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

#Preview {
    UserPokemonCell(userPokemon: .preview)
}
