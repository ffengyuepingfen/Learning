//
//  UISmallAppsHome.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/9.
//

import SwiftUI

struct UISmallAppsHome: View {
    @EnvironmentObject var userData: AppModel
    @State var showContent = false
    
    @State var offsize = CGFloat.zero
    
    var body: some View {
        List {
            Section(header: Text("Part 1")) {
                NavigationLink(destination: PokeMasterHome(), label: {
                    Text("精灵列表")
                })
                NavigationLink(destination: SettingRootView(), label: {
                    Text("精灵设置")
                })
            }
            
            Section(header: Text("Part 2: Geometry Effect")) {
                NavigationLink(destination: DesignCodeHome(), label: {
                    Text("DesignCodeHome")
                })
                NavigationLink(destination: DCCourseList(), label: {
                    Text("DCCourseList")
                })
            }
            
            Section(header: Text("Part 2: Geometry Effect")) {
                NavigationLink(destination: CategoryHome(), label: {
                    Text("CategoryHome")
                })
            }
            
            Section(header: Text("Part 2: Geometry Effect")) {
                NavigationLink(destination: LandmarkList(), label: {
                    Text("LandmarkList")
                })
            }
        }
        .navigationBarItems(trailing:
                                VStack {
            if userData.isLogged {
                Button(action: { self.showContent.toggle() }) {
                    Image("Avatar")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 36, height: 36)
                        .clipShape(Circle())
                }
            } else {
                Button(action: { self.userData.showLogin.toggle() }) {
                    Image(systemName: "person")
                        .foregroundColor(.primary)
                        .font(.system(size: 16, weight: .medium))
                        .frame(width: 36, height: 36)
                        .background(Color("background3"))
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                }
            }
        }
        )
    }
}

struct UISmallAppsHome_Previews: PreviewProvider {
    static var previews: some View {
        UISmallAppsHome().environmentObject(AppModel())
    }
}
