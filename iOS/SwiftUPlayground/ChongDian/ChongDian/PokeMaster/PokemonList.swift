//
//  PokemonList.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/10.
//

import SwiftUI

struct PokemonList: View {

//    @EnvironmentObject var store: Store

//    var pokemonList: AppState.PokemonList { store.appState.pokemonList }

    @State var expandingIndex: Int?
    
    var body: some View {
        
        ScrollView {
            ForEach(PokemonViewModel.all) { pokemon in
                PokemonInfoRow(model: pokemon, expanded: self.expandingIndex == pokemon.id)
                    .onTapGesture {
                        withAnimation(
                            .spring(
                                response: 0.55,
                                dampingFraction: 0.425,
                                blendDuration: 0
                            )
                        ) {
                            if self.expandingIndex == pokemon.id {
                                self.expandingIndex = nil
                            }else{
                                self.expandingIndex = pokemon.id
                            }
                        }
                    }
            }
        }
        .overlay(
            VStack{
                Spacer()
//                PokemonInfoPanel()
            }
        )
    }
}

#if DEBUG
struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
#endif

/*
 overlay 在当前 View (ScrollView) 上方添加一层另外的 View。它的行为和 ZStack 比较相似，只不过 overlay 会尊重它下方的原有 View 的布局，而不像 ZStack 中的 View 那样相互没有约束。不过对于我们这个例子，overlay 和 ZStack 的行为没有区别，这里选择 overlay 纯粹是因为嵌套少一些，语法更简单。

 iPhone X 系列的设备引入了 safe area 的概念，SwiftUI 中自定义的一般 View 是以 safe area 为布局边界的。如果我们想要弹出面板覆盖屏幕底部，需要明确指出忽略 safe area。
 */
