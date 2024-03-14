//
//  ContentView.swift
//  loginIn
//
//  Created by Laowang on 2024/3/13.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLoading = false
    @State private var user = User.empty
    @State private var timemessage: String = " "
    
    var body: some View {
        VStack {
            Text(user.name)
            ZStack {
                Image(systemName: user.image)
                    .resizable()
                    .imageScale(.large)
                    .frame(height: 360)
                    .foregroundStyle(.tint)
                if isLoading {
                    ProgressView {
                        Text("加载中.....")
                    }
                }
            }
            
            Spacer()
            Text(timemessage)
            Button("加载") {
                isLoading = true
                Task {
                    await fetchData()
                    isLoading = false
                }
            }
            
        }
        .padding()
        .frame(width: 360, height: 600)
    }
    
    func fetchData() async {
        let starttime = Date.now
        // 一个一个执行
//        user.name = await fetchUserName()
//        user.image = await fetchIamge()
        
        // 有限个数的 多任务异步执行
        async let name = fetchUserName()
        async let image = fetchIamge()
        
        user.name = await name
        user.image = await image
        
        timemessage = printElapsedTime(from: starttime)
    }
    
    func fetchUserName() async -> String {
        try! await Task.sleep(seconds: 1)
        return "Jane"
    }
    
    func fetchIamge() async -> String {
        try! await Task.sleep(seconds: 1)
        return "brain.head.profile.fill"
    }
}

#Preview {
    ContentView()
}

