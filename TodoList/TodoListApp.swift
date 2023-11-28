//
//  TodoListApp.swift
//  TodoList
//
//  Created by seobe22 on 11/14/23.
//

import SwiftUI

@main
struct TodoListApp: App {
    let coreDataManager = CoreDataManager.shared
    var body: some Scene {
        WindowGroup {
            TodoListView()
                .environment(\.managedObjectContext, coreDataManager.container.viewContext)
        }
    }
}
