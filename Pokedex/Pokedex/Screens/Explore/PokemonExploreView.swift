//
//  PokemonExploreView.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 01/02/2024.
//

import SwiftUI

struct PokemonExploreView: View {

    @Bindable var viewModel: PokemonExploreViewModel

    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        NavigationView {

            ZStack {
                Color(.systemBackground)

                PokemonListView
            }
            .navigationTitle("Pokédex")
            .navigationBarTitleDisplayMode(.inline)
            .onFirstAppear {
                Task {
                    await viewModel.loadPokemonList()
                }
            }
        }
    }

    private var PokemonListView: some View {
        ScrollView {
            LazyVGrid(columns: adaptiveColumns, spacing: 12) {
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
        }
    }
}

#Preview {
    PokemonExploreView(viewModel: PokemonExploreViewModel(networkClient: NetworkClient()))
}
