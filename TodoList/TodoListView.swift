import SwiftUI

struct TodoListView: View {
    @StateObject var todolist = TodoList()
    @State private var navigationPath = NavigationPath()
    let backgroundColor = Color(UIColor.systemGroupedBackground)
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            if todolist.list.isEmpty {
                ZStack {
                    backgroundColor
                    
                    VStack {
                        Text("새로운 할 일을 등록해보세요!")
                            .padding(.bottom, 32)
                        
                        NavigationLink(value: "ADD TODO") {
                            Text("새로운 할 일 추가하기")
                        }
                    }
                    .navigationDestination(for: String.self) { _ in
                        WriteView(todolist: $todolist.list, path: $navigationPath)
                    }
                    .padding(.horizontal, 16)
                }.ignoresSafeArea()
            } else {
                List {
                    ForEach(todolist.list) { todoItem in
                        TodoListCell(todolist: todolist, todoItem: todoItem)
                    }
                }
                .navigationDestination(for: String.self) { _ in
                    WriteView(todolist: $todolist.list, path: $navigationPath)
                }
                .toolbar {
                    NavigationLink(value: "ADD TODO"){
                        Image(systemName: "pencil.and.list.clipboard")
                            .font(.system(size: 16))
                    }
                }
                .navigationTitle("할일")
            }
        }
        .onAppear {
            todolist.getJsonData("sample.json")
        }
    }
}


#Preview {
    TodoListView()
}
