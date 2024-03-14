//
//  ContentView.swift
//  Landmarks
//
//  Created by JianjiaCoder on 2021/10/12.
//

import SwiftUI

struct Landmarks: View {
    
    @State private var selection: Tab = .featured
    
    enum Tab {
        case featured
        case list
    }
    
    var body: some View {
        TabView(selection: $selection) {
            CategoryHome()
                .tabItem {
                    Label("Featured", systemImage: "star")
                }
                .tag(Tab.featured)
            
            LandmarkList()
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
                .tag(Tab.list)
        }
    
    }
}

struct Landmarks_Previews: PreviewProvider {
    static var previews: some View {
        Landmarks()
            .environmentObject(ModelData())
    }
}
