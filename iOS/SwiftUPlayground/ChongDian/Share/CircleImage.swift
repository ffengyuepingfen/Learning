//
//  CircleImage.swift
//  Landmarks
//
//  Created by JianjiaCoder on 2021/10/12.
//

import SwiftUI

struct CircleImage: View {
    
    var image: Image
    
    var body: some View {
        image
            .frame(width: 200, height: 200)
            .clipShape(Circle())
            // 添加边框
            .overlay(Circle().stroke(Color.white, lineWidth: 4.0))
            // 添加阴影
            .shadow(radius: 7.0)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("turtlerock"))
    }
}
