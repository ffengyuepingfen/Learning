//
//  Tools.swift
//  loginIn
//
//  Created by Laowang on 2024/3/13.
//

import Foundation

public func printElapsedTime(from: Date) -> String {
    
    let nowSecond = Date.now.timeIntervalSince1970
    let presecond = from.timeIntervalSince1970
    print("消耗了：\(nowSecond - presecond) ...")
    return "消耗了：\(nowSecond - presecond) ..."
}


extension Task where Success == Never, Failure == Never {
    
    public static func sleep(seconds: Double? = nil) async throws {
        
        let delay = seconds ?? Double((5...20).randomElement()!) * 0.1
        
        try await Task.sleep(nanoseconds: UInt64(delay)*1_000_000_000)
    }
}
