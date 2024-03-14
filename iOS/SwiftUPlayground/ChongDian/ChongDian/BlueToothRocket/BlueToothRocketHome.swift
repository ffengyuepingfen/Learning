//
//  BlueToothRocketHome.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/10.
//

import SwiftUI

struct BlueToothRocketHome: View {
    @ObservedObject var viewModel = BPeripheralViewModel()
    
    @State var searchText: String = ""
    
    var body: some View {
        VStack {
            SearchView1(text: $searchText)
            List(viewModel.peripherals) { item in
                NavigationLink(destination: PPPeripheralDetaileView(peripheral: item)) {
                    PPPeripheralRow(title: item.peripheral.name ?? "-", servers: "2 services", uud: item.peripheral.identifier.uuidString)
                }
            }
        }
    }
}

struct BlueToothRocketHome_Previews: PreviewProvider {
    static var previews: some View {
        BlueToothRocketHome(searchText: "")
    }
}

struct PPPeripheralRow: View {
    
    var title: String
    var servers: String
    var uud: String
//    var rii: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title).bold()
                
                Spacer()
                Text(servers)
                    .font(.subheadline)
                Text(uud)
                    .font(.subheadline)
            }
            Spacer()
            Image(systemName: "antenna.radiowaves.left.and.right")
        }
        .frame(height: 80)
        .padding(.horizontal)
    }
}



// SearchBarView搜索栏视图

struct SearchView1: View {

    @Binding var text: String
    @State private var offset: CGFloat = .zero // 使用.animation防止报错，iOS15的特性
    @State private var isEditing = false
    
    var body: some View {

        HStack {
            TextField("搜你想看的", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading).padding(.leading, 8)
                        
                        //编辑时显示清除按钮
                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                //点击时
                .onTapGesture {
                    self.isEditing = true
            }
            
            // 搜索按钮
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    // 收起键盘
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("搜索")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default, value: offset)
            }
        }
    }
}
