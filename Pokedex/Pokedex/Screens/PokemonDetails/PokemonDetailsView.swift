//
//  PokemonDetailsView.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 01/02/2024.
//

import SwiftUI

struct PokemonDetailsView: View {

    @Bindable var viewModel: PokemonDetailsViewModel

    var pokemonId: Int

    var body: some View {
        ZStack(alignment: .top) {
            Color(viewModel.primaryTypeColor)
            if (viewModel.loading) {
                ProgressView()
            } else {
                ScrollView {
                    DetailsHeader

                    PokemonInteractiveImage
                        .zIndex(2)

                    DetailsPicker
                        .cornerRadius(30)
                        .offset(y:-40)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Toolbar
        }
        .alert("Do you want to catch this Pokemon?", isPresented: $viewModel.showAlert) {
            TextField("nickname", text: $viewModel.nickname)
                .autocorrectionDisabled()
            Button("OK"){ Task { viewModel.addToFavorites() } }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Please enter Pokemon nickname.")
        }
        .task {
            await viewModel.loadPokemonDetails(by: pokemonId)
        }
    }

    var DetailsHeader: some View {
        VStack {
            HStack {
                Text(viewModel.pokemonIndex)
                    .foregroundColor(viewModel.primaryColor)
                    .fontWeight(.bold)

                Spacer()

            }

            HStack(spacing:15) {
                Text(viewModel.pokemon?.name ?? "")
                    .foregroundColor(viewModel.primaryColor)
                    .font(.title)
                    .fontWeight(.bold)

                Spacer()
            }
        }
        .padding(20)
    }

    var PokemonInteractiveImage: some View {
        ZStack {
            Circle()
                .stroke(Color(viewModel.primaryColor).opacity(0.5))
                .frame(width: 180, height: 180)

            AsyncImage(url: viewModel.showShinny ?
                       viewModel.pokemon?.frontShinyImageUrl :
                        viewModel.pokemon?.frontDefaultImageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .onTapGesture {
                        viewModel.showShinny.toggle()
                    }
            } placeholder: { ProgressView()}
        }

    }

    var DetailsPicker: some View {
        VStack {
            Picker("", selection: $viewModel.selectedTab) {
                Text("Abilities").tag(0)
                Text("Stats").tag(1)
                Text("Moves").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())

            LazyVStack {
                switch viewModel.selectedTab {
                case 0:
                    ForEach(viewModel.pokemon?.abilities ?? []) { ability in
                        AbilityView(ability: ability)
                            .background(Color(viewModel.primaryTypeColor))
                            .foregroundColor(viewModel.primaryColor)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                    }

                case 1:
                    ForEach(viewModel.pokemon?.stats ?? []) { stat in
                        StatView(stat: stat, barColor:Color( viewModel.primaryTypeColor))
                        .foregroundColor(viewModel.primaryColor)                    }

                case 2:
                    ForEach(viewModel.pokemon?.moves ?? []) { move in
                        MoveView(move: move)
                            .background(Color(viewModel.primaryTypeColor))
                            .foregroundColor(viewModel.primaryColor)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                    }

                default :
                    EmptyView()
                }

            }
            .padding()

            Spacer()
        }
        .padding(.top, 40)
        .padding(.horizontal)
        .background(.white.opacity(0.5))
    }

    private var Toolbar: some View {
        Button(action: {
            viewModel.showAlert.toggle()
        }, label: {
            Label("Catch", systemImage: "cricket.ball.fill")
        })
    }
}

#Preview {
    NavigationView {
        PokemonDetailsView(viewModel: PokemonDetailsViewModel(networkClient: NetworkClient()), pokemonId: 1)
    }
}
