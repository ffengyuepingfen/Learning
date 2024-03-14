//
//  FormView.swift
//  SwiftUIDemo (iOS)
//
//  Created by MacMini on 2022/9/16.
//

import SwiftUI

struct FormView: View {
    
    @State var isDownload = false       //是否下载
    @State var isInstall = false    //是否安装
    
    private var displayState = [ "接收关闭", "仅限联系人", "所有人"]
    @State private var selectedNumber = 0
    
    @State private var amount = 1
    
    var body: some View {
        Form {
            Section(footer: Text("下载后在夜间自动安装软件更新。更新安装前您会收到通知。iPhone 必须为充电状态并接入 Wi-Fi以完成更新。")) {

                // 需要展示的内容
                Text("下载iOS更新")
                Text("安装iOS更新")
                
                Toggle(isOn: $isDownload) {
                    Text("下载iOS更新")
                }

                Toggle(isOn: $isInstall) {
                    Text("安装iOS更新")
                }
            }
            
            Section {
                Picker(selection: $selectedNumber, label: Text("隔空投送")) {
                    //选择器可选项内容
                    ForEach(0 ..< displayState.count, id: \.self) {
                        Text(self.displayState[$0])
                    }
                }
                
                //步进器
                Stepper(onIncrement: {
                    self.amount += 1
                    
                    if self.amount > 99 {
                    self.amount = 99
                }
                }, onDecrement: {
                    self.amount -= 1
                    
                    if self.amount < 1 {
                        self.amount = 1
                    }
                }) {
                    //步进器文字
                    Text("\(amount)")

                }
            }
        }

    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
