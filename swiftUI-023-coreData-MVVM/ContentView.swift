//
//  ContentView.swift
//  swiftUI-023-coreData-MVVM
//
//  Created by Luiz Araujo on 05/12/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var taskListViewModel = TaskListViewModel()
    
    func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = taskListViewModel.tasks[index]
            taskListViewModel.delete(task)
        }
        
        taskListViewModel.getAllTasks()
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter task name", text: $taskListViewModel.title)
                    .textFieldStyle(.roundedBorder)
            
                Button("Save") {
                    taskListViewModel.save()
                    taskListViewModel.getAllTasks()
                    
                }
            }
            
            List {
                ForEach(taskListViewModel.tasks, id: \.id) { task in
                    Text(task.title)
                }.onDelete(perform: deleteTask)
            }
            
            Spacer()
        }.padding()
            .onAppear {
                taskListViewModel.getAllTasks()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
