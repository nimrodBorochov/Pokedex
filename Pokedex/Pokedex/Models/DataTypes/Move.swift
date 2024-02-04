//
//  Move.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 03/02/2024.
//

import Foundation

struct Move: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let effect: String

    init(moveResponse: MoveResponse) {
        self.name = moveResponse.name
        self.effect = moveResponse.effectEntries.filter { $0.language.name == "en" }
            .first?.effect ?? "There is no effect description for this move"
    }
}
