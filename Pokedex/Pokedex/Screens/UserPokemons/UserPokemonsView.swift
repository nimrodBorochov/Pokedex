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

        List {
            ForEach(viewModel.pokemons, id: \.self) { pokemon in
                UserPokemonCell(userPokemon: pokemon)
            }
            .onDelete(perform: { indexSet in
                viewModel.delete(indexSet)
            })
        }
        .task {
            viewModel.getUserPokemons()
        }
    }
}

#Preview {
    UserPokemonsView(viewModel: UserPokemonsViewModel())

    
//    UserPokemonsView(pokemons:[
//        UserPokemon(
//            pokemon: Pokemon(pokemon:NamedAPIResource(name: "bulbasaur",
//                                                      url: "https://pokeapi.co/api/v2/pokemon/1/"))!,
//            nickname: "Borkstar"),
//
//        UserPokemon(
//            pokemon: Pokemon(pokemon:NamedAPIResource(name: "ivysaur",
//                                                      url: "https://pokeapi.co/api/v2/pokemon/2/"))!,
//            nickname: "YaZkIf"),
//
//        UserPokemon(
//            pokemon: Pokemon(pokemon:NamedAPIResource(name: "venusaur",
//                                                      url: "https://pokeapi.co/api/v2/pokemon/3/"))!,
//            nickname: "Yagstart"),
//
//        UserPokemon(
//            pokemon: Pokemon(pokemon:NamedAPIResource(name: "charmander",
//                                                      url: "https://pokeapi.co/api/v2/pokemon/4/"))!,
//            nickname: "Adak"),
//
//        UserPokemon(
//            pokemon: Pokemon(pokemon:NamedAPIResource(name: "charmeleon",
//                                                      url: "https://pokeapi.co/api/v2/pokemon/5/"))!,
//            nickname: "Abak"),
//
//        UserPokemon(
//            pokemon: Pokemon(pokemon:NamedAPIResource(name: "charizard",
//                                                      url: "https://pokeapi.co/api/v2/pokemon/6/"))!,
//            nickname: "AdBaki"),
//
//        UserPokemon(
//            pokemon: Pokemon(pokemon:NamedAPIResource(name: "squirtle",
//                                                      url: "https://pokeapi.co/api/v2/pokemon/7/"))!,
//            nickname: "shosh"),
//
//        UserPokemon(
//            pokemon: Pokemon(pokemon:NamedAPIResource(name: "wartortle",
//                                                      url: "https://pokeapi.co/api/v2/pokemon/8/"))!,
//            nickname: "swift"),
//
//        UserPokemon(
//            pokemon: Pokemon(pokemon:NamedAPIResource(name: "blastoise",
//                                                      url: "https://pokeapi.co/api/v2/pokemon/9/"))!,
//            nickname: "SwiftUI"),
//
//        UserPokemon(
//            pokemon: Pokemon(pokemon:NamedAPIResource(name: "caterpie",
//                                                      url: "https://pokeapi.co/api/v2/pokemon/10/"))!,
//            nickname: "edenia"),
//
//    ])
}
