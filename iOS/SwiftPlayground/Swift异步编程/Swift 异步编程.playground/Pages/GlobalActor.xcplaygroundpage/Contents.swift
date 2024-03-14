//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

import _Concurrency

// 创建一个专门处理金钱的 actor
@GlobalActor
actor TradingActor {
    static let shared = TradingActor()
}

// 然后把所有的 交易都放在 TradingActor 中

class 玩家 {
    var name: String
    @TradingActor var money: Int
    
    @TradingActor
    func give(_ other: 玩家, amount: Int) {
        self.money -= amount
        other.money += amount
        
        print(">> 交易资产: \(name) \(money) 元； \(other.name) \(other.money) 元")
    }
    
    init(name: String, money: Int) {
        self.name = name
        self.money = money
    }
}

let player = 玩家(name: "Jane", money: 100)
let cat = 玩家(name: "🐱", money: 0)

Task {
    await withTaskGroup(of: Void.self) { group in
        (0...500).forEach { _ in
            
            group.addTask {
                await player.give(cat, amount: 50)
            }
            
            group.addTask {
                await cat.give(player, amount: 50)
            }
            
            
        }
        await group.waitForAll()
        print("剩下的总金额： \((await player.money) + (await cat.money))")
    }
}


//: [Next](@next)
