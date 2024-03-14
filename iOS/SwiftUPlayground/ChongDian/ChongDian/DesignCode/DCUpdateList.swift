//
//  DCUpdateList.swift
//  SwiftUIDemo (iOS)
//
//  Created by MacMini on 2022/9/7.
//

import SwiftUI

struct DCUpdateList: View {
    
    @ObservedObject var store = DCUpdateStore()
    
    func addUpdate() {
        store.updates.append(DCUpdate(image: "Card1", title: "test", text: "这是一条测试信息", date: "Jan 1"))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.updates) { item in
                    NavigationLink {
                        DCUpdateDetaile()
                    } label: {
                        HStack {
                            
                            Image(item.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                                .background(.black)
                                .cornerRadius(20)
                                .padding(.trailing, 4)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(item.title)
                                    .font(.system(size: 20, weight: .bold))
                                Text(item.text)
                                    .font(.subheadline)
                                    .lineLimit(2)
                                    .foregroundColor(Color.green)
                                
                                Text(item.date)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .onDelete { index in
                    store.updates.remove(at: index.first!)
                }
                .onMove { sourceIndex, offset in
                    self.store.updates.move(fromOffsets: sourceIndex, toOffset: offset)
                }
                .contextMenu { // ios 13 添加的效果
                    Button(action: {
                        // 点击删除
                    }) {
                        HStack {
                            Text("删除")
                            Image(systemName: "trash")
                        }
                    }
                }
            }
            .navigationTitle("Update")
            .navigationBarItems(leading:
                Button("add Update", action: addUpdate)
            , trailing: EditButton())
        }
    }
}

struct DCUpdateList_Previews: PreviewProvider {
    static var previews: some View {
        DCUpdateList()
    }
}

struct DCUpdate: Identifiable{
    var id = UUID()
    var image: String
    var title: String
    var text: String
    var date: String
}

