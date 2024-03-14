//
//  PokeMasterHome.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/10.
//

import SwiftUI

struct PokeMasterHome: View {
    
    @EnvironmentObject var appData: AppModel

    private var pokemonList: AppState.PokemonList {
        appData.store.appState.pokemonList
    }
    private var pokemonListBinding: Binding<AppState.PokemonList> {
        $appData.store.appState.pokemonList
    }

    private var selectedPanelIndex: Int? {
        pokemonList.selectionState.panelIndex
    }
    
    var body: some View {
        if appData.store.appState.pokemonList.pokemons == nil {
            if appData.store.appState.pokemonList.pokemonsLoadingError != nil {
                RetryButton {
                    self.appData.store.dispatch(.loadPokemons)
                }.offset(y: -40)
            } else {
                LoadingView()
                    .offset(y: -40)
                    .onAppear {
                        self.appData.store.dispatch(.loadPokemons)
                    }
            }
        } else {
            PokemonList()
                .navigationBarTitle("宝可梦列表")
                .edgesIgnoringSafeArea(.top)
                .overlaySheet(isPresented: pokemonListBinding.selectionState.panelPresented) {
                    if self.selectedPanelIndex != nil && self.pokemonList.pokemons != nil {
                        PokemonInfoPanel(
                            model: self.pokemonList.pokemons![self.selectedPanelIndex!]!
                        )
                    }
                }
        }
    }

    struct RetryButton: View {

        let block: () -> Void

        var body: some View {
            Button(action: {
                self.block()
            }) {
                HStack {
                    Image(systemName: "arrow.clockwise")
                    Text("Retry")
                }
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.gray)
                .padding(6)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray)
                )
            }
        }
    }

}

struct PokeMasterHome_Previews: PreviewProvider {
    static var previews: some View {
        PokeMasterHome().environmentObject(AppModel())
    }
}
