//
//  CoreDataManager.swift
//  swiftUI-023-coreData-MVVM
//
//  Created by Luiz Araujo on 05/12/21.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "TodoAppModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unabel to initialize Core Data Stack. Eror: \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    func getAllTasks() -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        do{
            return try viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func getTaskById(id: NSManagedObjectID) -> Task? {
        do {
            return try viewContext.existingObject(with: id) as? Task
        } catch {
            return nil
        }
    }
    
    func deleteTask(task: Task) {
        viewContext.delete(task)
        save()
    }
}








































