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
        .background(.red.opacity(0.75))
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
}

#Preview {
    PokemonExploreCell(pokemon: .preview)
}
