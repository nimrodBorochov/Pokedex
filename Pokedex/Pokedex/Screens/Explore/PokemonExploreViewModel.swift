//
//  PokemonExploreViewModel.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 01/02/2024.
//

import Foundation

@Observable class PokemonExploreViewModel {
    let networkClient: NetworkClientProtocol

    var pokemons: [Pokemon] = [Pokemon]()
    var offset: Int = 0
    var currentPokemonDetails: PokemonDetails?

    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }

    func handleOnAppear(pokemon: Pokemon) async {
        guard pokemons.last == pokemon else { return }

        increaseOffset(value: APIEndpoint.pokeApiPokemonListLimit)
        await loadPokemonList()
    }

    func loadPokemonList() async {
        do {
            let pokemons = try await networkClient.fetchPokemons(limit: 20, offset: offset)
            self.pokemons += pokemons.compactMap{$0}
        } catch {
            print(error.localizedDescription)
        }
    }

    

    private func increaseOffset(value: Int) {
        offset += value
    }
}


//enum NetworkStatus {
//    case idle
//    case loading
//    case completed
//    case completedWithError(Error)
//}
//
//class PokemonExploreViewModel: ObservableObject {
//    struct State {
//        var networkStatus: NetworkStatus = .idle
//        var pokemons = [Pokemon]()
//    }
//
//    private var offset: Int = 0
//    let limit: Int = 20
//    private let networkClient: NetworkClientProtocol
//
//    @Published var state = State()
//
//    init(networkClient: NetworkClientProtocol = NetworkClient()) {
//        self.networkClient = networkClient
//    }
//
//    func load() async {
//        state.networkStatus = .loading
//
//        do {
//            state.pokemons = try await networkClient.fetchPokemons(limit: limit, offset: offset)
//            state.networkStatus = .completed
//        } catch {
//            state.networkStatus = .completedWithError(error)
//        }
//    }
//}
