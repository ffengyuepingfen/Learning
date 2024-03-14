//
//  CustomBackItem.swift
//  SwiftUIDemo (iOS)
//
//  Created by MacMini on 2022/9/16.
//

import SwiftUI

/// 自定义返回按钮
/// 1、首先隐藏系统的返回按钮
/// 2、SwiftUI提供了(.presentationMode)内置环境值，我们可以用这个环境值实现返回到前一个视图的操作
struct CustomBackItem: View {
    
    // 环境值
    // SwiftUI提供了(.presentationMode)内置环境值，我们可以用这个环境值实现返回到前一个视图的操作
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        List {
            Text("Hello, World!")
        }
        // 隐藏系统的返回按钮
        .navigationBarBackButtonHidden(true)
        // 添加自定义的按钮
        .navigationBarItems(leading:
                                Button(action : {
            // 点击按钮后的操作
            self.mode.wrappedValue.dismiss()
        }){
            //按钮及其样式
            Image(systemName: "chevron.left")
                .foregroundColor(.gray)
        })
    }
}

struct CustomBackItem_Previews: PreviewProvider {
    static var previews: some View {
        CustomBackItem()
    }
}
