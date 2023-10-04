import Foundation
import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    
    do {
        let container = try ModelContainer(for: BudgetCategory.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        for budgetCategory in SampleData.budgetCategories {
            container.mainContext.insert(budgetCategory)
            budgetCategory.transactions = SampleData.transactions            
        }
        
        return container
        
    } catch {
        fatalError("Failed to create container.")
    }
}()

struct SampleData {
    
    static var budgetCategories: [BudgetCategory] {
        return [BudgetCategory(title: "Travel", amount: 300), BudgetCategory(title: "Groceries", amount: 500)]
    }
    
    static var transactions: [Transaction] {
        return [Transaction(title: "Bread", amount: 7.00, quantity: 2), Transaction(title: "Eggs", amount: 8.00, quantity: 1)]
    }
    
}

