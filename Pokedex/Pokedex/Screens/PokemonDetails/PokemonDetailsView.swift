//
//  PokemonDetailsView.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 01/02/2024.
//

import SwiftUI

struct PokemonDetailsView: View {

    let pokemon : Pokemon

    var body: some View {
        ZStack(alignment: .center) {
//            pokemon.types.first?.color()
//                .ignoresSafeArea(.all)
            VStack {
                HStack {
                    Text("#\(String(format: "%03d", pokemon.id))")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    Spacer()
                }


                HStack(spacing:15) {
                    Text(pokemon.name)
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)


                    Spacer()

//                    Text(pokemon.shape)
//                        .foregroundColor(.white)
//                        .fontWeight(.bold)
                }

//                HStack {
//                    ForEach(pokemon.types, id: \.self) { type in
//                        PokemonTypeItemView(type: type)
//                    }
//
//                    Spacer()
//                }
            }.padding(20)

        }.navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    PokemonDetailsView(pokemon: .preview)
}
