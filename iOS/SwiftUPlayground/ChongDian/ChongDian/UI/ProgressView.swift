//
//  ProgressView.swift
//  SwiftUIDemo (iOS)
//
//  Created by Xiangbo Wang on 2022/9/17.
//

import SwiftUI

struct ProgressView: View {
    
    var thickness: CGFloat = 30.0
    var width: CGFloat = 250.0
    var startAngle: CGFloat = -90
    
    @State var progress = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color(.systemGray6),lineWidth: thickness)
                //内环
                RingShape(progress: progress, thickness: thickness)
                    .fill(AngularGradient(gradient: Gradient(colors: [.pink, .yellow]), center: .center, startAngle: .degrees(startAngle), endAngle: .degrees(360 * progress + startAngle)))
            }
            .frame(width: width, height: width, alignment: .center)
            .animation(Animation.easeInOut(duration: 1.0),value: progress)
            
            //进度调节
            HStack {
                Group {

                Text("0%")
                    .font(.system(.headline, design: .rounded))
                    .onTapGesture {
                self.progress = 0.0
            }

                Text("50%")
                    .font(.system(.headline, design: .rounded))
                    .onTapGesture {
                self.progress = 0.5
            }

                Text("100%")
                    .font(.system(.headline, design: .rounded))
                    .onTapGesture {
                self.progress = 1.0
            }
            }
            .padding()
                    .background(Color(.systemGray6)).clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                    .padding()
            }
            .padding()
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}


//内环
struct RingShape: Shape {
    
    var progress: Double = 0.0
    var thickness: CGFloat = 30.0
    var startAngle: Double = -90.0
    // 我们在实现RingShape内环构建的过程中，它符合Shape协议，
    // 而恰巧是Shape协议它有一个默认的动画，也就是没有数据的动画。
    // 要解决这个问题也很简单，我们只需要在构建RingShape内环时，赋予progress新的值就可以了
    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.width / 2.0, y: rect.height / 2.0), radius: min(rect.width, rect.height) / 2.0,startAngle: .degrees(startAngle),endAngle: .degrees(360 * progress+startAngle), clockwise: false)
        
        return path.strokedPath(.init(lineWidth: thickness, lineCap: .round))
    }
}

/**
 AngularGradient角梯度，AngularGradient角梯度是SwiftUI提供的一种绘制渐变色的方法，可以跟随不同角度变化，从起点到终点，颜色按顺时针做扇形渐变
 
 AngularGradient(gradient: Gradient(colors: [.gradientPink, .gradientYellow]), center: .center, startAngle: .degrees(startAngle), endAngle: .degrees(360 * 0.3 + startAngle))
 */
