//
//  UserPokemonsView.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 01/02/2024.
//

import SwiftUI

struct UserPokemonsView: View {

    var viewModel: UserPokemonsViewModel

    var body: some View {

        ZStack {
            BackgroundAnimation()

            List {
                ForEach(viewModel.pokemons, id: \.self) { pokemon in
                    UserPokemonCell(userPokemon: pokemon)
                        .listRowBackground(Color.clear)
                }
                .onDelete(perform: { indexSet in
                    viewModel.delete(indexSet)
                })
            }
            .scrollContentBackground(.hidden)
        }
        .task {
            viewModel.getUserPokemons()
        }
    }
}

#Preview {
    UserPokemonsView(viewModel: UserPokemonsViewModel())
}
