//
//  User.swift
//  loginIn
//
//  Created by Laowang on 2024/3/13.
//

import Foundation

struct User: Equatable, Identifiable {
    
    let id = UUID()
    
    var name: String
    var image: String
    
    static let empty = User(name: "匿名", image: "person.fill")
}
