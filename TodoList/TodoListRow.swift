//
//  TodoListCell.swift
//  TodoList
//
//  Created by seobe22 on 11/21/23.
//

import SwiftUI
import CoreData

struct TodoListRow: View {
    @ObservedObject var todolist: TodoManager
    var todoItem: TodoItemModel
    let coreData = CoreDataManager.shared
    
    var body: some View {
        NavigationLink {
            DetailTodoView(list: $todolist.list, todoItem: todoItem)
        } label: {
            HStack {
                Image(systemName: todoItem.completed ? "checkmark.circle.fill" : "checkmark.circle")
                    .foregroundStyle(todoItem.completed ? .green : .gray)
                    .padding(.trailing, 16)
                    .font(.system(size: 24))
                    .onTapGesture {
                        toggleCheckBtn()
                    }
                
                Text(todoItem.title)
                    .strikethrough(todoItem.completed)
            }
        }
    }
    
    func toggleCheckBtn() {
        if let item = $todolist.list.first(where: { $0.id == todoItem.id }) {
            coreData.setChangeCompleted(id: item.id, isCompleted: item.completed.wrappedValue)
            item.completed.wrappedValue.toggle()
        } else {
            print("Didn't match Item's ID")
        }
    }
}
