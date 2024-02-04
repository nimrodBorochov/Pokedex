//
//  MoveResponse.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 03/02/2024.
//

import Foundation

struct MoveResponse: Codable {
    let name: String
    let effectEntries: [EffectEntries]
}

