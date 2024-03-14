//
//  PPCBPeripheral.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/10.
//

import CoreBluetooth

class PPCBPeripheral: Identifiable {
    let id = UUID()
    var peripheral: CBPeripheral
    var signValue: NSNumber
    var advertisementData: [String : Any]
    
    init(peripheral: CBPeripheral, signValue: NSNumber, advertisementData: [String : Any]) {
        self.peripheral = peripheral
        self.signValue = signValue
        self.advertisementData = advertisementData
    }
}

