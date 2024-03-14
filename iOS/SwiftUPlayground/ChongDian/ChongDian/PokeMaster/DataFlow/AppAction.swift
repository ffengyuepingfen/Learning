//
//  AppAction.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/10.
//

import Foundation

enum AppAction {
    // Settings
    case accountBehaviorButton(enabled: Bool)
    case accountBehaviorDone(result: Result<User, AppError>)

    case emailValid(valid: Bool)
    case register(email: String, password: String)
    case login(email: String, password: String)
    case logout
    case clearCache

    // Pokemon List
    case toggleListSelection(index: Int?)
    case togglePanelPresenting(presenting: Bool)

    case toggleFavorite(index: Int)

    case closeSafariView

    case loadPokemons
    case loadPokemonsDone(result: Result<[PokemonViewModel], AppError>)

    case loadAbilities(pokemon: Pokemon)
    case loadAbilitiesDone(result: Result<[AbilityViewModel], AppError>)

    // General
    case switchTab(index: AppState.MainTab.Index)
}
