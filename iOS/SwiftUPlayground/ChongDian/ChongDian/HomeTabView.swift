//
//  TabView.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/9.
//

import SwiftUI

struct HomeTabView: View {
    
    @State private var selection: Tab = .SPOT
    
    @EnvironmentObject var userData: AppModel
    @State var showContent = false
    @State var offsize = CGFloat.zero
    
    enum Tab {
        case SPOT
        case NEWS
    }
    
    var body: some View {
        
        ZStack {
            
            if userData.showLogin {
                ZStack {
                    LoginView()
                    
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
                    .padding()
                    .onTapGesture {
                        self.userData.showLogin = false
                    }
                }
            }else {
                NavigationView{
                    TabView(selection: $selection){
                        UIHome()
                            .tabItem { Label("Featured", systemImage: "star") }
                            .tag(Tab.SPOT)
                        
                        UISmallAppsHome()
                            .tabItem { Label("List", systemImage: "list.bullet") }
                            .tag(Tab.NEWS)
                    }
                    .navigationBarTitle(returnNaviBarTitle(tabSelection: self.selection))
                }
            }
        }
    }
    
    func returnNaviBarTitle(tabSelection: Tab) -> String {
        switch tabSelection{
        case .SPOT: return "SwiftUI Lab"
        case .NEWS: return "smalle apps"
        }
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView().environmentObject(AppModel())
    }
}
