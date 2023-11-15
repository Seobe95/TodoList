//
//  ContentView.swift
//  TodoList
//
//  Created by seobe22 on 11/14/23.
//

import SwiftUI

let data: [TodoListModel] = getJsonData("sample.json")

struct ContentView: View {
    @ObservedObject var todolist = TodoList(list: data)
    
    var body: some View {
        NavigationStack {
            List {
                Section("TODOLIST") {
                    ForEach($todolist.list , id: \.self) { todoItem in
                        NavigationLink {
                            DetailTodoView(todoItem: todoItem)
                        } label: {
                            HStack {
                                if todoItem.completed.wrappedValue {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.blue)
                                }
                                Text(todoItem.title.wrappedValue)
                            }
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}

