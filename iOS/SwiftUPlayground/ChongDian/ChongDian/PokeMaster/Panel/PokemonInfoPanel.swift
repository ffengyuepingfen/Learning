//
//  PokemonInfoPanel.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/10.
//

import SwiftUI
import Kingfisher

struct PokemonInfoPanel: View {

//    @EnvironmentObject var store: Store

//    @Environment(\.colorScheme) var colorScheme

    let model: PokemonViewModel
    var abilities: [AbilityViewModel]? {
        AbilityViewModel.sample(pokemonID: model.id)
//        store.appState.pokemonList.abilityViewModels(for: model.pokemon)
    }

    var topIndicator: some View {
        RoundedRectangle(cornerRadius: 3)
            .frame(width: 40, height: 6)
            .opacity(0.2)
    }

//    var pokemonDescription: some View {
//        Text(model.descriptionText)
//        .font(.callout)
//        .foregroundColor(
//            colorScheme == .light ? Color(hex: 0x666666) : Color(hex: 0xAAAAAA)
//        )
//        .fixedSize(horizontal: false, vertical: true)
//    }

    var body: some View {
        VStack(spacing: 20) {
            topIndicator
//            Group {
//                Header(model: model)
//                pokemonDescription
//            }.animation(nil)
//            //(nil) // Fix for text animation which causes it round cornered...
//            Divider()
//            HStack(spacing: 20) {
//                AbilityList(
//                    model: model,
//                    abilityModels: abilities
//                )
//                RadarView(
//                    values: model.pokemon.stats.map { $0.baseStat },
//                    color: model.color,
//                    max: 120,
//                    progress: CGFloat(store.appState.pokemonList.selectionState.radarProgress),
//                    shouldAnimate: store.appState.pokemonList.selectionState.radarShouldAnimate
//                )
//                    .frame(width: 100, height: 100)
//            }
        }
//        .padding(.top, 12)
//        .padding(.bottom, 30)
//        .padding(.horizontal, 30)
//        .blurBackground(style: .systemMaterial)
//        .cornerRadius(20)
//        .fixedSize(horizontal: false, vertical: true)
    }
}

#if DEBUG
struct PokemonInfoPanel_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoPanel(model: .sample(id: 1))
//            .environmentObject(Store.sample)
    }
}
#endif

/*
 pokemonDescription 中最后一行的 fixedSize 修饰符用来告诉 SwiftUI 保持 View 的理想尺寸，让它不被上层 View “截断”。对于 Text，默认情况下是可以显示多行文本，而不会被截断或者限制。但是，在某些情况下 Text 的行为会被改变，而让本应多行的文本被显示为单行 (比如在 Xcode 11.1 中，发生拖拽时文本就无法完全显示，这大概率是 SwiftUI 的 bug)，通过 .fixedSize(horizontal: false, vertical: true)，可以在竖直方向上显示全部文本，同时在水平方向上保持按照上层 View 的限制来换行。
 */
extension PokemonInfoPanel {
    struct AbilityList: View {

        let model: PokemonViewModel
        let abilityModels: [AbilityViewModel]?

        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("技能")
                    .font(.headline)
                    .fontWeight(.bold)
                if abilityModels != nil {
                    ForEach(abilityModels!) { ability in
                        Text(ability.name)
                            .font(.subheadline)
                            .foregroundColor(self.model.color)
                        Text(ability.descriptionText)
                            .font(.footnote)
                            .foregroundColor(Color(hex: 0xAAAAAA))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

extension PokemonInfoPanel {
    struct Header: View {

        let model: PokemonViewModel

        var body: some View {
            HStack(spacing: 18) {
                pokemonIcon
                nameSpecies
                verticalDivider
                VStack(spacing: 12) {
                    bodyStatus
                    typeInfo
                }
            }
        }

        var pokemonIcon: some View {
            KFImage(model.iconImageURL)
                .resizable()
                .frame(width: 68, height: 68)
        }

        var nameSpecies: some View {
            VStack(spacing: 10) {
                VStack {
                    Text(model.name)
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .foregroundColor(model.color)
                    Text(model.nameEN)
                        .font(.system(size: 13))
                        .fontWeight(.bold)
                        .foregroundColor(model.color)
                }
                Text(model.genus)
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            }
        }

        var verticalDivider: some View {
            RoundedRectangle(cornerRadius: 1)
                .frame(width: 1, height: 44)
                .opacity(0.1)
        }

        var bodyStatus: some View {
            VStack(alignment: .leading) {
                HStack {
                    Text("身高")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                    Text(model.height)
                        .font(.system(size: 11))
                        .foregroundColor(model.color)
                }
                HStack {
                    Text("体重")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                    Text(model.weight)
                        .font(.system(size: 11))
                        .foregroundColor(model.color)
                }
            }
        }

        var typeInfo: some View {
            HStack {
                ForEach(self.model.types) { t in
                    ZStack {
                        RoundedRectangle(cornerRadius: 7)
                            .fill(t.color)
                            .frame(width: 36, height: 14)
                        Text(t.name)
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

//#if DEBUG
//struct PokemonInfoPanelHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        PokemonInfoPanel.Header(model: .sample(id: 1))
//    }
//}
//#endif
