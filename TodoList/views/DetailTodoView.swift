//
//  DetailTodoView.swift
//  TodoList
//
//  Created by seobe22 on 11/14/23.
//

import SwiftUI

struct DetailTodoView: View {
    @Environment(\.managedObjectContext) var context
    @Binding var list: [TodoItemModel]
    @State var isEditMode = false
    @State var title: String = ""
    @State var description: String = ""
    
    var todoItem: TodoItemModel
    let coreData = CoreDataManager.shared
    
    var body: some View {
        VStack(alignment: .leading) {
            if isEditMode {
                VStack(alignment: .leading) {
                    TextField(text: $title) {
                        Text("할 일을 적어주세요")
                    }
                    .font(.title)
                    .padding(.bottom, 16)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                VStack(alignment: .leading) {
                    TextField(text: $description, axis: .vertical) {
                        Text("할 일에 대한 내용을 적어주세요")
                    }
                    .font(.body)
                    .padding(.horizontal, 16)
                    .multilineTextAlignment(.leading)
                }
            } else {
                Text(todoItem.title)
                    .font(.title)
                    .padding(.bottom, 16)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(todoItem.description)
                    .font(.body)
                    .padding(.horizontal, 16)
            }
            Spacer()
        }
        .padding(.top, 16)
        .navigationTitle(isEditMode ? "수정하기" : "상세보기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isEditMode {
                Button("저장") {
                    editTodoItem()
                }
            } else {
                SelectButtonView(isEditMode: $isEditMode, title: $title, description: $description, todoItem: todoItem) {
                    toggleCheckBtn()
                }
            }
        }
    }
    
    func toggleCheckBtn() {
        if let item = $list.first(where: { $0.id == todoItem.id }) {
            coreData.setChangeCompleted(id: item.id, isCompleted: item.completed.wrappedValue, context: context)
            item.completed.wrappedValue.toggle()
        } else {
            print("Didn't match Item's ID")
        }
    }
    
    func editTodoItem() {
        if let item = $list.first(where: { $0.id == todoItem.id }) {
            coreData.editTodoItem(id: item.id, title: title, desc: description, context: context)
            item.title.wrappedValue = title
            item.description.wrappedValue = description
            isEditMode.toggle()
        } else {
            print("Didn't match Item's ID")
        }
    }
}

