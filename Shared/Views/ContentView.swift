//
//  ContentView.swift
//  Shared
//
//  Created by Harris-Stoertz, Rowan on 2022-01-20.
//

import SwiftUI

struct ContentView: View {
    
    //stores all tasks that are being tracked
    @ObservedObject var store: TaskStore
    
    //controls whether the add task is showing
    @State private var showingAddTask = false
    
    //whether to show completed tasks or not
    @State var showingCompletedTasks = true
    
    var body: some View {
        List {
            ForEach(store.tasks) { task in
                TaskCell(task: task)
            }
            //view modifier invokes the function on the view model, "store"
            .onDelete(perform: store.deleteItems)
            .onMove(perform: store.moveItems)
        }
        .navigationTitle("Reminders")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Add") {
                    showingAddTask = true
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            
            ToolbarItem(placement: .bottomBar) {
                //allow user to toggle visibility of tasks based on their completion status
                Button(showingCompletedTasks ? "Hide completed tasks" : "Show completed tasks") {
                    print("Value of showingCompletedTasks was \(showingCompletedTasks)")
                    showingCompletedTasks.toggle()
                    print("Value of showingCompletedTasks is now \(showingCompletedTasks)")
                }
            }
        }
        .sheet(isPresented: $showingAddTask, content: {
            AddTask(store: store, showing: $showingAddTask)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView(store: testStore)
        }
    }
}
