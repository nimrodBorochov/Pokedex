//
//  Stats.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 03/02/2024.
//

import Foundation

struct Stats: Identifiable {
    let id = UUID()
    let name: String
    let baseStat: Int
}
