//
//  CoreDataManager.swift
//  TodoList
//
//  Created by seobe22 on 11/23/23.
//

import Foundation
import CoreData
import SwiftUI

/* MARK: TodoEntity 구조
 {
 id: UUID
 title: String
 desc: String
 isCompleted: Bool
 }
 */

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "TodoListCoreData")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData Init Error: \(error)")
            }
        }
    }
    
    func saveData() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("CoreData Save Error : \(error)")
            }
        }
    }
    
    func addTodoItem (id: UUID, title: String, description: String, context: NSManagedObjectContext) {
        let newTodoItem = TodoItem(context: context)
    
        newTodoItem.id = id
        newTodoItem.timestemp = Date()
        newTodoItem.title = title
        newTodoItem.desc = description
        newTodoItem.isCompleted = false
        
        saveData()
    }
    
    func setChangeCompleted(id: UUID, isCompleted: Bool, context: NSManagedObjectContext) {
        let request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        request.predicate = NSPredicate(format: "(id = %@)", id as CVarArg)
        
        do {
            let result = try context.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
            let match = result[0] as! NSManagedObject
            match.setValue(!isCompleted, forKey: "isCompleted")
            saveData()
            print("complete change save complete")
        } catch {
            print("Change Completed Error \(error)")
        }
    }
    
    func editTodoItem(id: UUID, title: String, desc: String, context: NSManagedObjectContext) {
        let context = container.viewContext
        let request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        request.predicate = NSPredicate(format: "(id = %@)", id as CVarArg)
        
        do {
            let result = try context.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
            let match = result[0] as! NSManagedObject
            match.setValue(title, forKey: "title")
            match.setValue(desc, forKey: "desc")
            saveData()
            print("save complete")
        } catch {
            print("Change Completed Error \(error)")
        }
    }
    
    func removeTodoItem(at offset: IndexSet, list: FetchedResults<TodoItem>, context: NSManagedObjectContext) {
        let context = container.viewContext
        withAnimation {
            offset.forEach {
                let todo = list[$0]
                context.delete(todo)
            }
            saveData()
        }
    }
}
