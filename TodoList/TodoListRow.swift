//
//  TodoListCell.swift
//  TodoList
//
//  Created by seobe22 on 11/21/23.
//

import SwiftUI

struct TodoListRow: View {
    @ObservedObject var todolist: TodoManager
    var todoItem: TodoItemModel
    
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
                        if var item = $todolist.list.first(where: { $0.id == todoItem.id }) {
                            item.completed.wrappedValue.toggle()
                        } else {
                            print("Completed Change Error")
                        }
                    }
                
                Text(todoItem.title)
                    .strikethrough(todoItem.completed)
            }
        }
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                removeTodoItem(todoItem)
            } label: {
                Image(systemName: "trash.fill")
            }
            
        }
    }
    
    func removeTodoItem(_ target: TodoItemModel) {
        if let index = todolist.list.firstIndex ( where: { $0.id == target.id } ) {
            todolist.list.remove(at: index)
        } else {
            print("REMOVE ERROR")
        }
    }
}
