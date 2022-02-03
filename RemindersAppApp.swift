//
//  RemindersAppApp.swift
//  Shared
//
//  Created by Harris-Stoertz, Rowan on 2022-01-20.
//

import SwiftUI

@main
struct RemindersAppApp: App {
    
    //detect when app moves between the foreground, background, and active states
    @Environment(\.scenePhase) var scenePhase
    
    //create the source of truth for our list of tasks (create the view model)
    @StateObject private var store = TaskStore(tasks: testData)
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView(store: store)
            }
        }
        .onChange(of: scenePhase) {newPhase in
            
            if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .active {
                print("Active")
            } else if newPhase == .background {
                print("Background")
                
                //Permanently save the list of tasks
                store.persistTasks()
                
            }
        }
    }
}
