//
//  BannerView.swift
//  SwiftUIDemo (iOS)
//
//  Created by Xiangbo Wang on 2022/9/16.
//

import SwiftUI

struct BannerView: View {
    @State var currentIndex = 0
    @GestureState var dragOffset: CGFloat = 0
    @State private var offset: CGFloat = .zero
    @State var isShowDetailView = false
    
    var body: some View {
        
        ZStack {
            
            //首页轮播图
            GeometryReader { outerView in
                HStack(spacing: 0) {
                    ForEach(imageModels.indices, id: \.self) { index in
                        GeometryReader { innerView in
                            let model = imageModels[index]
                            
                            CardView2(image: model.image, imageName: model.imageName)
                            
                            //如果点击就图片就移上去
                                .offset(y: self.isShowDetailView ? -innerView.size.height * 0.3 : 0)
                        }
                        
                        //如果点击图片两边就不留边距
                        .padding(.horizontal, self.isShowDetailView ? 0 : 20)
                        .opacity(self.currentIndex == index ? 1.0 : 0.7)
                        
                        //如果点击就图片调整大小
                        .frame(width: outerView.size.width, height: self.currentIndex == index ? (self .isShowDetailView ? outerView.size.height : 250) : 200)
                        
                        //点击进入详情页
                        .onTapGesture {
                            self.isShowDetailView = true
                        }
                    }
                }
                .frame(width: outerView.size.width, height: outerView.size.height, alignment: .leading)
                .offset(x: -CGFloat(self.currentIndex) * outerView.size.width)
                .offset(x: self.dragOffset)
                
                // 拖动事件
                .gesture(
                    
                    //如果没有被点击
                    !self.isShowDetailView ?
                    
                    DragGesture()
                        .updating(self.$dragOffset, body: { value, state, transaction in
                            state = value.translation.width
                        })
                        .onEnded({ value in
                            let threshold = outerView.size.width * 0.65
                            var newIndex = Int(-value.translation.width / threshold) + self.currentIndex
                            newIndex = min(max(newIndex, 0), imageModels.count - 1)
                            self.currentIndex = newIndex
                        })
                    
                    : nil
                )
            }
            .animation(.interpolatingSpring(mass: 0.6, stiffness: 100, damping: 10, initialVelocity: 0.3),value: offset)
            
            //详情页
            if self.isShowDetailView {
                
                DetailView(imageName: imageModels[currentIndex].imageName)
                    .offset(y: 200)
                    .transition(.move(edge: .bottom))
                    .animation(.interpolatingSpring(mass: 0.5, stiffness: 100, damping: 10, initialVelocity: 0.3),value: offset)
                
                //关闭按钮
                Button(action: {
                    self.isShowDetailView = false
                }) {
                    
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.black)
                        .opacity(0.7)
                        .contentShape(Rectangle())
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topTrailing)
                .padding(.trailing)
            }
        }
    }
}

struct BannerView_Previews: PreviewProvider {
    static var previews: some View {
        BannerView()
    }
}

/**
 
 GeometryReader几何容器简单来说，就是一个View，但不同的是，它的宽高是通过自动判断你的设备的屏幕尺寸的定的。这样，假设我们有一张4000*4000分辨率的图片的时候，我们就不用再设置它在屏幕中展示的固定大小了，屏幕多少，里面的图片就可以自动设置多大。
 */

struct CardView2: View {
    
    let image: String
    let imageName: String
    
    var body: some View {
        
        ZStack {
            
            GeometryReader { geometry in
                
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .cornerRadius(15)
                
                    .overlay(
                        Text(imageName)
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(10)
                            .background(Color.white)
                            .padding([.bottom, .leading])
                            .opacity(1.0)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)
                    )
            }
        }
    }
}


struct imageModel: Identifiable {
    var id = UUID()
    var image: String
    var imageName: String
}

#if DEBUG
let imageModels = [
    imageModel(image: "charleyrivers", imageName: "图片01"),
    imageModel(image: "chilkoottrail", imageName: "图片02"),
    imageModel(image: "chincoteague", imageName: "图片03"),
    imageModel(image: "hiddenlake", imageName: "图片04"),
    imageModel(image: "icybay", imageName: "图片05")
]
#endif

struct DetailView: View {
    
    let imageName: String
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 5) {
                    
                    // 图片名称
                    Text(self.imageName)
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.heavy)
                        .padding(.bottom, 30)
                    
                    // 描述文字
                    Text("要想在一个生活圈中生活下去，或者融入职场的氛围，首先你要学习这个圈子的文化和发展史，并尝试用这个圈子里面的“话术”和他们交流，这样才能顺利地融入这个圈子。")
                        .padding(.bottom, 40)
                    
                    // 按钮
                    Button(action: {
                        
                    }) {
                        Text("知道了")
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding()
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
                .background(Color.white)
                .cornerRadius(15)
            }
        }
    }
}
