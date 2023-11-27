//
//  WriteView.swift
//  TodoList
//
//  Created by seobe22 on 11/20/23.
//

import SwiftUI

struct WriteView: View {
    @Binding var todolist: [TodoItemModel]
    @Binding var path: NavigationPath
    
    @State var title: String = ""
    @State var description: String = ""
    @State var titleAlert: Bool = false
    @State var descriptionAlert: Bool = false
    
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
        // 일단은 예제 파일의 id에 맞도록 Int타입으로 설정 -> 추후 변경 예정
        todolist.append(TodoItemModel(id: Int.random(in: 1000...9999), title: title, description: description, completed: false))
        path.removeLast()
    }
}
