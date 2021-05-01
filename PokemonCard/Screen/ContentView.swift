//
//  ContentView.swift
//  PokemonCard
//
//  Created by than.duc.huy on 29/04/2021.
//

import SwiftUI

enum ConstantContentView {
    static let sizeAvatar: CGFloat = 100
    static let sizeCard: CGFloat = 50
    static let radiuscard: CGFloat = 10
    static let radiusTopView: CGFloat = 20
    static let shadowRadius: CGFloat = 8
    static let spacingView: CGFloat = 15
    static var columns: [GridItem] { Array(repeating: .init(.flexible()), count: 3) }
}

struct ContentView: View {
    private var usecase = ContentViewUseCase()
    @State var pokemons = [Pokemon]()
    @State var previousCard = Pokemon(id: 0, image: "", isVisible: false)
    @State var currentCard = Pokemon(id: 0, image: "", isVisible: false)
    @State var point = 0
    @State var showAlert = false
    
    func eventFlipCard(item: Pokemon) {
        if previousCard.id == 0 {
            previousCard = item
        } else if currentCard.id == 0 {
            currentCard = item
        } else if previousCard.id == currentCard.id {
            previousCard.id = 0
            currentCard.id = 0
        }
        else {
            if previousCard.image == currentCard.image {
                point += 1
                pokemons = usecase.changeVisible(data: pokemons,
                                                 previousCard: previousCard.id,
                                                 currentCard: currentCard.id)
            }
            
            previousCard.id = 0
            currentCard.id = 0
        }
    }
    
    var body: some View {
        // MARK: Top View Pokemon Card.
        VStack {
            HStack(spacing: ConstantContentView.spacingView) {
                Spacer()
                
                Image("valor")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: ConstantContentView.sizeAvatar,
                           height: ConstantContentView.sizeAvatar,
                           alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .modifier(BorderRadius(radius: ConstantContentView.radiusTopView, lineWidth: 5))
                
                VStack(alignment: .leading,
                       spacing: ConstantContentView.spacingView) {
                    Text("Satoshi")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .foregroundColor(.white)
                    
                    Text("\(point)")
                        .font(.system(size: 40, weight: .black, design: .default))
                        .foregroundColor(.white)
                    
                    Text("Let's go catch pokemon")
                        .font(.caption)
                        .foregroundColor(Color.white.opacity(0.8))
                }
                
                Spacer()
            }
            .padding()
            .padding(.vertical, ConstantContentView.spacingView)
            .background(Color("lightRed"))
            .cornerRadius(ConstantContentView.radiusTopView)
            .padding()
            .padding(.top, ConstantContentView.spacingView + 10)
            .shadow(radius: ConstantContentView.shadowRadius)

            
            LazyVGrid(columns: ConstantContentView.columns,
                      alignment: .center,
                      spacing: ConstantContentView.spacingView) {
                ForEach(pokemons, id: \.id) { item in
                    PokemonCard(pokemon: item, flip: (item.id == previousCard.id || item.id == currentCard.id))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.5)) {
                                eventFlipCard(item: item)
                            }
                        }
                        .rotation3DEffect(.init(degrees: (item.id == previousCard.id || item.id == currentCard.id) ? 180 : 0),
                                          axis: (x: 0.0, y: 1.0, z: 0.0),
                                          anchor: .center,
                                          anchorZ: 0.0,
                                          perspective: 1.0)
                        .opacity(item.isVisible ? 1 : 0)
                        .disabled(!item.isVisible)
                }
            }
            .padding()
            .padding(.vertical, ConstantContentView.spacingView)
            .background(Color("pink"))
            .cornerRadius(ConstantContentView.radiusTopView)
            .padding()
            .shadow(radius: ConstantContentView.shadowRadius)
            
            Spacer()
        }
        .background(Color("background"))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            pokemons = usecase.generatorPokemonData()
        }
        .onChange(of: pokemons) {
            showAlert = usecase.checkWin(data: $0)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("You win!!!"),
                  message: Text("Do you want to play again?"),
                  dismissButton: .default(Text("OK"),
                                          action: {
                                            showAlert = false
                                            pokemons = usecase.generatorPokemonData()
                                          }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
