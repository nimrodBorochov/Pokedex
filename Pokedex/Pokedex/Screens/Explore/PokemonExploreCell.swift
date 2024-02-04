//
//  PokemonExploreCell.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 01/02/2024.
//

import SwiftUI

struct PokemonExploreCell: View {
    var pokemon: Pokemon
    let dimensions: Double = 140

    var body: some View {
        VStack {
            PokemonAsyncImage

            Text("\(pokemon.name.capitalized)")
                .font(.body)

            Text("#\(pokemon.id)")
                .font(.footnote)
        }
        .padding()
        .foregroundColor(.black)
        .background(goldGradient())
        .cornerRadius(16)
        .shadow(color: .primary, radius: 4)
    }

    private var PokemonAsyncImage: some View {
        ZStack {
            Circle()
                .frame(width: dimensions, height: dimensions)
                .foregroundColor(.secondary) // TODO:: pokemon.color with alpha

            AsyncImage(url: pokemon.imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: dimensions, height: dimensions)
            } placeholder: {
                ProgressView()
                    .frame(width: dimensions, height: dimensions)
            }
        }
    }

    func goldGradient() -> LinearGradient {
        var colors: [Color] = []

        if let color0 = UIColor(hex: "#DBB400"),
           let color1 = UIColor(hex: "#EFAF00"),
           let color2 = UIColor(hex: "#F5D100"),
           let color3 = UIColor(hex: "#D1AE15"),
           let color4 = UIColor(hex: "#DBB400"),
           let color5 = UIColor(hex: "#DBB400")
        {
            colors.append(Color(color0))
            colors.append(Color(color1))
            colors.append(Color(color2))
            colors.append(Color(color3))
            colors.append(Color(color4))
            colors.append(Color(color5))
        }
        else {
            colors.append(.yellow)
            colors.append(.primary)
        }

        return LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }

}

#Preview {
    PokemonExploreCell(pokemon: .preview)
}

