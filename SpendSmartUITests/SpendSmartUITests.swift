//
//  SpendSmartUITests.swift
//  SpendSmartUITests
//
//  Created by Mohammad Azam on 10/2/23.
//

import XCTest

final class SpendSmartUITests: XCTestCase {

    private var app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["UITEST"]
        app.launch()
    }
    
    func testAddNewBudgetCategory() throws {
       
        var budgetListScreen = BudgetListScreen(app: app)
        
        budgetListScreen.addBudgetCategoryButton.tap()
        
        budgetListScreen.titleTextField.tap()
        budgetListScreen.titleTextField.typeText("Travel")
        
        budgetListScreen.amountTextField.tap()
        budgetListScreen.amountTextField.typeText("100")
                
        budgetListScreen.saveBudgetCategoryButton.tap()
        XCTAssertTrue(app.collectionViews.staticTexts["Travel"].exists)
        
    }
    
    func test_AddBudgetCategoryAndThenAddAndRemoveTransactionsToThatBudget() {
        
        var budgetListScreen = BudgetListScreen(app: app)
        var budgetDetailScreen = BudgetListDetailScreen(app: app)
        
        budgetListScreen.addBudgetCategoryButton.tap()
        
        budgetListScreen.titleTextField.tap()
        budgetListScreen.titleTextField.typeText("Travel")
        
        budgetListScreen.amountTextField.tap()
        budgetListScreen.amountTextField.typeText("100")
                
        budgetListScreen.saveBudgetCategoryButton.tap()
        XCTAssertTrue(app.collectionViews.staticTexts["Travel"].exists)
        
        // take the user to budget detail screen
        budgetDetailScreen.budgetCategoryList.staticTexts["Travel"].tap()
        
        budgetDetailScreen.transactionTitleTextField.tap()
        budgetDetailScreen.transactionTitleTextField.typeText("Airfare")
            
        budgetDetailScreen.transactionAmountTextField.tap()
        budgetDetailScreen.transactionAmountTextField.typeText("48")
        
        budgetDetailScreen.transactionQuantityTextField.tap()
        budgetDetailScreen.transactionQuantityTextField.tap()
                
        budgetDetailScreen.addTransactionButton.tap()
                
        XCTAssertEqual("Spent: $48.00", budgetDetailScreen.spentText.label)
        XCTAssertEqual("Remaining: $52.00", budgetDetailScreen.remainingText.label)
        
        XCTAssertTrue(app.staticTexts["Airfare (1)"].exists)
        
        // deleting the transaction
        let transactionList = app.collectionViews
        transactionList.children(matching: .cell).element(boundBy: 10).children(matching: .other).element(boundBy: 1).children(matching: .other).element.swipeLeft()
        transactionList.buttons["Delete"].tap()
        
        // check if the row is gone
        XCTAssertFalse(app.staticTexts["Airfare (1)"].exists)
        
        XCTAssertEqual("Spent: $0.00", budgetDetailScreen.spentText.label)
        XCTAssertEqual("Remaining: $100.00", budgetDetailScreen.remainingText.label)
    }
    
    
}
