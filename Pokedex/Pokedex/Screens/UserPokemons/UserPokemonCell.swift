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

            VStack {
                Text(userPokemon.nickname)
                    
                    .font(.title)
                Text(userPokemon.pokemon.name)

            }

        }
    }

}

#Preview {
    UserPokemonCell(userPokemon: .preview)
}
