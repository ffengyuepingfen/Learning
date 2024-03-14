//
//  Home.swift
//  SwiftUIDemo (iOS)
//
//  Created by MacMini on 2022/9/7.
//

import SwiftUI

struct DesignCodeHome: View {
    
    @State var showProfile = false
    @State var viewState = CGSize.zero
    @State var showContent = false
    
    var body: some View {
        ZStack {
            
            Color("background2")
                .edgesIgnoringSafeArea(.all)
            
            DesignCodeHomeView(showProfile: $showProfile, showContent: $showContent)
                .padding(.top, 44)
                .background(
                    VStack {
                        LinearGradient(gradient: Gradient(colors: [Color("background2"), Color("background1")]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 200)
                        Spacer()
                    }
                    .background(Color("background2"))
                )
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                .offset(y: showProfile ? -450 : 0)
                .scaleEffect(showProfile ? 0.9 : 1)
                .rotation3DEffect(Angle(degrees: showProfile ? (Double(self.viewState.height/10) - 10) : 0), axis: (x: 10, y: 0, z: 0))
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: showProfile)
                .edgesIgnoringSafeArea(.all)
//            MenuView()
//                .background(Color.black.opacity(0.001))
//                .offset(y: showProfile ? 0 : screen.height)
//                .offset(y: self.viewState.height)
//                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: showProfile)
//                .onTapGesture {
//                    self.showProfile.toggle()
//                }
//                .gesture(
//                    DragGesture()
//                        .onChanged{ value in
//                            self.viewState = value.translation
//                        }
//                        .onEnded { value in
//                            if self.viewState.height > 50 {
//                                self.showProfile = false
//                            }
//                            self.viewState = .zero
//                        }
//                )
            
            if showContent {
                BlurView(style: .systemMaterial).edgesIgnoringSafeArea(.all)
                
                DesignCode()
                /// 添加关闭按钮
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark")
                            .frame(width: 36, height: 36)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                }
                .offset(x: -16, y: 16)
                .transition(.move(edge: .top))
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0), value: true)
                .onTapGesture {
                    self.showContent = false
                }
            }
        }
    }
}

struct DesignCodeHome_Previews: PreviewProvider {
    static var previews: some View {
        DesignCodeHome().environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraLarge)
    }
}
/// 头像
struct AvatarView: View {
    
    @Binding var showProfile: Bool
    
    var body: some View {
        Button {
            self.showProfile.toggle()
        } label: {
            Image("Avatar")
                .resizable()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
        }
    }
}

let screen = UIScreen.main.bounds

struct SectionView: View {
    
    var section: DesignCodeSection
    
    var height: CGFloat = 275
    var width: CGFloat = 275
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(Color.white)
                
                Spacer()
                
                Image(section.logo)
            }
            
            Text(section.text.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: width, height: height)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

struct DesignCodeSection: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}

let sectionData = [
    DesignCodeSection(title: "prototype designs in SwiftUI", text: "18 sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Background1")), color: Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))),
    DesignCodeSection(title: "Hello in SwiftUI", text: "28 sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Background1")), color: Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1))),
    DesignCodeSection(title: "prototype designs in SwiftUI", text: "20 sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card2")), color: Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))),
]



struct WatchRingsView: View {
    var body: some View {
        HStack(spacing: 30) {
            HStack(spacing: 12.0) {
                RingView(width: 44, height: 44 ,show: .constant(true))
                VStack(alignment: .leading, spacing: 4.0) {
                    Text("6 minutes left")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    Text("watched 10 mins today")
                        .font(.caption)
                }
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(width: 32, height: 32 ,show: .constant(true))
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(width: 32, height: 32 ,show: .constant(true))
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
        }
    }
}
