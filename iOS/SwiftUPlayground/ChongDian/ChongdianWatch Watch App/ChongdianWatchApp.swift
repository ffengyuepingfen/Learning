//
//  ChongdianWatchApp.swift
//  ChongdianWatch Watch App
//
//  Created by Laowang on 2023/8/10.
//

import SwiftUI

@main
struct ChongdianWatch_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AppModel())
        }
    }
}


class AppModel: ObservableObject {
    
//    var calculatorModel = CalculatorModel()
    
    var landmarkModel = ModelData()
    
//    var store = Store.sample
    
//    @Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged") {
//        didSet {
//            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
//        }
//    }
//    @Published var showLogin = false
}
