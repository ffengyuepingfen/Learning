//
//  AppModel.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/9.
//

import SwiftUI

class AppModel: ObservableObject {
    
    var landmarkModel = ModelData()
    
    var store = Store.sample
    
    @Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged") {
        didSet {
            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
        }
    }
    @Published var showLogin = true
}
