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
    
    //What priority of tasks to show
    @State private var selectedPriorityForVisibleTasks: VisibleTaskPriority = .all
    
    //whether to recompute the view to show changes the list
    //we never actually show this value, but toggling it from "true" to "false" or vice-versa makes SwiftUI update the user interface, since a property marked with @State has changed
    @State var listShouldUpdate = false
    
    var body: some View {
        
        //has the list been asked to update?
        let _ = print("listShouldUpdate has been toggled. Current value is: \(listShouldUpdate)")
        
        //what is the selected priority level for task filtering?
        let _ = print("Filtering tasks by this priority: \(selectedPriorityForVisibleTasks)")
        
        VStack {
            
            //label for picker
            Text("Filter by...")
                .font(Font.caption.smallCaps())
                .foregroundColor(.secondary)
            
            //picker to allow user to select what tasks to show
            Picker("Priority", selection: $selectedPriorityForVisibleTasks) {
                Text(VisibleTaskPriority.all.rawValue)
                    .tag(VisibleTaskPriority.all)
                Text(VisibleTaskPriority.low.rawValue)
                    .tag(VisibleTaskPriority.low)
                Text(VisibleTaskPriority.medium.rawValue)
                    .tag(VisibleTaskPriority.medium)
                Text(VisibleTaskPriority.high.rawValue)
                    .tag(VisibleTaskPriority.high)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            List {
                ForEach(store.tasks) { task in
                    
                    if showingCompletedTasks {
                        //show all takss, completed or incomplete
                        TaskCell(task: task, trigggerListUpdate: .constant(true))
                    } else {
                        
                        //only show completed tasks
                        if task.completed == false {
                            TaskCell(task: task, trigggerListUpdate: $listShouldUpdate)
                        }
                        
                    }
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView(store: testStore)
        }
    }
}
