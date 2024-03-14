//
//  DesignCodeHomeView.swift
//  SwiftUIDemo (iOS)
//
//  Created by MacMini on 2022/9/8.
//

import SwiftUI

struct DesignCodeHomeView: View {
    
    @Binding var showProfile: Bool
    
    @State var showUpdate: Bool = false
    
    @Binding var showContent: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Watching")
                        .font(.system(size: 20, weight: .bold))
                    
                    Spacer()
                    /// 属性绑定
                    AvatarView(showProfile: $showProfile)
                    
                    Button(action: { self.showUpdate.toggle() }) {
                        
                        Image(systemName: "bell")
                            .foregroundColor(.primary)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 36, height: 36)
                            .background(Color("background3"))
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 1.0, x: 0, y: 1)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                        
                    }
                    .sheet(isPresented: $showUpdate) {
                        DCUpdateList()
                    }
                    
                }
                .padding(.horizontal)
                .padding(.leading, 14)
                .padding(.top, 30)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    WatchRingsView()
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                        .onTapGesture {
                            self.showContent = true
                        }
                }
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 30) {
                        ForEach(sectionData) { item in
                            GeometryReader { geometry in
                                SectionView(section: item)
                                    .rotation3DEffect(Angle(degrees:
                                                                geometry.frame(in: .global).minX / -20
                                                           ), axis: (x: 0.0, y: 10.0, z: 0.0))
                            }
                            .frame(width: 275, height: 275)
                        }
                    }
                    .padding(30)
                    .padding(.bottom, 30)
                }
                .offset(y: -30)
                
                HStack {
                    Text("Courses").font(.title).bold()
                    Spacer()
                }
                .padding(.leading, 30)
                .offset(y: -60)
                
                SectionView(section: sectionData[0], height: 275, width: screen.width - 60)
                    .offset(y: -60)
                
                Spacer()
            }
        }
    }
}

struct DesignCodeHomeView_Previews: PreviewProvider {
    static var previews: some View {
        DesignCodeHomeView(showProfile: .constant(false), showContent: .constant(false))
    }
}
