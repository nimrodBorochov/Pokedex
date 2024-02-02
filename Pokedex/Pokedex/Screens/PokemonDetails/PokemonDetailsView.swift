//
//  PokemonDetailsView.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 01/02/2024.
//

import SwiftUI

struct PokemonDetailsView: View {

    @Bindable var viewModel: PokemonExploreViewModel = PokemonExploreViewModel()

    var pokemonId: Int
    @State private var selectedTab = 0
    @State private var showShinny =  false

    var body: some View {
        ZStack(alignment: .top) {
            Color(.systemGreen)

            VStack {
                HStack {
                    Text("#\(String(format: "%03d", viewModel.currentPokemonDetails?.id ?? ""))")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    Spacer()
                }


                HStack(spacing:15) {
                    Text(viewModel.currentPokemonDetails?.name ?? "")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)


                    Spacer()

                }
            }.padding(20)

            ZStack {

                Circle()
                    .stroke()
                    .frame(width: 180, height: 180)

                AsyncImage(url: showShinny ?
                           viewModel.currentPokemonDetails?.frontShinyImageUrl :
                            viewModel.currentPokemonDetails?.frontDefaultImageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .onTapGesture {
                            showShinny.toggle()
                        }
                } placeholder: { ProgressView()}
            }
            .offset(x:0, y: 120)
            .zIndex(2)

            VStack {

                Picker("", selection: $selectedTab) {
                    Text("Abilities").tag(0)
                    Text("Stats").tag(1)
                    Text("Moves").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                List {
                    switch selectedTab {
                    case 0:

                        ForEach(viewModel.currentPokemonDetails?.abilities ?? [], id: \.self) { ability in
                            Text(ability)
                        }

                    case 1:
                        ForEach(viewModel.currentPokemonDetails?.stats ?? [], id: \.self.name) { stats in
                            HStack {
                                Text(stats.name)
                                Spacer()
                                Text(String(stats.rating))
                            }
                        }

                    case 2:

                        ForEach(viewModel.currentPokemonDetails?.moves ?? [], id: \.self) { move in
                            Text(move)
                        }

                    default :
                        EmptyView()
                    }
                }
                .foregroundColor(.green)
            }
            .padding(.top, 40)
            .padding(.horizontal)
            .background(.white)
            .cornerRadius(30)
            .offset(y:280)
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            print("im here")
            await viewModel.loadPokemonDetails(by: pokemonId)
        }

    }
}

#Preview {
    PokemonDetailsView(viewModel: PokemonExploreViewModel(networkClient: NetworkClient()), pokemonId: 1)
}
