//
//  PPPeripheralDetaileView.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/10.
//

import SwiftUI

struct PPPeripheralDetaileView: View {
    
    var peripheral: PPCBPeripheral
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct PPPeripheralDetaileView_Previews: PreviewProvider {
    static var previews: some View {
        PPPeripheralDetaileView(peripheral: BlueToothRocketManager.shared.peripherals[0])
    }
}
