//
//  PokemonDetailsViewModelTests.swift
//  PokedexTests
//
//  Created by Nimrod Borochov on 04/02/2024.
//

@testable import Pokedex
import XCTest

final class PokemonDetailsViewModelTests: XCTestCase {
    var mockNetworkClient: MockNetworkClient!
    var mockPersistence: MockPersistence!
    override func setUp() {
        super.setUp()
        mockNetworkClient = MockNetworkClient()
        mockPersistence = MockPersistence()
    }

    override func tearDown() {
        mockNetworkClient = nil
        mockPersistence = nil
        super.tearDown()
    }

    func testLoadPokemonDetails() async {
        let sut = PokemonDetailsViewModel(networkClient: mockNetworkClient)
        XCTAssertTrue(sut.loading)
        XCTAssertNil(sut.pokemon)

        await sut.loadPokemonDetails(by: 1)

        XCTAssertFalse(sut.loading)
        XCTAssertEqual(sut.pokemon, PokemonDetails.preview)
    }

    func testAddToFavorites() {
        let sut = PokemonDetailsViewModel(
            networkClient: mockNetworkClient,
            persistenceManager: mockPersistence
        )
        let preview = PokemonDetails.preview
        sut.pokemon = preview
        sut.nickname = "Test"
        
        sut.addToFavorites()

        let pokemon = Pokemon(
            id: preview.id,
            name: preview.name,
            imageURL: preview.frontDefaultImageUrl
        )
        let userPokemon = UserPokemon(
            id: mockPersistence.updatePokemon!.id,
            pokemon: pokemon,
            nickname: "Test"
        )

        XCTAssertEqual(mockPersistence.updatePokemon, userPokemon)
        XCTAssertEqual(mockPersistence.actionType, .add)
    }

    func testAddToFavorites_WithoutNickName() {
        let sut = PokemonDetailsViewModel(
            networkClient: mockNetworkClient,
            persistenceManager: mockPersistence
        )
        let preview = PokemonDetails.preview
        sut.pokemon = preview

        sut.addToFavorites()

        let pokemon = Pokemon(
            id: preview.id,
            name: preview.name,
            imageURL: preview.frontDefaultImageUrl
        )

        let userPokemon = UserPokemon(
            id: mockPersistence.updatePokemon!.id,
            pokemon: pokemon,
            nickname: preview.name
        )

        XCTAssertEqual(mockPersistence.updatePokemon, userPokemon)
        XCTAssertEqual(mockPersistence.actionType, .add)
    }
}
