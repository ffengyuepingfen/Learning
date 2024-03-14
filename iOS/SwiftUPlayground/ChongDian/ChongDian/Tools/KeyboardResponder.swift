//
//  KeyboardResponder.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/11.
//

import SwiftUI
import Combine

class KeyboardResponder: ObservableObject {
    @Published var currentHeight: CGFloat = 0

    var keyboardWillShowPublisher: AnyPublisher<CGFloat, Never> {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { notification in
                notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect
            }
            .map { $0.height }
            .eraseToAnyPublisher()
    }

    var keyboardWillHidePublisher: AnyPublisher<CGFloat, Never> {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in 0 }
            .eraseToAnyPublisher()
    }

    init() {
        _ = keyboardWillShowPublisher.merge(with: keyboardWillHidePublisher)
            .subscribe(on: DispatchQueue.main)
            .assign(to: \.currentHeight, on: self)
    }
}
