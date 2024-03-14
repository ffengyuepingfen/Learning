//
//  UserTaskGroupDemoView.swift
//  loginIn
//
//  Created by Laowang on 2024/3/13.
//

import SwiftUI

enum FetchUserManager {
    static func fetchUser(id: Int) async -> User {
        try! await Task.sleep()
        let names = ["1111","2222","3333","4444","5555"]
        return User(name: names[id - 1], image: "\(id).circle")
    }
    
    static func fetch(userIDs: [Int]) async -> [User] {
        
        await withTaskGroup(of: User.self, returning: [User].self) { group in
            for id in userIDs {
                group.addTask {
                    await fetchUser(id: id)
                }
            }
            var users = [User]()
            
            for await res in group {
                users.append(res)
            }
            return users
        }
        
//        timeMessage = printElapsedTime(from: startTime)
    }
}

struct UserTaskGroupDemoView: View {
    
    @State private var isLoading = false
    @State private var users = [User]()
    @State private var timeMessage = "加载中..."
    
    
    
    func fetch() async {
        let startTime = Date.now
        let userIDs = Array(1...5)
        
        for id in userIDs {
            users.append(await FetchUserManager.fetchUser(id: id))
        }
        
//        await withTaskGroup(of: Void.self) { group in
//            for id in userIDs {
//                group.addTask {
//                    users.append(await fetchUser(id: id))
//                }
//            }
//        }
        
        timeMessage = printElapsedTime(from: startTime)
    }
    
}

extension UserTaskGroupDemoView {
    var body: some View {
        VStack {
            ForEach(users) { user in
                HStack {
                    Image(systemName: user.image)
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text(user.name)
                }
            }
            if isLoading {
                ProgressView {
                    Text("加载中.....")
                }
            }
            Spacer()
            Text(timeMessage)
            Button("加载") {
                isLoading = true
                Task {
                    users = await FetchUserManager.fetch(userIDs: Array(1...5))
                    isLoading = false
                }
            }
        }
        .padding()
        .frame(width: 360, height: 600)
    }
}


#Preview {
    UserTaskGroupDemoView()
}
