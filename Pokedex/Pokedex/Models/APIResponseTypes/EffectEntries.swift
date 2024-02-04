//
//  EffectEntries.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 03/02/2024.
//

import Foundation

struct EffectEntries: Decodable {
    let effect: String
    let language: NamedAPIResource
}
