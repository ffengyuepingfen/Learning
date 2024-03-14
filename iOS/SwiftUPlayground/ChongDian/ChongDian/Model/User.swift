//
//  User.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/10.
//

import Foundation

struct User: Codable {
    var email: String
    var favoritePokemonIDs: Set<Int>

    func isFavoritePokemon(id: Int) -> Bool {
        favoritePokemonIDs.contains(id)
    }
}
