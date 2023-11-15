//
//  TodoListViewModel.swift
//  TodoList
//
//  Created by seobe22 on 11/14/23.
//

import Foundation
import Combine

class TodoList: ObservableObject {
    @Published var list: [TodoListModel]
    
    init(list: [TodoListModel] = []) {
        self.list = list
    }
}

func getJsonData<T: Decodable>(_ filename: String) -> T {
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
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("Unable to parse \(filename) : \(error)")
    }
    
}
