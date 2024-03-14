//
//  ChongdianMacApp.swift
//  ChongdianMac
//
//  Created by Laowang on 2023/8/10.
//

import SwiftUI

@main
struct ChongdianMacApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AppModel())
        }.commands {
            // 自定义菜单
            LandmarkCommands()
        }
        
#if os(macOS)
        /// 首选项
        Settings {
            LandmarkSettings()
        }
#endif
    }
}

class AppModel: ObservableObject {
        
    var landmarkModel = ModelData()
    
}
