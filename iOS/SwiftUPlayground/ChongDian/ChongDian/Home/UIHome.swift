//
//  UIHome.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/9.
//

import SwiftUI

struct UIHome: View {
    var body: some View {
        
        List {
            Section(header: Text("Part 1: Path Animations")) {
                NavigationLink(destination: {
//                    AnimationList()
                }, label: {
                    Text("SwiftUI -- 动画")
                })
                
                NavigationLink(destination: {
                    CustomBackItem()
                }, label: {
                    Text("SwiftUI -- 自定义返回按钮")
                })
                
                NavigationLink(destination: {
                    FormView()
                }, label: {
                    Text("SwiftUI -- 表单")
                })
                
                NavigationLink(destination: {
                    SwipeCardView()
                }, label: {
                    Text("SwiftUI -- SwipeCardView")
                })
                
                NavigationLink(destination: {
                    CoreDataView()
                }, label: {
                    Text("SwiftUI -- CoreDataView")
                })
            }
            
            Section(header: Text("更新中...")) {
                
            }
        }
    }
}

struct UIHome_Previews: PreviewProvider {
    static var previews: some View {
        UIHome()
    }
}
