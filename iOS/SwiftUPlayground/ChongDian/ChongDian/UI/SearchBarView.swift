//
//  SearchBarView.swift
//  SwiftUIDemo (iOS)
//
//  Created by Xiangbo Wang on 2022/9/16.
//

import SwiftUI
/// 简单的搜索栏
struct SearchBarView: View {
    
    @State var text: String
    
    var body: some View {
        SearchView(text: $text)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: "")
    }
}


// SearchBarView搜索栏视图

struct SearchView: View {

    @Binding var text: String
    @State private var offset: CGFloat = .zero // 使用.animation防止报错，iOS15的特性
    @State private var isEditing = false
    
    var body: some View {

        HStack {
            TextField("搜你想看的", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading).padding(.leading, 8)
                        
                        //编辑时显示清除按钮
                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                //点击时
                .onTapGesture {
                    self.isEditing = true
            }
            
            // 搜索按钮
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    // 收起键盘
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("搜索")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default, value: offset)
            }
        }
    }
}
