//
//  Ability.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 03/02/2024.
//

import Foundation

struct Ability: Identifiable {
    let id = UUID()
    let name: String
    let effect: String

    init(abilityResponse: AbilityResponse) {
        self.name = abilityResponse.name
        self.effect = abilityResponse.effectEntries.filter { $0.language.name == "en" }
            .first?.effect ?? "There is no effect description for this ability"
    }
}
