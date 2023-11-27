import SwiftUI

struct TodoListView: View {
    @StateObject var todolist = TodoManager()
    @State private var navigationPath = NavigationPath()
    let backgroundColor = Color(UIColor.systemGroupedBackground)
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            EmptyAndTodoListView(todolist: todolist)
                .navigationDestination(for: String.self) { _ in
                WriteView(todolist: $todolist.list, path: $navigationPath)
            }
        }.onAppear {
            todolist.getJsonData("sample.json")
        }
    }
}

struct EmptyAndTodoListView: View {
    @ObservedObject var todolist: TodoManager
    
    var body: some View {
        if todolist.list.isEmpty {
            VStack {
                Text("새로운 할 일을 등록해보세요!")
                    .padding(.bottom, 32)
                
                NavigationLink(value: "ADD TODO") {
                    Text("새로운 할 일 추가하기")
                }
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemBackground).ignoresSafeArea())
        } else {
            List(todolist.list) { todoItem in
                TodoListRow(todolist: todolist, todoItem: todoItem)
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
}


#Preview {
    TodoListView()
}
