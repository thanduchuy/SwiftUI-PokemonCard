//
//  BorderRadius.swift
//  PokemonCard
//
//  Created by than.duc.huy on 29/04/2021.
//
import SwiftUI
import Foundation

struct BorderRadius: ViewModifier {
    var radius: CGFloat
    var lineWidth: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                                .stroke(Color("darkRed"), lineWidth: lineWidth)
            )
            .background(Color.white)
            .cornerRadius(radius)
    }
}
