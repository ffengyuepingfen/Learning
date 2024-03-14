//
//  DesignCode.swift
//  SwiftUIDemo (iOS)
//
//  Created by MacMini on 2022/9/5.
//

import SwiftUI

struct DesignCode: View {
    
    @State var show = false
    
    @State var viewState = CGSize.zero
    
    @State var showCard = false
    
    @State var bottomState = CGSize.zero
    
    @State var showFull = false
    
    
    var body: some View {
        ZStack {
            
            TitleView()
            // 模糊
                .blur(radius: show ? 20 : 0)
                .opacity(showCard ? 0.4 : 1)
                .offset(y: showCard ? -200 : 0)
                .animation({
                    Animation
                        .default
                        .delay(0.1)
                    //                        .speed(2)
                    //                        .repeatCount(3, autoreverses: false)
                }(), value: showCard)
            
            CardBackView()
                .frame(width: showCard ? 300 : 340, height: 220)
                .background(Color(show ? "card3" : "card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(showCard ? 1 : 0.9)
                .rotationEffect(.degrees(show ? 0 : 10))
                .rotationEffect(Angle(degrees: showCard ? -10 : 0))
                .rotation3DEffect(Angle(degrees: 10), axis: (x: 10, y: 0, z: 0))
            // 混合模式
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5), value: viewState)
            CardBackView()
                .frame(width: 340, height: 220)
                .background(Color(show ? "card4" : "card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(showCard ? 1 : 0.95)
                .rotationEffect(.degrees(show ? 0 : 5))
                .rotationEffect(Angle(degrees: showCard ? -5 : 0))
                .rotation3DEffect(Angle(degrees: 5), axis: (x: 10, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3), value: viewState)
            CardView()
                .frame(width: showCard ? 375 : 340, height: 220)
                .background(Color.black)
            //                .cornerRadius(20)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)
                .animation(.spring(), value: showCard)
                .onTapGesture {
                    self.showCard.toggle()
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.viewState = value.translation
                            self.show = true
                        }
                        .onEnded{ value in
                            self.viewState = .zero
                            self.show = false
                        }
                )
            
            BottomCardView(show: $showCard)
                .offset(x: 0, y: showCard ? 360 : 1000)
                .offset(y: bottomState.height)
                .blur(radius: show ? 20 : 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8), value: showCard)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            self.bottomState = value.translation
                            if self.showFull {
                                self.bottomState.height += -300
                            }
                            
                            if self.bottomState.height < -300 {
                                self.bottomState.height = -300
                            }
                        })
                        .onEnded({ value in
                            if self.bottomState.height > 50 {
                                self.showCard = false
                            }
                            
                            if (self.bottomState.height < -100 && !self.showCard) || (self.bottomState.height < -250 && self.showCard) {
                                self.bottomState.height = -300
                                self.showFull = true
                            }else {
                                self.bottomState = .zero
                                self.showFull = false
                            }
                        })
                )
        }
    }
}
struct DesignCode_Previews: PreviewProvider {
    static var previews: some View {
        DesignCode()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Hello")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("Placeholder")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo1")
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            Spacer()
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 110, alignment: .top)
        }
    }
}

struct CardBackView: View {
    var body: some View {
        VStack{
            Spacer()
        }
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            Image("Background1")
            Spacer()
        }
    }
}

struct BottomCardView: View {
    
    @Binding var show: Bool
    
    var body: some View {
        
        let color1 = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        let color2 = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1)
            Text("This certificate is proof that Meng To has achieved the UI Design course with approval from a Design+Code instructor.")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            
            HStack(spacing: 20.0) {
                RingView(color1: color1,color2: color2,width: 88, height: 88, percent: 56,delay: 0.3, show: $show)
                
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("SwiftUI")
                        .fontWeight(.bold)
                    Text("12 of 12 sections completed \n 10 hours spent so far")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineSpacing(4)
                }
                .padding(20)
                .background(Color("background3"))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                
            }
            
            
            
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .blurBackground(style: .systemChromeMaterial)
        .cornerRadius(30)
        .shadow(radius: 20)
    }
}

