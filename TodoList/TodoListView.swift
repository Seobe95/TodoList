import SwiftUI

struct TodoListView: View {
    @StateObject var todolist = TodoManager()
    @State private var navigationPath = NavigationPath()
    @FetchRequest(entity: TodoItem.entity(), sortDescriptors: []) var list: FetchedResults<TodoItem>
    let coreData = CoreDataManager.shared
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            EmptyAndTodoListView(todolist: todolist, list: list, coreData: coreData)
                .navigationDestination(for: String.self) { _ in
                WriteView(todolist: $todolist.list, path: $navigationPath)
            }
        }.onAppear {
            var arr: [TodoItemModel] = []
            if !list.isEmpty {
                list.forEach {
                    if let id = $0.id, let title = $0.title, let desc = $0.desc {
                        arr.append(TodoItemModel(id: id, title: title, description: desc, completed: $0.isCompleted))
                    }
                }
            }
            todolist.setList(list: arr)
        }
    }
}

struct EmptyAndTodoListView: View {
    @ObservedObject var todolist: TodoManager
    var list: FetchedResults<TodoItem>
    var coreData: CoreDataManager
    
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
            List {
                ForEach (todolist.list) { todoItem in
                    TodoListRow(todolist: todolist, todoItem: todoItem)
                }.onDelete{ index in
                    coreData.removeTodoItem(at: index, list: list)
                    index.forEach {
                        todolist.list.remove(at: $0)
                    }
                }
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
