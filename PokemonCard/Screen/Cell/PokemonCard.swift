//
//  PokemonCardCell.swift
//  PokemonCard
//
//  Created by than.duc.huy on 29/04/2021.
//

import SwiftUI

struct PokemonCard: View {
    var pokemon: Pokemon
    var flip: Bool
    var body: some View {
        ZStack {
            Image(pokemon.image)
                .resizable()
                .frame(width: ConstantContentView.sizeCard,
                       height: ConstantContentView.sizeCard,
                       alignment: .center)
                .modifier(BorderRadius(radius: ConstantContentView.radiuscard, lineWidth: 3))
                .shadow(radius: ConstantContentView.shadowRadius)
                .opacity(flip ? 1 : 0)
            
            Image("pokeball")
                .resizable()
                .frame(width: ConstantContentView.sizeCard,
                       height: ConstantContentView.sizeCard,
                       alignment: .center)
                .modifier(BorderRadius(radius: ConstantContentView.radiuscard, lineWidth: 3))
                .shadow(radius: ConstantContentView.shadowRadius)
                .opacity(flip ? 0 : 1)
        }
    }
}
