//
//  PokemonDetailsViewModel.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 02/02/2024.
//

import SwiftUI

@Observable class PokemonDetailsViewModel {
    private let networkClient: NetworkClientProtocol
    private let persistenceManager: PersistenceProtocol
    var pokemon: PokemonDetails?

    var loading = true
    var showShinny = false
    var showAlert = false
    var nickname = ""
    var selectedTab = 0
    
    var primaryTypeColor: UIColor {
        guard let pokemon else { return .systemBackground}

        return pokemon.primaryType.color()
    }

    var pokemonIndex: String {
        "#\(String(format: "%03d", pokemon?.id ?? ""))"
    }

    var primaryColor: Color {
        guard let pokemon else { return .primary}

        return pokemon.primaryType.textColorOnBg()

    }

    init(
        networkClient: NetworkClientProtocol = NetworkClient(),
        persistenceManager: PersistenceProtocol = PersistenceManager()
    ) {
        self.networkClient = networkClient
        self.persistenceManager = persistenceManager
    }

    func loadPokemonDetails(by id: Int) async {
        do {
            self.pokemon = try await networkClient.fetchPokemon(id: id)
            loading = false
        } catch {
            print(error.localizedDescription)
        }
    }

    func addToFavorites() {
        guard let pokemon else { return }
        let pokemonNickname = nickname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?
        pokemon.name : nickname
        let catchPokemon = Pokemon(
            id: pokemon.id,
            name: pokemon.name,
            imageURL: pokemon.frontDefaultImageUrl
        )
        persistenceManager.updateWith(
            userPokemon: UserPokemon(pokemon: catchPokemon, nickname: pokemonNickname),
            actionType: .add
        )
    }
}
