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
                SectionListView(sectionLabel: "COMPLETED", list: todolist.getCompletedList())
                SectionListView(sectionLabel: "To do", list: todolist.getUncompletedList())
            }
        }
    }
}

#Preview {
    ContentView()
}

struct SectionListView: View {
    var sectionLabel: String
    var list: [TodoListModel]
    
    var body: some View {
        Section(sectionLabel) {
            ForEach(list) { list in
                NavigationLink(destination: DetailTodoView(todoItem: list)){
                    HStack {
                        Text(list.title)
                            .font(.title3)
                    }
                }
            }
        }
    }
}
