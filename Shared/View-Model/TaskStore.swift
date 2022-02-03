//
//  TaskStore.swift
//  RemindersApp (iOS)
//
//  Created by Harris-Stoertz, Rowan on 2022-01-20.
//

import Foundation
import SwiftUI

class TaskStore: ObservableObject {
    
    //MARK: Stored properties
    @Published var tasks: [Task]
    
    //MARK: Initializers
    init (tasks: [Task] = []) {
        
        //get a URL that points to the saved JSON data containing our list of tasks
        let filename = getDocumentDirectory().appendingPathComponent(savedTasksLabel)
        print(filename)
        
        //attempt to load from the JSON in the stored/persisted file
        do {
            
            //load the raw data
            let data = try Data(contentsOf: filename)
            
            //what was loaded from the file?
            print("Got data from file, contents are:")
            print(String(data: data, encoding: .utf8)!)
            
            //decode the data into Swift native data structures
            self.tasks = try JSONDecoder().decode([Task].self, from: data)
            
        } catch {
            
            //what went wrong?
            print(error.localizedDescription)
            print("Could not load data from file, initializing with tasksprovided to initializer")
            
            //set up list of tasks to whatever was passed to this initializer
            self.tasks = tasks
        }
    }
    
    //MARK: Functions
    func deleteItems (at offsets: IndexSet) {
        //"offsets" contains a set of items selected for deletion
        //the set is then passed to the built-in "remove" method on the tasks array which handles removal from the array
        tasks.remove(atOffsets: offsets)
    }
    
    //Invoked to move items around in our list
    func moveItems(from source: IndexSet, to destination: Int){
        //"source" again contains a set of items being moved
        //"destination" is the location the items are being moved to in the list
        //these arguments are automatically populated for us by the .onMove view modifier provided by the SwiftUI framework
        tasks.move(fromOffsets: source, toOffset: destination)
    }
    
    //persist the list of tasks
    func persistTasks() {
        
        //get a url that points to the saved JSON data containing our list of tasks
        let filename = getDocumentDirectory().appendingPathComponent(savedTasksLabel)
        
        //try to encode the data in our people array to JSON
        do {
            //create an encoder
            let encoder = JSONEncoder()
            
            //ensure the JSON written to the file is human-readable
            encoder.outputFormatting = .prettyPrinted
            
            //encode the list of tasks we've collected
            let data = try encoder.encode(self.tasks)
            
            //actually write the JSON file to the documents directory
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            
            //see the data that was written
            print("Saved data to documents directory successfully")
            print("===")
            print(String(data: data, encoding: .utf8)!)
            
        } catch {
            
            print(error.localizedDescription)
            print("Unable to write lists of tasks to documents directory in app bundle on device.")
            
        }
    }
    
}

let testStore = TaskStore(tasks: testData)
