//: [Previous](@previous)

import Foundation

var greeting = "Actor 介紹：Global Actor、isolated、Task 繼承 - Swift 新手入門"

// isolated & nonisolated

import _Concurrency

actor BankAcount {
    
    let name: String
    var balance = 1000
    
    init(_ name: String) {
        self.name = name
    }
    // 提款
    func withdraw(_ amount: Int) -> Int {
        if amount > balance {
            print("⚠️\(name) 存款只剩 \(balance) 元， 无法提款 \(amount) 元")
            return 0
        }
        
        balance -= amount
        print("👇🏻\(name) 提款 \(amount) 元， 剩下\(balance) 元")
        return amount
    }
    
    func deposit(_ amount: Int) -> Int {
        balance += amount
        print("\(name) 存款 \(amount) 元， 目前存款 \(balance) 元")
        return balance
    }
    
    func printBalance() {
        print("\(name) 的余额为： \(balance) 元")
    }
    
//    func syncActions() {
//        print("--------------开始")
//        withdraw(200)
//        deposit(100)
//        withdraw(200)
//        deposit(100)
//        print("--------------结束")
//    }
}

extension BankAcount: CustomStringConvertible, Hashable {
    // var 属性在 actor 中默认是 isolated
    nonisolated var description: String {
        name
    }
    
    static func == (lhs: BankAcount, rhs: BankAcount) -> Bool {
        lhs.name == rhs.name
    }
    
    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
}


// 被 BankAcount actor 执行
func syncActions(account: isolated BankAcount) {
    print("--------------开始")
    account.withdraw(200)
    account.deposit(100)
    account.withdraw(200)
    account.deposit(100)
    print("--------------结束")
}

let familyAccount = BankAcount("家庭账户")
print("创建了 \(familyAccount.name)")

Task {
    print("一开始有 \(await familyAccount.balance) 元")
    await withTaskGroup(of: Void.self) { group in
        (0...2).forEach { number in
            group.addTask {
                await syncActions(account: familyAccount)
            }
        }
        await group.waitForAll()
        await familyAccount.printBalance()
    }
}


//: [Next](@next)
