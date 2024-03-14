//: [Previous](@previous)

//:  # Asynchronous:

/*:
 * async: 宣告 closure 使用 Asynchronous的方式执行
 * await: 表示这里有一个暂停点
 * Task: 在 synchronous的空间建立一段 Asynchronous code
 
 */

import Foundation
import _Concurrency

let startTime = Date.now

let topWork = 10
var finishWorking = 0

func work(name: String) async throws {
    print(Thread.current)
    print("\(name): 1️⃣开始工作")
    try await Task.sleep(nanoseconds: 2*1_000_000_000)
    Task {
        print("\(name): 2️⃣开始午休")
        try await Task.sleep(nanoseconds: 1*1_000_000_000)
        print("\(name): 3️⃣睡饱了")
    }
    print("\(name): 4️⃣继续工作")
    try await Task.sleep(nanoseconds: 2*1_000_000_000)
    print("\(name): 5️⃣下班")
    
    await MainActor.run {
        finishWorking += 1
        print(finishWorking)
        if finishWorking == topWork {
            printElapsedTime(from: startTime)
        }
    }
}

for num in 1...topWork {
    Task {
        try await work(name: "员工\(num) 号")
    }
}

//: # 官方建议的回到主线程
DispatchQueue.main.async {
    
}

Task.detached { @MainActor in
    
}



//: [Next](@next)
