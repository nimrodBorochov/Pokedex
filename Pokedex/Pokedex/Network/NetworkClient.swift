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
        
        return PokemonDetails(pokemonDetailsResponse: pokemonDetailsResponse)
    }
    
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
