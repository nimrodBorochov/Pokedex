//
//  MoveView.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 03/02/2024.
//

import SwiftUI

struct MoveView: View {

    var move: Move

    var body: some View {
        VStack {
            HStack {
                Text(move.name)
                    .foregroundColor(.purple)
                    .font(.headline)

                Spacer()
            }
            .padding()
            .background(.purple.opacity(0.3))

            Text(move.effect)
        }
    }
}
