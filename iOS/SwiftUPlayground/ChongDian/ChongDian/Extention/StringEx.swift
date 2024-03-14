//
//  StringEx.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/10.
//

import Foundation

extension String {
    var newlineRemoved: String {
        return split(separator: "\n").joined(separator: " ")
    }

    var isValidEmailAddress: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
