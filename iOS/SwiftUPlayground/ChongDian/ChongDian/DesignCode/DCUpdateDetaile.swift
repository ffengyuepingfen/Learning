//
//  DCUpdateDetaile.swift
//  SwiftUIDemo (iOS)
//
//  Created by MacMini on 2022/9/7.
//

import SwiftUI

struct DCUpdateDetaile: View {
    
    var update: DCUpdate = updateData[1]
    
    var body: some View {
        List {
            VStack(spacing: 20) {
                Image(update.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                Text(update.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .navigationTitle(update.title)
        }
        .listStyle(.grouped)
    }
}

struct DCUpdateDetaile_Previews: PreviewProvider {
    static var previews: some View {
        DCUpdateDetaile()
    }
}
