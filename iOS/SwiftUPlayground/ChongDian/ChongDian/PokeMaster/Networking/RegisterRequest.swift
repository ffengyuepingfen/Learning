//
//  RegisterRequest.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/10.
//

import Foundation
import Combine

struct RegisterRequest {
    let email: String
    let password: String

    var publisher: AnyPublisher<User, AppError> {
        Future { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
                let r = Double.random(in: 0..<1)
                if r <= 0.5 {
                    let user = User(email: self.email, favoritePokemonIDs: [])
                    promise(.success(user))
                } else {
                    promise(.failure(.alreadyRegistered))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
