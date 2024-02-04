//
//  BackgroundAnimation.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 04/02/2024.
//

import SwiftUI

struct BackgroundAnimation: View {
    @State var animate = false

    var body: some View {
        CircleBackground()
            .blur(radius: animate ? 30 : 100)
            .offset(
                x: animate ? -50 : -130,
                y: animate ? -30 : -100
            )
            .task {
                withAnimation(
                    .easeInOut(duration: 7).repeatForever()) {
                        animate.toggle()
                    }
            }

        CircleBackground(color: .pink)
            .blur(radius: animate ? 30 : 100)
            .offset(
                x: animate ? 100 : 130,
                y: animate ? 150 : 100
            )
    }
}

struct CircleBackground: View {
    @State var color: Color = .yellow

    var body: some View {
        Circle()
            .frame(width: 300, height: 300)
            .foregroundColor(color)
    }
}

#Preview {
    BackgroundAnimation()
}
