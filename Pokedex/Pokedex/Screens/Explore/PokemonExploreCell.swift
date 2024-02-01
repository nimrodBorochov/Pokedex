//
//  PokemonExploreCell.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 01/02/2024.
//

import SwiftUI

struct PokemonExploreCell: View {
    var pokemon: Pokemon

    var body: some View {

        HStack {

            AsyncImage(url: pokemon.imageURL) { image in
                image
                    .image?
                    .resizable()
            }
            .scaledToFit()
            .frame(width: 100, height: 100)

            Text(pokemon.name)
        }
    }

}

#Preview {
    PokemonExploreCell(pokemon: .preview)
}
