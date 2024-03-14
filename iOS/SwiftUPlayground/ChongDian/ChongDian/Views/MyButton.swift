//
//  MyButton.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/9.
//

import SwiftUI

struct MyButton: View {
    let label: String
    var font: Font = .title
    var textColor: Color = .white
    let action: () -> ()

    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            Text(label)
                .font(font)
                .padding(10)
                .frame(width: 70)
                .background(
                    RoundedRectangle(cornerRadius:10)
                        .foregroundColor(Color.green).shadow(radius: 2))
                        .foregroundColor(textColor)

        })
    }
}

struct MyButton_Previews: PreviewProvider {
    static var previews: some View {
        MyButton(label: "点我", action: {
            
        })
    }
}
