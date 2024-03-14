//: [Previous](@previous)

import Foundation


var money = 100

func getBuyCandyClosure() -> () -> Void {
    var money = 100
    func buyCandy() {
        money -= 20
        print("😄🍬,剩下\(money)")
    }
    return buyCandy
}

let buyCandy = getBuyCandyClosure()

buyCandy()
buyCandy()


struct 钱包 {
    var money = 100
    func buySomeThing(cost: Int) {
        money -= cost
        print("花了 \(cost), 剩下 \(money)")
    }
}


//: [Next](@next)
