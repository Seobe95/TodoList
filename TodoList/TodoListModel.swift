//
//  TodoListModel.swift
//  TodoList
//
//  Created by seobe22 on 11/14/23.
//

import Foundation
import Combine

struct TodoItemModel: Codable, Identifiable {
    var id: Int
    var title: String
    var description: String
    var completed: Bool
}

class TodoManager: ObservableObject {
    @Published var list: [TodoItemModel]
    
    init(list: [TodoItemModel] = []) {
        self.list = list
    }
    
    func getJsonData(_ filename: String) {
        guard let fileLocation = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("\(filename) is not Found")
        }
        
        let data: Data
        
        do {
            data = try Data(contentsOf: fileLocation)
        } catch {
            fatalError("Could not load \(filename): \(error)")
        }
        
        do {
            self.list = try JSONDecoder().decode([TodoItemModel].self, from: data)
        } catch {
            fatalError("Unable to parse \(filename) : \(error)")
        }
    }
}
