//
//  TaskListViewModel.swift
//  swiftUI-023-coreData-MVVM
//
//  Created by Luiz Araujo on 05/12/21.
//

import Foundation
import CoreData

class TaskListViewModel: ObservableObject {
    
    var title: String = ""
    @Published var tasks: [TaskViewModel] = []
    
    func save() {
        let task = Task(context: CoreDataManager.shared.viewContext)
        task.title = title
        
        CoreDataManager.shared.save()
    }
    
    func getAllTasks() {
        tasks = CoreDataManager.shared.getAllTasks().map(TaskViewModel.init)
    }
    
    func delete(_ task: TaskViewModel) {
        if let existingTask = CoreDataManager.shared.getTaskById(id: task.id) {
            CoreDataManager.shared.deleteTask(task: existingTask)
        }
    }
}


struct TaskViewModel {
    let task: Task
    
    var id: NSManagedObjectID {
        return task.objectID
    }
    
    var title: String {
        return task.title ?? ""
    }
}
