//
//  Ability.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/10.
//

import Foundation

struct Ability: Codable {
    struct Name: Codable, LanguageTextEntry {
        let language: Language
        let name: String

        var text: String { name }
    }

    struct FlavorTextEntry: Codable, LanguageTextEntry {
        let language: Language
        let flavorText: String

        var text: String { flavorText }
    }

    let id: Int

    let names: [Name]
    let flavorTextEntries: [FlavorTextEntry]
}
