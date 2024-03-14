//
//  ChongDianApp.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/9.
//

import SwiftUI

@main
struct ChongDianApp: App {
    
//    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            HomeTabView().environmentObject(AppModel())
                // Coredata 的 上下文对象
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
