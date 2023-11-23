//
//  DetailTodoView.swift
//  TodoList
//
//  Created by seobe22 on 11/14/23.
//

import SwiftUI

struct DetailTodoView: View {
    @Binding var list: [TodoListModel]
    var todoItem: TodoListModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(todoItem.title)
                .font(.title)
                .padding(.bottom, 16)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(todoItem.description)
                .font(.body)
                .padding(.horizontal, 16)
            
            Spacer()
            
        }
        .padding(.top, 16)
        .navigationTitle("상세보기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                let index = list.firstIndex { $0.id == todoItem.id }!
                list[index].completed.toggle()
            } label: {
                Text(todoItem.completed ? "완료 취소" : "완료")
            }
        }
    }
}
