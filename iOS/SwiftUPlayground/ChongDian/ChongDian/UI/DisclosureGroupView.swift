//
//  DisclosureGroupView.swift
//  SwiftUIDemo (iOS)
//
//  Created by Xiangbo Wang on 2022/9/16.
//

import SwiftUI
/// 构建一个FAQ页面
struct DisclosureGroupView: View {
    
    @State var isExpanded = Array(repeating: false, count: 3)
    
    private let FAQ = [
        (
            question: "如何把大象装进冰箱？",
            answer: "第一，先把冰箱打开。第二，把大象装进去。第三，把冰箱门关上。"
        ),
        
        (
            question: "如何把企鹅装进冰箱？",
            answer: "第一，先把冰箱打开。第二，把大象拿进去。第三，把企鹅装进去。第三，把冰箱门关上。"
        ),
        
        (
            question: "动物森林要举行动物大会，有一只动物缺席了，是什么动物？",
            answer: "企鹅，因为它在冰箱里面。"
        )
        
    ]
    
    var body: some View {
        List {
            ForEach(FAQ.indices, id: \.self) { index in
                DisclosureGroup(
                    isExpanded: $isExpanded[index],
                    content: {
                        //答案代码块
                        Text(FAQ[index].answer)
                            .font(.body)
                            .fontWeight(.light)
                    },
                    label: {
                        //问题代码块
                        Text(FAQ[index].question)
                            .font(.body)
                            .bold()
                    }
                ).padding()
            }
        }
    }
}

struct DisclosureGroupView_Previews: PreviewProvider {
    static var previews: some View {
        DisclosureGroupView()
    }
}
