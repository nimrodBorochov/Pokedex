//
//  AbilityView.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 03/02/2024.
//

import SwiftUI

struct AbilityView: View {

    let ability: Ability

    var body: some View {
        VStack {
            HStack {
                Text(ability.name)
                    .font(.headline)
                    .fontWeight(.bold)

                Spacer()
            }
            .padding()

            Text(ability.effect)
        }
        .padding()

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
