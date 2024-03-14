//
//  EmailCheckingRequest.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/10.
//

import Foundation
import Combine

struct EmailCheckingRequest {
    let email: String

    var publisher: AnyPublisher<Bool, Never> {
        Future<Bool, Never> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                if self.email.lowercased() == "onevcat@gmail.com" {
                    promise(.success(false))
                } else {
                    promise(.success(true))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
