//
//  SharedFunctionsAndConstants.swift
//  RemindersApp (iOS)
//
//  Created by Harris-Stoertz, Rowan on 2022-01-28.
//

import Foundation

//Return the directory that we can save user data in
func getDocumentDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

//Define a file label (or file name) that we will write to within that directory
let savedTasksLabel = "savedTasks"
