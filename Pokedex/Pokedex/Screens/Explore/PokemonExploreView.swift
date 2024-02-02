//
//  PokemonExploreView.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 01/02/2024.
//

import SwiftUI

struct PokemonExploreView: View {

    @Bindable var viewModel: PokemonExploreViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.pokemons, id: \.self) { pokemon in
                    NavigationLink {
                        PokemonDetailsView(viewModel: PokemonDetailsViewModel(networkClient: viewModel.networkClient), pokemonId: pokemon.id)
                    }
                label: {
                    PokemonExploreCell(pokemon: pokemon)
                        .onAppear(perform: {
                            Task {
                                await viewModel.handleOnAppear(pokemon: pokemon)
                            }
                        })
                }
                }
            }
            .navigationTitle("Pokédex")
            .task {
                await viewModel.loadPokemonList()
            }
        }
    }
}

#Preview {
    PokemonExploreView(viewModel: PokemonExploreViewModel(networkClient: NetworkClient()))
}
