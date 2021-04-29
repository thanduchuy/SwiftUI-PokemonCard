//
//  ContentViewUseCase.swift
//  PokemonCard
//
//  Created by than.duc.huy on 29/04/2021.
//

import Foundation

protocol ContentViewUseCaseType {
    func generatorPokemonData() -> [Pokemon]
    func changeVisible(data: [Pokemon], previousCard: Int, currentCard: Int) -> [Pokemon]
    func checkWin(data: [Pokemon]) -> Bool
}

struct ContentViewUseCase: ContentViewUseCaseType {
    func generatorPokemonData() -> [Pokemon] {
        [Pokemon(id: 1, image: "psyduck", isVisible: true),
         Pokemon(id: 2, image: "psyduck", isVisible: true),
         Pokemon(id: 3, image: "meowth", isVisible: true),
         Pokemon(id: 4, image: "meowth", isVisible: true),
         Pokemon(id: 5, image: "eevee", isVisible: true),
         Pokemon(id: 6, image: "eevee", isVisible: true),
         Pokemon(id: 7, image: "snorlax", isVisible: true),
         Pokemon(id: 8, image: "snorlax", isVisible: true),
         Pokemon(id: 9, image: "pikachu", isVisible: true),
         Pokemon(id: 10, image: "pikachu", isVisible: true),
         Pokemon(id: 11, image: "charmander", isVisible: true),
         Pokemon(id: 12, image: "charmander", isVisible: true)].shuffled()
    }
    
    func changeVisible(data: [Pokemon], previousCard: Int, currentCard: Int) -> [Pokemon] {
        data.map {
            var pokemon = $0
            pokemon.isVisible = pokemon.isVisible != true ? false : $0.id != previousCard && $0.id != currentCard
            return pokemon
        }
    }
    
    func checkWin(data: [Pokemon]) -> Bool {
        data.allSatisfy { !$0.isVisible }
    }
}
