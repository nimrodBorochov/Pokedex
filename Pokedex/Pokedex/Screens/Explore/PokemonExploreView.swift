//
//  PokemonExploreView.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 01/02/2024.
//

import SwiftUI

struct PokemonExploreView: View {

    @Bindable private var viewModel: PokemonExploreViewModel = PokemonExploreViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.pokemons, id: \.self) { pokemon in
                    NavigationLink {
                        // PokemonDetailView()
                        Text(pokemon.name)
                    }
                label: {
                    PokemonExploreCell(pokemon: pokemon)
                        .onAppear(perform: {
                            viewModel.handleOnAppear(pokemon: pokemon)
                        })
                }
                }
            }
            .navigationTitle("Pokédex")
            .task {
                viewModel.loadPokemonList()
            }
        }
    }

    //    private let columns = [
    //        GridItem(.flexible(), spacing: 10),
    //        GridItem(.flexible(), spacing: 10)
    //    ]

    //    var body: some View {
    //        NavigationView {
    //
    //
    //            LazyVGrid(columns: columns, spacing: 10) {
    //                ForEach(viewModel.pokemons, id: \.self) { pokemon in
    //                    NavigationLink {
    //                        // PokemonDetailView()
    //                        Text(pokemon.name)
    //                    } label: {
    //                        PokemonExploreCell(pokemon: pokemon)
    //                            .onAppear {
    //                                viewModel.handleOnAppear(pokemon: pokemon)
    //                            }
    //
    //                    }
    //
    //                }
    //            }
    //            .padding(.horizontal, 10)
    //
    //            .navigationTitle("Pokédex")
    //            .task {
    //                viewModel.loadPokemonList()
    //            }
    //        }
    //    }
}

#Preview {
    PokemonExploreView()
}
