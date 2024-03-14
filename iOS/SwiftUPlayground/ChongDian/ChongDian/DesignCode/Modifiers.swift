//
//  Modifiers.swift
//  SwiftUIDemo (iOS)
//
//  Created by MacMini on 2022/9/7.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 10)
            .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
    }
}

struct FontModifier: ViewModifier {
    
    var style: Font.TextStyle
    
    func body(content: Content) -> some View {
        content
            .font(.system(style, design: .default))
    }
}
/// 自定义字体
/// 1、下载 引入相关字体
/// 2、info.plist 中进行登记
/// 3、在这里引用
struct CustomFontModifier: ViewModifier {
    
    var size: CGFloat = 25
    
    
    func body(content: Content) -> some View {
        content.font(.custom("font name", size: size))
    }
}
