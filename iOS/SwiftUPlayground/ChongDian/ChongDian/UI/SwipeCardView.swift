//
//  SwipeCardView.swift
//  SwiftUIDemo (iOS)
//
//  Created by MacMini on 2022/9/16.
//

import SwiftUI

//Gestures手势特性
enum DragState: Equatable {
    case inactive
    case pressing
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive, .pressing:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .dragging:
            return true
        case .pressing, .inactive:
            return false
        }
    }
    
    var isPressing: Bool {
        switch self {
        case .pressing, .dragging:
            return true
        case .inactive:
            return false
        }
    }
}

struct SwipeCardView: View {
    
    @GestureState private var dragState = DragState.inactive
    @State private var offset: CGFloat = .zero
    
    private let dragPosition: CGFloat = 80.0
    
    //创建2个卡片视图
    @State var albumsData: [Album] = {

        var views = [Album]()

        for index in 0..<2 {
            views.append(Album(name: albums[index].name, image: albums[index].image))
        }
        return views
    }()
    
    //最后一张图片索引值
    @State private var lastIndex = 1
    
    //转场类型动画
    @State private var removalTransition = AnyTransition.trailingBottom
    
    var body: some View {
        VStack {
            TopBarMenu()
            ZStack {
                ForEach(albumsData) { al in
                    CardView1(name: al.name, image: al.image)
                        // 添加优先级
                        .zIndex(self.isTopCard(cardView: al) ? 1 : 0)
                    //判断喜欢或者不喜欢
                        .overlay(
                            ZStack {
                                Image(systemName: "hand.thumbsdown.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 100))
                                    .opacity(self.dragState.translation.width < -self.dragPosition && self .isTopCard(cardView: al) ? 1.0 : 0)
                                
                                Image(systemName: "hand.thumbsup.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 100))
                                .opacity(self.dragState.translation.width > self.dragPosition && self .isTopCard(cardView: al) ? 1.0 : 0.0) } )
                    
                        .offset(x: self.isTopCard(cardView: al) ? self.dragState.translation.width : 0, y: self.isTopCard(cardView: al) ?self.dragState.translation.height : 0)
                        .scaleEffect(self.dragState.isDragging && self.isTopCard(cardView: al) ? 0.95 : 1.0)
                        .rotationEffect(Angle(degrees: self.isTopCard(cardView: al) ? Double( self.dragState.translation.width / 10) : 0))
                        .animation(.interpolatingSpring(stiffness: 180, damping: 100),value: offset)
                        //转场动画
                        .transition(self.removalTransition)
                        .gesture(
                            LongPressGesture(minimumDuration: 0.01)
                                .sequenced(before: DragGesture())
                                .updating(self.$dragState, body: { (value, state, transaction) in
                                    switch value {
                                    case .first(true):
                                        state = .pressing
                                    case .second(true, let drag):
                                        state = .dragging(translation: drag?.translation ?? .zero)
                                    default:
                                        break
                                    }
                                })
                            
                            //拖动时添加转场效果
                            .onChanged({ (value) in
                                guard case .second(true, let drag?) = value else {
                                    return
                                }

                                if drag.translation.width < -self.dragPosition {
                                    self.removalTransition = .leadingBottom
                                }

                                if drag.translation.width > self.dragPosition {
                                    self.removalTransition = .trailingBottom
                                }
                            })
                            
                            //拖拽移除卡片
                                .onEnded({ (value) in
                                    guard case .second(true, let drag?) = value else {
                                        return
                                    }
                                    
                                    if drag.translation.width < -self.dragPosition || drag.translation.width > self.dragPosition {
                                        self.moveCard()
                                    }
                                })
                        )
                }
            }
            
            Spacer(minLength: 20)
            
            BottomBarMenu()
                .opacity(dragState.isDragging ? 0.0 : 1.0)
                .animation(.default, value: offset)
        }
        
    }
    
    //获得图片zIndex值
    func isTopCard(cardView: Album) -> Bool {
        guard let index = albumsData.firstIndex(where: { $0.id == cardView.id }) else {
            return false
        }
        return index == 0
    }
    
    //移除卡片显示下一张卡片
    func moveCard() {

        albumsData.removeFirst()

        self.lastIndex += 1
        let cards = albums[lastIndex % albums.count]

        let newCardView = Album(name: cards.name, image: cards.image)

        albumsData.append(newCardView)
    }
}

struct SwipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeCardView()
    }
}

struct TopBarMenu: View {
    var body: some View {
        HStack {
            Image(systemName: "ellipsis.circle")
                .font(.system(size: 30))

            Spacer()

            Image(systemName: "heart.circle")
                .font(.system(size: 30))
        }.padding()
    }
}

struct CardView1: View {
    
    let name: String
    let image: Color
    
    var body: some View {
        
        image
            .frame(minWidth: 0, maxWidth: .infinity)
            .cornerRadius(10)
            .padding(.horizontal, 15)
            .overlay(
                VStack {
                    Text(name)
                        .font(.system(.headline, design: .rounded)).fontWeight(.bold)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .cornerRadius(5)
                }
                    .padding([.bottom], 20), alignment: .bottom
            )
    }
}

struct BottomBarMenu: View {
    var body: some View {
        HStack {
            
            Image(systemName: "xmark")
                .font(.system(size: 30))
                .foregroundColor(.black)
            
            Button(action: {
                
            }) {
                
                Text("立即选择")
                    .font(.system(.subheadline, design: .rounded)).bold()
                    .foregroundColor(.white)
                    .padding(.horizontal, 35)
                    .padding(.vertical, 15)
                    .background(Color.black)
                    .cornerRadius(10)
            }.padding(.horizontal, 20)
            
            Image(systemName: "heart")
                .font(.system(size: 30))
                .foregroundColor(.black)
        }
    }
}


//创建Album定义变量
struct Album: Identifiable {
    var id = UUID()
    var name: String
    var image: Color
}

//创建演示数据
var albums = [
    Album(name: "图片01", image: .red),
    Album(name: "图片02", image: .gray),
    Album(name: "图片03", image: .brown),
    Album(name: "图片04", image: .blue)
]


//转场动画效果
extension AnyTransition {
    
    static var trailingBottom: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .identity, removal: AnyTransition.move(edge: .trailing).combined(with: .move(edge : .bottom))
        )
    }
    
    static var leadingBottom: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .identity, removal: AnyTransition.move(edge: .leading).combined(with: .move(edge: .bottom))
        )
    }
}

