//
//  TodoListModel.swift
//  TodoList
//
//  Created by seobe22 on 11/14/23.
//

import Foundation

struct TodoListModel: Codable, Identifiable {
    var id: Int
    var title: String
    var description: String
    var completed: Bool
}
