//
//  SpendSmartTests.swift
//  SpendSmartTests
//
//  Created by Mohammad Azam on 9/30/23.
//

import XCTest
import SwiftData

final class SpendSmartTests: XCTestCase {
    
    private var budgetCategory: BudgetCategory!
    private var context: ModelContext!
    
    @MainActor
    override func setUp() {
        
        print("setUp")
        context = mockContainer.mainContext
        
        self.budgetCategory = BudgetCategory(title: "Travel", amount: 300)
        try! self.budgetCategory.save(context: context)
    }
    
    @MainActor
    func testCaclulateTotalForBudgetCategory() {
        
        let transactions = [Transaction(title: "Milk", amount: 10, quantity: 1), Transaction(title: "Bread", amount: 2.5, quantity: 2), Transaction(title: "Eggs", amount: 4.75, quantity: 4)]
        
        for transaction in transactions {
            self.budgetCategory.addTransaction(context: context, transaction: transaction)
        }
        
        // calculate the total
        XCTAssertEqual(34, self.budgetCategory.total)
    }
    
    @MainActor
    func testCalculateRemainingForBudgetCategory() {
        
        let transactions = [Transaction(title: "Milk", amount: 10, quantity: 1), Transaction(title: "Bread", amount: 2.5, quantity: 2), Transaction(title: "Eggs", amount: 4.75, quantity: 4)]
        
        for transaction in transactions {
            self.budgetCategory.addTransaction(context: context, transaction: transaction)
        }
        
        XCTAssertEqual(266, budgetCategory.remaining)
    }
    
    @MainActor
    func testThrowtitleDuplicateExceptionWhenInsertingDuplicateBudgetCategoryTitle() throws {
        
        let newBudgetCategory = BudgetCategory(title: "Travel", amount: 300)
        
        XCTAssertThrowsError(try newBudgetCategory.save(context: context), "No exception was thrown.") { error in
            let thrownError = error as? BudgetCategoryError
            XCTAssertNotNil(thrownError)
            XCTAssertEqual(BudgetCategoryError.titleAlreadyExist, thrownError)
        }
        
        context.insert(newBudgetCategory)
    }
    
}
