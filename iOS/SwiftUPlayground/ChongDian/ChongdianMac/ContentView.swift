//
//  ContentView.swift
//  ChongdianMac
//
//  Created by Laowang on 2023/8/10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            LandmarkList()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppModel())
    }
}

