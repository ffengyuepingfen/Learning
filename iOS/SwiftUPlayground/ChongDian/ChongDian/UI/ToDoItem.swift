//
//  ToDoItem.swift
//  SwiftUIDemo (iOS)
//
//  Created by MacMini on 2022/9/16.
//

import SwiftUI
import CoreData

//任务紧急程度的枚举
enum Priority: Int {
    case low = 0
    case normal = 1
    case high = 2
}

//ToDoItem遵循ObservableObject协议
class ToDoItem: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var name: String
    @NSManaged var priorityNum: Int32
    @NSManaged var isCompleted: Bool
}

extension ToDoItem: Identifiable {
    
    var priority: Priority {
        
        get {
            return Priority(rawValue: Int(priorityNum)) ?? .normal
        }
        
        set {
            self.priorityNum = Int32(newValue.rawValue)
        }
    }
}
