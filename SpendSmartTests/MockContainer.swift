import Foundation
import SwiftData

@MainActor
var mockContainer: ModelContainer {
    do {
        let container = try ModelContainer(for: BudgetCategory.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        print("returning a new container")
        return container
    } catch {
        fatalError("Failed to create container.")
    }
}


