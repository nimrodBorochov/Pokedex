//
//  NetworkClient.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 01/02/2024.
//

import Foundation

protocol NetworkClientProtocol {
    func fetchPokemons(limit: Int, offset: Int) async throws -> [Pokemon]
    func fetchPokemon(id: Int) async throws -> PokemonDetails
}

class NetworkClient: NetworkClientProtocol {
    func fetchPokemon(id: Int) async throws -> PokemonDetails {
        guard let url: URL = APIEndpoint.getPokemonDetails(id: id).url else {
            throw FetcherError.invalidURL
        }

        let pokemonDetailsResponse: PokemonDetailsResponse = try await fetch(from: url)
        
        let abilities: [Ability] = try await withThrowingTaskGroup(of: Ability.self) { group -> [Ability] in
            var fetchedAbilities: [Ability] = []

            for ability in pokemonDetailsResponse.abilities {
                if let url = URL(string: ability.ability.url) {
                    group.addTask {
                        let abilityResponse: AbilityResponse = try await self.fetch(from: url)
                        return Ability(abilityResponse: abilityResponse)
                    }
                }
            }

            for try await ability in group {
                fetchedAbilities.append(ability)
            }

            return fetchedAbilities
        }


        let moves: [Move] = try await withThrowingTaskGroup(of: Move.self) { group -> [Move] in
            var fetchedMoves: [Move] = []

            for move in pokemonDetailsResponse.moves {
                if let url = URL(string: move.move.url) {
                    group.addTask {
                        let moveResponse: MoveResponse = try await self.fetch(from: url)
                        return Move(moveResponse: moveResponse)
                    }
                }
            }

            for try await move in group {
                fetchedMoves.append(move)
            }

            return fetchedMoves
        }
//        var abilities: [Ability] = []
//
//        
//        // TODO:: Concurrency
//        for ability in pokemonDetailsResponse.abilities {
//            if let url = URL(string: ability.ability.url) {
//                let abilityResponse: AbilityResponse = try await fetch(from: url)
//                abilities.append(Ability(abilityResponse: abilityResponse))
//            }
//        }

//        var moves: [Move] = []
//
//        // TODO:: Concurrency
//        for move in pokemonDetailsResponse.moves {
//            if let url = URL(string: move.move.url) {
//                let moveResponse: MoveResponse = try await fetch(from: url)
//                moves.append(Move(moveResponse: moveResponse))
//            }
//        }


        return PokemonDetails(pokemonDetailsResponse: pokemonDetailsResponse, abilities: abilities, moves: moves)
    }
    
//    func loadStories() async {
//            do {
//                stories = try await withThrowingTaskGroup(of: [NewsStory].self) { group -> [NewsStory] in
//                    for i in 1...5 {
//                        group.addTask {
//                            let url = URL(string: "https://hws.dev/news-\(i).json")!
//                            let (data, _) = try await URLSession.shared.data(from: url)
//                            return try JSONDecoder().decode([NewsStory].self, from: data)
//                        }
//                    }
//
//                    let allStories = try await group.reduce(into: [NewsStory]()) { $0 += $1 }
//                    return allStories.sorted { $0.id > $1.id }
//                }
//            } catch {
//                print("Failed to load stories")
//            }
//        }

    enum FetcherError: Error {
        case invalidURL
    }

    func fetchPokemons(limit: Int, offset: Int) async throws -> [Pokemon] {
        let pokemonListResponse = try await fetchPokemonListResponse(limit: limit, offset: offset)
        let pokemons = pokemonListResponse.results.compactMap { Pokemon(pokemon: $0) }

        return pokemons
    }

    private func fetchPokemonListResponse(limit: Int, offset: Int) async throws -> PokemonListResponse {
        guard let url: URL = APIEndpoint.getPokemonList(limit: limit, offset: offset).url else {
            throw FetcherError.invalidURL
        }

        return try await fetch(from: url)
    }

    private func fetch<T>(from url: URL) async throws -> T where T : Decodable, T : Encodable {
        let (data, _) = try await URLSession.shared.data(from: url)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let decodedData = try decoder.decode(T.self, from: data)

        return decodedData
    }
}
