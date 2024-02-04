//
//  AbilityResponse.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 03/02/2024.
//

import Foundation

struct AbilityResponse: Codable {
    let name: String
    let effectEntries: [EffectEntries]
}
