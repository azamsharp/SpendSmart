//
//  SpendSmartApp.swift
//  SpendSmart
//
//  Created by Mohammad Azam on 9/30/23.
//

import SwiftUI
import SwiftData

struct ModelContainerFactory {
   
    @MainActor static func create() -> ModelContainer {
        
        var container: ModelContainer!
        
        let configuration = ModelConfiguration(for: BudgetCategory.self, isStoredInMemoryOnly: false)
        container = try! ModelContainer(for: BudgetCategory.self, configurations: configuration)
        
        if ProcessInfo.processInfo.arguments.contains("UITEST") {
            
            // THIS DOES NOT WORK
            //container.deleteAllData()
            
            // THIS WORKS
            try! container.mainContext.delete(model: BudgetCategory.self)
        }
        
        return container
    }
}

@main
struct SpendSmartApp: App {
    
    var container: ModelContainer
    
    init() {
        container = ModelContainerFactory.create()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                BudgetListScreen()
            }.withMessageWrapper()
        }.modelContainer(container)
    }
}
