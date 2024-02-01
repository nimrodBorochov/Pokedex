//
//  NetworkClient.swift
//  PokTemp
//
//  Created by Nimrod Borochov on 01/02/2024.
//

import Foundation

protocol NetworkClientProtocol {
    func fetchPokemons(limit: Int, offset: Int) async throws -> [Pokemon]
}

class NetworkClient: NetworkClientProtocol {
    enum FetcherError: Error {
        case invalidURL
    }

    func fetchPokemons(limit: Int, offset: Int) async throws -> [Pokemon] {
        let pokemonListResponse = try await fetchPokemonListResponse(limit: limit, offset: offset)
        let pokemons = pokemonListResponse.results.compactMap { Pokemon(pokemonResponse: $0) }

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
        let decodedData = try JSONDecoder().decode(T.self, from: data)

        return decodedData
    }
}
