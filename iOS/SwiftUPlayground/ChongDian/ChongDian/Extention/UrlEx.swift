//
//  UrlEx.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/10.
//

import Foundation

extension URL {
    var extractedID: Int? {
        Int(lastPathComponent)
    }
}
