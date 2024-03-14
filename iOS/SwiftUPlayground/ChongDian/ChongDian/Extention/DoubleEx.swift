//
//  DoubleEx.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/10.
//

import Foundation

extension Double {
    var rad: Double { return self * .pi / 180 }
    var deg: Double { return self * 180 / .pi }
}
