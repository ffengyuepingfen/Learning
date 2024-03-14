//: [Previous](@previous)

//: # 网络

/*:
    * 透过 URLSession 建立网络任务， 一般的情况都直接使用 URLSession.shared 处理即可
    * 回传状态 代码在 200 ~ 299 之间都是正常
 */

import Foundation
import _Concurrency
import AppKit

let randomImageUrl = URL(string: "https://pic.52112.com/180321/180321_7/Si0yV9T4Ou_small.jpg")!

func downLoadImage() async throws -> NSImage {
    let (data, response) = try await URLSession.shared.data(from: randomImageUrl)
    guard let response = response as? HTTPURLResponse,
          (200...299).contains(response.statusCode) else {
        fatalError()
    }
    return NSImage(data: data)!
}

Task {
   let image = try! await downLoadImage()
}



//: [Next](@next)
