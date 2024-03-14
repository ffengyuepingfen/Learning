//
//  PokemonInfoRow.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/10.
//

import SwiftUI

import Kingfisher

struct PokemonInfoRow: View {
    
    let model: PokemonViewModel
//    @State var expanded: Bool
    let expanded: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image("Pokemon-\(model.id)")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 4)
                Spacer()
                VStack(alignment: .trailing) {
                    Text(model.name)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    Text(model.nameEN)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 12)
            Spacer()
            HStack(spacing: expanded ? 20 : -30) {
                Spacer()
                Button(action: {}) {
                    Image(systemName: "star")
                        .modifier(ToolButtonModifier())
                }
                Button(action: {}) {
                    Image(systemName: "chart.bar")
                        .modifier(ToolButtonModifier())
                }
                Button(action: {}) {
                    Image(systemName: "info.circle")
                        .modifier(ToolButtonModifier())
                }
            }
            .padding(.bottom, 12)
            .opacity(expanded ? 1 : 0.0)
            .frame(height: expanded ? .infinity : 0)
        }
        .frame(height: expanded ? 120 : 80)
        .padding(.leading, 23)
        .padding(.trailing, 15)
        .background(
            ZStack {
                // 添加边框
                RoundedRectangle(cornerRadius: 20)
                    .stroke(model.color, style: StrokeStyle(lineWidth: 4))
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.white, model.color]),
                            startPoint: .leading,
                            endPoint: .trailing)
                    )
            }
            
        )
        .padding(.horizontal)
//        .onTapGesture {
//            withAnimation(
//                .spring(
//                    response: 0.55,
//                    dampingFraction: 0.425,
//                    blendDuration: 0
//                )
//            ) {
//                self.expanded.toggle()
//            }
//        }
    }
}

/// View Modifier
/// 来避免这种对 View 的重复设置，那就是创建自定义的 ViewModifie
struct ToolButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25))
            .foregroundColor(.white)
            .frame(width: 30, height: 30)
    }
}

#if DEBUG
struct PokemonInfoRow_Previews: PreviewProvider {
    
    static var previews: some View {
        
        VStack {
            PokemonInfoRow(model: PokemonViewModel.sample(id: 1), expanded:false)
            PokemonInfoRow(model: PokemonViewModel.sample(id: 21), expanded: true)
            PokemonInfoRow(model: PokemonViewModel.sample(id: 25), expanded: false)
        }
    }
}
#endif


/*
 
 resizable()
    默认情况下，SwiftUI 中图片绘制与 frame 是无关的，而只会遵从图片本身的大小。如果我们想要图片可以按照所在的 frame 缩放，需要添加 resizable()
 
 aspectRatio()
 图片的原始尺寸比例和使用 frame(width:height:) 所设定的长宽比例可能有所不同。aspectRatio 让图片能够保持原始比例。不过在本例中，缩放前的图片长宽比也是 1:1，所以预览中不会有什么变化
 
 shadow()
 为图片增加一些阴影的视觉效果
 
 Image(systemName: "star")
 来加载系统内置的 SF Symbol
 可以使用 .font 来控制显示的大小
 .font(.system(size: 25)) 虽然可以控制图片的显示尺寸，但是它并不会改变 Image 本身的 frame。默认情况下的 frame.size 非常小，这会使按钮的可点击范围过小，因此我们使用 .frame(width:height:) 来指定尺寸。因为加载后的 SF Symbol 是 Image，配合 frame 使用上面处理图像时提到的 resizable 和 padding 来指定显示范围和可点击范围也是可以的，但直接设置 font 和 frame 会更简单一些
 
 在 SwiftUI 中，创建渐变非常简单。一般来说，分为两个步骤：

 // 1
 let gradient = Gradient(colors: [.white, model.color])
 // 2
 let gradientStyle = LinearGradient(
 gradient: gradient,startPoint: .leading,
 endPoint: .trailing)
 
 创建一个代表渐变数据的模型：Gradient，它基本就是一系列颜色。如果我们不明确指定颜色位置的话，输入的颜色将在渐变轴上等分。比如例子中的渐变起始位置和终止位置上分别是白色和宝可梦模型中定义的颜色。

 选取一个渐变 style，比如线性渐变 (LinearGradient)，径向渐变(RadialGradient) 或角度渐变 (AngularGradient)。将 1 中定义的 Gradient 和合适的渐变参数传入，就可以得到一个可适用于 Shape 上的渐变了。

 */
