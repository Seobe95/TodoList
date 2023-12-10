//
//  WriteView.swift
//  TodoList
//
//  Created by seobe22 on 11/20/23.
//

import SwiftUI

struct WriteView: View {
    @Environment(\.managedObjectContext) var context
    @Binding var todolist: [TodoItemModel]
    @Binding var path: NavigationPath
    
    @State var title: String = ""
    @State var description: String = ""
    @State var titleAlert: Bool = false
    
    let coreData = CoreDataManager.shared
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("할 일")
                    .font(.title3)
                TextField(text: $title) {
                    Text("할 일을 적어주세요")
                }
                .font(.body)
            }.padding(.bottom, 16)
            
            VStack(alignment: .leading) {
                Text("상세내용")
                    .font(.title3)
                TextField(text: $description, axis: .vertical) {
                    Text("할 일에 대한 내용을 적어주세요")
                }
                .font(.body)
                .multilineTextAlignment(.leading)
            }
            .padding(.bottom, 32)
            
            Spacer()
        }
        .alert("할 일을 입력해주세요.", isPresented: $titleAlert) {
            Button("확인", role: .cancel) {
                titleAlert.toggle()
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .navigationTitle("할 일 작성하기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                addTodoList()
            } label: {
                Text("저장")
            }
        }
    }
    
    func addTodoList() {
        if title.isEmpty {
            return titleAlert.toggle()
        }
        
        let id = UUID()
        coreData.addTodoItem(id: id, title: title, description: description, context: context)
        todolist.append(TodoItemModel(id: id, title: title, description: description, completed: false))
        
        path.removeLast()
    }
}
