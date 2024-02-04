//
//  AbilityView.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 03/02/2024.
//

import SwiftUI

struct AbilityView: View {

    var ability: Ability

    var body: some View {
        VStack {
            HStack {
                Text(ability.name)
                    .foregroundColor(.purple)
                    .font(.headline)

                Spacer()
            }
            .padding()
            .background(.purple.opacity(0.3))

            Text(ability.effect)
        }
    }
}

#Preview {
    AbilityView(
        ability: Ability(
            abilityResponse: AbilityResponse(
                name: "overgrow",
                effectEntries: [
                    EffectEntries(
                        effect: "When this Pokémon has 1/3 or less of its HP remaining, its grass-type moves inflict 1.5× as much regular damage.",
                        language: NamedAPIResource(
                            name: "en",
                            url: ""
                        )
                    )
                ]
            )
        )
    )
}
