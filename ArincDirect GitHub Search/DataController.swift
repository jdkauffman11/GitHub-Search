//
//  DataController.swift
//  ArincDirect GitHub Search
//
//  Created by Jordan Kauffman on 7/22/22.
//

import Foundation
import CoreData
class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "RepoModel")
    
    static let shared = DataController()
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
}
