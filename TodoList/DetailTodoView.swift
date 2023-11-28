//
//  DetailTodoView.swift
//  TodoList
//
//  Created by seobe22 on 11/14/23.
//

import SwiftUI

struct DetailTodoView: View {
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
                    Text("할 일")
                        .font(.title3)
                    TextField(text: $title) {
                        Text("할 일을 적어주세요")
                    }
                    .font(.body)
                }
                .padding(.bottom, 16)
                .padding(.horizontal, 16)
                
                VStack(alignment: .leading) {
                    Text("상세내용")
                        .font(.title3)
                    TextField(text: $description, axis: .vertical) {
                        Text("할 일에 대한 내용을 적어주세요")
                    }
                    .font(.body)
                    .multilineTextAlignment(.leading)
                }
                .padding(.horizontal, 16)
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
                Menu {
                    Button {
                        toggleCheckBtn()
                    } label: {
                        HStack {
                            Text(todoItem.completed ? "완료 취소" : "완료")
                            Image(systemName: todoItem.completed ? "checkmark.circle.fill" : "checkmark.circle")
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
    }
    
    func toggleCheckBtn() {
        if let item = $list.first(where: { $0.id == todoItem.id }) {
            coreData.setChangeCompleted(id: item.id, isCompleted: item.completed.wrappedValue)
            item.completed.wrappedValue.toggle()
        } else {
            print("Didn't match Item's ID")
        }
    }
    
    func editTodoItem() {
        if let item = $list.first(where: { $0.id == todoItem.id }) {
            coreData.editTodoItem(id: item.id, title: title, desc: description)
            item.title.wrappedValue = title
            item.description.wrappedValue = description
            isEditMode.toggle()
        } else {
            print("Didn't match Item's ID")
        }
    }
}

