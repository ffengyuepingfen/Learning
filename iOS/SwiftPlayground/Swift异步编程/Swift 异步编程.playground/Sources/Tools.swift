import Foundation
import _Concurrency

public func printElapsedTime(from: Date) {
    
    let nowSecond = Date.now.timeIntervalSince1970
    let presecond = from.timeIntervalSince1970
    
    print("消耗了：\(nowSecond - presecond) ...")
}


extension Task where Success == Never, Failure == Never {
    
    public static func sleep(seconds: UInt64) async throws {
        try await Task.sleep(nanoseconds: seconds*1_000_000_000)
    }
}
