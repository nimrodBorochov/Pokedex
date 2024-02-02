//
//  TabBarView.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 01/02/2024.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            PokemonExploreView(viewModel: PokemonExploreViewModel(networkClient: NetworkClient()))
                .tabItem {
                    Label("Pokédex", systemImage: "text.book.closed")
                }

            UserPokemonsView()
                .tabItem {
                    Label("My Pokemons", systemImage: "cricket.ball.fill")
                }
        }
    }
}



#Preview {
    TabBarView()
}
