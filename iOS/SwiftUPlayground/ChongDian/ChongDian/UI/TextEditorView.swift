//
//  TextEditorView.swift
//  SwiftUIDemo (iOS)
//
//  Created by Xiangbo Wang on 2022/9/16.
//

import SwiftUI
/// 多行文本
struct TextEditorView: View {
    @State private var message = ""
    
    @State private var wordCount: Int = 0
    
    var body: some View {
        
        ZStack {
            VStack {
                
                Text("\(wordCount)")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
                    .padding(.trailing)

                
                TextEditor(text: $message)
                    .font(.title)
                    .lineSpacing(20)    // 行距
                    .autocapitalization(.words)
                    .disableAutocorrection(true)
                    .padding()
                    .onChange(of: message) { _ in
                        let words = message.split { $0 == " " || $0.isNewline }
                        self.wordCount = words.count
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
            
            // 注释文字
            if message.isEmpty {
                Text("请输入内容")
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(15)
            }
        }
        .padding()
    }
}

struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView()
    }
}
