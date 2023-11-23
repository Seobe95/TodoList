//
//  TodoListCell.swift
//  TodoList
//
//  Created by seobe22 on 11/21/23.
//

import SwiftUI

struct TodoListCell: View {
    @ObservedObject var todolist: TodoList
    var todoItem: TodoListModel
    
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
                        let index = todolist.list.firstIndex(where: { $0.id == todoItem.id})!
                        todolist.list[index].completed.toggle()
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
    
    func removeTodoItem(_ target: TodoListModel) {
        let index = todolist.list.firstIndex { $0.id == target.id }!
        todolist.list.remove(at: index)
    }
}
