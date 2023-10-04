//
//  BudgetCategory.swift
//  SpendSmart
//
//  Created by Mohammad Azam on 9/30/23.
//

import Foundation
import SwiftData

enum BudgetCategoryError: LocalizedError {
    case titleAlreadyExist
    
    var errorDescription: String? {
        switch self {
            case .titleAlreadyExist:
                return "Title already exists."
        }
    }
}

@Model
class BudgetCategory {
    
    // unique constraint here performs upsert
    @Attribute(.unique) var title: String = ""
    var amount: Decimal = 0.0
    @Relationship(deleteRule: .cascade) var transactions: [Transaction] = []
    
    init(title: String, amount: Decimal) {
        self.title = title
        self.amount = amount
    }
    
    var total: Decimal {
        transactions.reduce(0) { result, transaction in
            result + transaction.total 
        }
    }
    
    var remaining: Decimal {
        amount - total 
    }
    
    // exists function to check if title already exist or not
    private func exists(context: ModelContext, title: String) -> Bool {
        
        let predicate = #Predicate<BudgetCategory> { $0.title == title }
        let descriptor = FetchDescriptor(predicate: predicate)
        
        do {
            let result = try context.fetch(descriptor)
            return !result.isEmpty ? true: false
        } catch {
            return false
        }
    }
    
    func addTransaction(context: ModelContext, transaction: Transaction) {
        transaction.budgetCategory = self
    }
    
    func update(context: ModelContext, title: String, amount: Decimal) throws {
        if !exists(context: context, title: title) {
            self.title = title
            self.amount = amount
        } else {
            throw BudgetCategoryError.titleAlreadyExist
        }
    }
    
    func save(context: ModelContext) throws {
        
        // find if the budget category with the same name already exists
        if !exists(context: context, title: self.title) {
            // save it
            context.insert(self)
        } else {
            // do something else
            throw BudgetCategoryError.titleAlreadyExist
        }
    }
}
