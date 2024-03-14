//
//  Store.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/10.
//

import Foundation
import Combine

class Store: ObservableObject {

    @Published var appState = AppState()

    var disposeBag = DisposeBag()

    init() {
        setupObservers()
    }

    func setupObservers() {
        appState.settings.checker.isValid.sink { isValid in
            self.dispatch(.accountBehaviorButton(enabled: isValid))
        }.add(to: disposeBag)

        appState.settings.checker.isEmailValid.sink { isValid in
            self.dispatch(.emailValid(valid: isValid))
        }.add(to: disposeBag)
    }

    func dispatch(_ action: AppAction) {
        print("[ACTION]: \(action)")
        let result = Store.reduce(state: appState, action: action)
        appState = result.0
        if let command = result.1 {
            print("[COMMAND]: \(command)")
            command.execute(in: self)
        }
    }

    static func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?) {
        var appState = state
        var appCommand: AppCommand? = nil

        switch action {
        case .accountBehaviorButton(let isValid):
            appState.settings.isValid = isValid

        case .emailValid(let isValid):
            appState.settings.isEmailValid = isValid

        case .register(let email, let password):
            appState.settings.registerRequesting = true
            appCommand = RegisterAppCommand(email: email, password: password)

        case .login(let email, let password):
            appState.settings.loginRequesting = true
            appCommand = LoginAppCommand(email: email, password: password)

        case .logout:
            appState.settings.loginUser = nil

        case .accountBehaviorDone(let result):
            appState.settings.registerRequesting = false
            appState.settings.loginRequesting = false

            switch result {
            case .success(let user):
                appState.settings.loginUser = user
            case .failure(let error):
                appState.settings.loginError = error
            }

        case .toggleListSelection(let index):
            let expanding = appState.pokemonList.selectionState.expandingIndex
            if expanding == index {
                appState.pokemonList.selectionState.expandingIndex = nil
                appState.pokemonList.selectionState.panelPresented = false
                appState.pokemonList.selectionState.radarProgress = 0
            } else {
                appState.pokemonList.selectionState.expandingIndex = index
                appState.pokemonList.selectionState.panelIndex = index
                appState.pokemonList.selectionState.radarShouldAnimate =
                    appState.pokemonList.selectionState.radarProgress == 1 ? false : true
            }
            
        case .togglePanelPresenting(let presenting):
            appState.pokemonList.selectionState.panelPresented = presenting
            appState.pokemonList.selectionState.radarProgress = presenting ? 1 : 0

        case .toggleFavorite(let index):
            guard let loginUser = appState.settings.loginUser else {
                appState.pokemonList.favoriteError = .requiresLogin
                break
            }

            var newFavorites = loginUser.favoritePokemonIDs
            if newFavorites.contains(index) {
                newFavorites.remove(index)
            } else {
                newFavorites.insert(index)
            }
            appState.settings.loginUser!.favoritePokemonIDs = newFavorites

        case .closeSafariView:
            appState.pokemonList.isSFViewActive = false

        case .switchTab(let index):
            appState.pokemonList.selectionState.panelPresented = false
            appState.mainTab.selection = index

        case .loadPokemons:
            if appState.pokemonList.loadingPokemons {
                break
            }
            appState.pokemonList.pokemonsLoadingError = nil
            appState.pokemonList.loadingPokemons = true
            appCommand = LoadPokemonsCommand()

        case .loadPokemonsDone(let result):
            appState.pokemonList.loadingPokemons = false

            switch result {
            case .success(let models):
                appState.pokemonList.pokemons =
                    Dictionary(uniqueKeysWithValues: models.map { ($0.id, $0) })
            case .failure(let error):
                appState.pokemonList.pokemonsLoadingError = error
            }

        case .loadAbilities(let pokemon):
            appCommand = LoadAbilitiesCommand(pokemon: pokemon)

        case .loadAbilitiesDone(let result):
            switch result {
            case .success(let loadedAbilities):
                var abilities = appState.pokemonList.abilities ?? [:]
                for ability in loadedAbilities {
                    abilities[ability.id] = ability
                }
                appState.pokemonList.abilities = abilities
            case .failure(let error):
                print(error)
            }

        case .clearCache:
            appState.pokemonList.pokemons = nil
            appState.pokemonList.abilities = nil
            appCommand = ClearCacheCommand()
        }
        return (appState, appCommand)
    }
}

class DisposeBag {
    private var values: [AnyCancellable] = []
    func add(_ value: AnyCancellable) {
        values.append(value)
    }
}

extension AnyCancellable {
    func add(to bag: DisposeBag) {
        bag.add(self)
    }
}
