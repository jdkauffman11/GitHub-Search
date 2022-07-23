//
//  ArincDirect_GitHub_SearchApp.swift
//  ArincDirect GitHub Search
//
//  Created by Jordan Kauffman on 7/19/22.
//

import SwiftUI

@main
struct ArincDirect_GitHub_SearchApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
