//
//  AppCommand.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/10.
//

import Foundation
import Combine
import Kingfisher

protocol AppCommand {
    func execute(in store: Store)
}

struct RegisterAppCommand: AppCommand {
    let email: String
    let password: String

    func execute(in store: Store) {
        _ = RegisterRequest(
            email: email,
            password: password
        ).publisher
        .sink(
            receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    store.dispatch(.accountBehaviorDone(result: .failure(error)))
                }
            },
            receiveValue: { user in
                store.dispatch(.accountBehaviorDone(result: .success(user)))
            }
        )
    }
}

struct LoginAppCommand: AppCommand {
    let email: String
    let password: String

    func execute(in store: Store) {
        _ = LoginRequest(
            email: email,
            password: password
        ).publisher
        .sink(
            receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    store.dispatch(.accountBehaviorDone(result: .failure(error)))
                }
            },
            receiveValue: { user in
                store.dispatch(.accountBehaviorDone(result: .success(user)))
            }
        )
    }
}

struct LoadPokemonsCommand: AppCommand {
    func execute(in store: Store) {
        _ = LoadPokemonRequest.all
            .sink(
                receiveCompletion: { complete in
                    if case .failure(let error) = complete {
                        store.dispatch(.loadPokemonsDone(result: .failure(error)))
                    }
                }, receiveValue: { value in
                    store.dispatch(.loadPokemonsDone(result: .success(value)))
                }
            )
    }
}

struct LoadAbilitiesCommand: AppCommand {

    let pokemon: Pokemon

    func load(pokemonAbility: Pokemon.AbilityEntry, in store: Store)
        -> AnyPublisher<AbilityViewModel, AppError>
    {
        if let value = store.appState.pokemonList.abilities?[pokemonAbility.id.extractedID!] {
            return Just(value)
                .setFailureType(to: AppError.self)
                .eraseToAnyPublisher()
        } else {
            return LoadAbilityRequest(pokemonAbility: pokemonAbility).publisher
        }
    }

    func execute(in store: Store) {
        _ = pokemon.abilities
            .map { load(pokemonAbility: $0, in: store) }
            .zipAll
            .sink(
                receiveCompletion: { complete in
                    if case .failure(let error) = complete {
                        store.dispatch(.loadAbilitiesDone(result: .failure(error)))
                    }
                },
                receiveValue: { value in
                    store.dispatch(.loadAbilitiesDone(result: .success(value)))
                }
            )
    }
}

struct ClearCacheCommand: AppCommand {
    func execute(in store: Store) {
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache()
    }
}
