//
//  RingView.swift
//  SwiftUIDemo (iOS)
//
//  Created by MacMini on 2022/9/7.
//

import SwiftUI

struct RingView: View {
    
    var color1 = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
    var color2 = #colorLiteral(red: 0.8832267083, green: 0.8817368995, blue: 0.9077601482, alpha: 1)
    var width: CGFloat = 300
    var height: CGFloat = 300
    var percent: CGFloat = 88
    var delay: CGFloat = 0.0
    @Binding var show: Bool
    
    var body: some View {
        
        let mutiplier = width / 44
        
        let process = 1 - percent / 100
        
        ZStack {
            Circle()
                .stroke(
                    Color.black.opacity(0.1) ,
                    style: StrokeStyle(lineWidth: 5 * mutiplier)
                )
                .frame(width: width, height: height)
            
            Circle()
                .trim(from: show ? process : 1, to: 1)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing) ,
                    style: StrokeStyle(lineWidth: 5 * mutiplier,
                                       lineCap: .round,
                                       lineJoin: .round,
                                       miterLimit: .infinity,
                                       dash: [20, 0],
                                       dashPhase: 0)
                )
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .frame(width: width, height: height)
                .shadow(color: Color.blue.opacity(0.1), radius: 3 * mutiplier, x: 0, y: 3 * mutiplier)
                .animation(Animation.easeInOut.delay(delay), value: true)
            Text("\(Int(percent))%")
                .font(.system(size: 14 * mutiplier))
                .fontWeight(.bold)
                .onTapGesture {
                    self.show.toggle()
                }
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(show: .constant(true))
    }
}
