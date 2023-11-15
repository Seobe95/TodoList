//
//  DetailTodoView.swift
//  TodoList
//
//  Created by seobe22 on 11/14/23.
//

import SwiftUI

struct DetailTodoView: View {
    @Binding var todoItem: TodoListModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Section("할일") {
                Toggle(isOn: $todoItem.completed, label: {
                    Text(todoItem.title)
                })
            }
            
            Section("상세 내용") {
                Text(todoItem.description)
            }.padding(.top, 16)
            
        }.padding()
            .onAppear {
                print(todoItem)
            }
    }
    
}

//#Preview {
////    DetailTodoView()
//}
