//
//  TodoListModel.swift
//  TodoList
//
//  Created by seobe22 on 11/14/23.
//

import Foundation
import Combine

struct TodoItemModel: Codable, Identifiable {
    var id: UUID
    var title: String
    var description: String
    var completed: Bool
}

class TodoManager: ObservableObject {
    @Published var list: [TodoItemModel]
    
    init(list: [TodoItemModel] = []) {
        self.list = list
    }
    
    func setList(list: [TodoItemModel]) {
        self.list = list
    }
}
