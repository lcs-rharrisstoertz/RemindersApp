//
//  TaskCell.swift
//  RemindersApp (iOS)
//
//  Created by Harris-Stoertz, Rowan on 2022-01-20.
//

import SwiftUI

struct TaskCell: View {
    
    @ObservedObject var task: Task
    
    //a derived value connected to a boolean on ContentView
    @Binding var trigggerListUpdate: Bool
    
    var taskColor: Color {
        switch task.priority {
        case .high:
            return Color.red
        case .medium:
            return Color.blue
        case .low:
            return Color.primary
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                .onTapGesture {
                    
                    //toggle task completion status... this means:
                    //complete the task (if it was previously incomplete)
                    //or
                    //mark task as incomplete (if it was previously completed)
                    task.completed.toggle()
                    
                    //change state of the source of truth on ContentView
                    //this will cause SwiftUI to re-draw the view and it will reflect fact that this task was completed
                    trigggerListUpdate.toggle()
                    
                }
            
            Text(task.description)
        }
        .foregroundColor(self.taskColor)
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(task: testData[0], trigggerListUpdate: .constant(true))
    }
}
