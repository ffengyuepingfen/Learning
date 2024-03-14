//
//  SettingRootView.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/10.
//

import SwiftUI

struct SettingRootView: View {
    var body: some View {
        SettingView()
            .navigationBarTitle("设置")
    }
}

#if DEBUG
struct SettingRootView_Previews: PreviewProvider {
    static var previews: some View {
        SettingRootView().environmentObject(AppModel())
    }
}
#endif
