//
//  NamedAPIResource.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 01/02/2024.
//

import Foundation

struct NamedAPIResource: Decodable {
    let name: String
    let url: String
}
