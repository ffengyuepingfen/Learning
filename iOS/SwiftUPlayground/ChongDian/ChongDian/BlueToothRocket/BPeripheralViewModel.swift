//
//  BPeripheralViewModel.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/10.
//

import Foundation

class BPeripheralViewModel: ObservableObject {
    
    @Published var peripherals: [PPCBPeripheral] = []
    
    init() {
        BlueToothRocketManager.shared.beginScanPeripheral()
        
        BlueToothRocketManager.shared.registAcceptDevice { [weak self] in
            self?.peripherals = BlueToothRocketManager.shared.peripherals
        }
    }
}
