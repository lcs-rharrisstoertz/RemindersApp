//
//  TaskCell.swift
//  RemindersApp (iOS)
//
//  Created by Harris-Stoertz, Rowan on 2022-01-20.
//

import SwiftUI

struct TaskCell: View {
    
    @ObservedObject var task: Task
    
    var body: some View {
        HStack {
            Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                .onTapGesture {
                    
                    task.completed.toggle()
                    
                }
            
            Text(task.description)
        }
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(task: testData[0])
    }
}
