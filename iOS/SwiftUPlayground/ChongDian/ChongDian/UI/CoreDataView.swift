//
//  CoreDataView.swift
//  SwiftUIDemo (iOS)
//
//  Created by MacMini on 2022/9/16.
//

import SwiftUI
import CoreData

struct CoreDataView: View {
    
    @FetchRequest( entity: ToDoItem.entity(),
                   sortDescriptors: [ NSSortDescriptor(keyPath: \ToDoItem.priorityNum, ascending: false) ])
    var todoItems: FetchedResults<ToDoItem>
    
    @State private var showNewTask = false
    @State private var offset: CGFloat = .zero    //使用.animation防止报错，iOS15的特性
    
    @Environment(\.managedObjectContext) var context
    
    //去掉Listb背景颜色
    
    init() {
//        UITableView.appearance().backgroundColor = .clear
//        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            VStack {
                TopBarMenu1(showNewTask: $showNewTask)
                //                ToDoListView(todoItems: $todoItems)
                if todoItems.count == 0 {
                    NoDataView()
                }else{
                    List {
                        ForEach(todoItems) { todoItem in
                            ToDoListRow(todoItem: todoItem)
                        }
                        .onDelete(perform: deleteTask)
                    }
                }
                Spacer()
            }
            //点击添加时打开弹窗
            if showNewTask {
                //蒙层
                MaskView(bgColor: .black)
                    .opacity(0.5)
                    .onTapGesture {
                        self.showNewTask = false
                    }
                
                NewToDoView(name: "", priority: .normal, showNewTask: $showNewTask)
                    .transition(.move(edge: .bottom))
                    .animation(.interpolatingSpring(stiffness: 200.0, damping: 25.0, initialVelocity: 10.0),value: offset)
            }
        }.navigationBarTitleDisplayMode(.inline)
            .navigationTitle("你好啊")
    }
    
    //删除事项方法
    private func deleteTask(indexSet: IndexSet) {
        for index in indexSet {

            let itemToDelete = todoItems[index]

            context.delete(itemToDelete)
        }
        
        DispatchQueue.main.async {
            do {
                try context.save()

            } catch {
                print(error)
            }
        }
    }
}
struct CoreDataView_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataView()
    }
}

struct TopBarMenu1: View {
    
    @Binding var showNewTask: Bool
    
    var body: some View {
        HStack {
            Text("待办事项")
                .font(.system(size: 40, weight: .black))
            
            Spacer()
            
            Button {
                showNewTask = true
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
            }

        }.padding()
    }
}


//缺省图
struct NoDataView: View {
    var body: some View {
        Image("Card4")
            .resizable()
            .scaledToFit()
            .padding()
    }
}


// 列表
struct ToDoListView: View {

    @State var todoItems: [ToDoItem]

    var body: some View {
    
        List {
            ForEach(todoItems) { todoItem in
                ToDoListRow(todoItem: todoItem)
            }
        }
    }
}

// 列表内容
struct ToDoListRow: View {

    @ObservedObject var todoItem: ToDoItem
    @Environment(\.managedObjectContext) var context
    var body: some View {
    
        Toggle(isOn: self.$todoItem.isCompleted) {
            HStack {

                Text(self.todoItem.name)
                    .strikethrough(self.todoItem.isCompleted, color: .black)
                    .bold()
                    .animation(.default)

                Spacer()

                Circle()
                    .fill(self.color(for: todoItem.priority)) //给圆形填充颜色
                    .frame(width: 20, height: 20)
            }
        }
        .toggleStyle(CheckboxStyle())
        //监听todoItem数组参数变化并保存
        .onReceive(todoItem.objectWillChange, perform: { _ in
            if self.context.hasChanges {
                try? self.context.save()
            }
        })
    }
    
    // 根据优先级显示不同颜色
    private func color(for priority: Priority) -> Color {

        switch priority {
        case .high:
            return .red
        case .normal:
            return .orange
        case .low:
            return .green
        }
    }
}


// checkbox复选框样式
struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .purple : .gray)
                .font(.system(size: 20, weight: .bold, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
    }
}

struct NewToDoView: View {
    
    @State var name: String
    @State var isEditing = false
    
    @State var priority: Priority
    
    @Binding var showNewTask: Bool
    
    var body: some View {
        VStack {
            
            Spacer()
            
            VStack {
                TopNavBar(showNewTask: $showNewTask)
                InputNameView(name: $name, isEditing: $isEditing)
                PrioritySelectView(priority: $priority)
                SaveButton(name: $name, showNewTask: $showNewTask, priority: $priority)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10, antialiased: true)
            .offset(y: isEditing ? -320 : 0)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}


// 顶部导航栏
struct TopNavBar: View {
    
    @Binding var showNewTask: Bool
    
    var body: some View {

        HStack {
            Text("新建事项")
                .font(.system(.title))
                .bold()

            Spacer()

            Button(action: {
                showNewTask = false
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .font(.title)
            }
        }
    }
}

//输入框
struct InputNameView: View {
    
    @Binding var name: String
    @Binding var isEditing: Bool
    
    var body: some View {
        
        TextField("请输入", text: $name, onEditingChanged: { (editingChanged) in
            
            self.isEditing = editingChanged
            
        })
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.bottom)
    }
}

// 选择优先级
struct PrioritySelectView: View {
    
    @Binding var priority: Priority
    
    var body: some View {

        HStack {
            PrioritySelectRow(name: "高", color: priority == .high ? Color.red : Color(.systemGray4))
                .onTapGesture { self.priority = .high }

            PrioritySelectRow(name: "中", color: priority == .normal ? Color.orange : Color(.systemGray4))
                .onTapGesture { self.priority = .normal }

            PrioritySelectRow(name: "低", color: priority == .low ? Color.green : Color(.systemGray4))
                .onTapGesture { self.priority = .low }
        }
    }
}

// 选择优先级
struct PrioritySelectRow: View {

    var name: String
    var color:Color

    var body: some View {
    
        Text(name)
            .frame(width: 80)
            .font(.system(.headline))
            .padding(10)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

// 保存按钮
struct SaveButton: View {
    
    @Binding var name:String
    @Binding var showNewTask: Bool
    @Binding var priority:Priority
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {

        Button(action: {

    //判断输入框是否为空
            if self.name.trimmingCharacters(in: .whitespaces) == "" {
                return
            }
            //添加一条新数据
            self.addTask(name: self.name, priority: self.priority)
            //关闭弹窗
            self.showNewTask = false

        }) {

            Text("保存")
                .font(.system(.headline))
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
        }
        .padding([.top,.bottom])
    }
    
    //添加新事项方法
    private func addTask(name: String, priority: Priority, isCompleted: Bool = false) {

        let task = ToDoItem(context: context)
        task.id = UUID()
        task.name = name
        task.priority = priority
        task.isCompleted = isCompleted

        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

//蒙层
struct MaskView : View {

    var bgColor: Color

    var body: some View {

        VStack {

            Spacer()

        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(bgColor)
        .edgesIgnoringSafeArea(.all)
    }
}
