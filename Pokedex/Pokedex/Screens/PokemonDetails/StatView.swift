//
//  StatView.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 04/02/2024.
//

import SwiftUI

struct StatView: View {
    let stat: Stat
    let barColor: Color

    @State private var progress = 0.0

    var body: some View {
        HStack {
            HStack {
                Text(stat.name)
                Spacer()
                Text("\(stat.baseStat)")
                    .fontWeight(.bold)
            }

            ProgressView(value: Float(progress) * Float(stat.baseStat),
                         total: 255)
                .tint(barColor)
                .progressViewStyle(LinearProgressViewStyle())
                .scaleEffect(x: 1, y: 4, anchor: .center)
        }
        .onAppear {
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 2)) {
                    progress = 1.0
                }
            }
        }
    }
}

#Preview {
    StatView(stat: Stat(name: "stat", baseStat: 125), barColor: .green)
}
