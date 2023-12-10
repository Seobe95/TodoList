//
//  SelectButtonView.swift
//  TodoList
//
//  Created by seobe22 on 12/4/23.
//

import SwiftUI

struct SelectButtonView: View {
    @Binding var isEditMode: Bool
    @Binding var title: String
    @Binding var description: String
    var todoItem: TodoItemModel
    var completion: () -> Void
    
    var body: some View {
        Menu {
            Button {
                completion()
            } label: {
                HStack {
                    if todoItem.completed {
                        Text("완료 취소")
                        Image(systemName: "checkmark.circle.fill")
                    } else {
                        Text("완료")
                        Image(systemName: "checkmark.circle")
                    }
                }
            }
            
            Button {
                isEditMode.toggle()
                title = todoItem.title
                description = todoItem.description
            } label: {
                HStack {
                    Text("수정")
                    Image(systemName: "pencil")
                }
            }
        } label: {
            Image(systemName: "ellipsis.circle")
        }
    }
}
