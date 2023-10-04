//
//  BudgetDetailScreen.swift
//  SpendSmartUITests
//
//  Created by Mohammad Azam on 10/2/23.
//

import Foundation
import XCTest

struct BudgetListDetailScreen {
    
    var app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    lazy var budgetCategoryList: XCUIElement = {
        app.collectionViews["budgetCategoryList"]
    }()
    
    lazy var transactionTitleTextField: XCUIElement = {
        app.textFields["transactionTitleTextField"]
    }()
    
    lazy var transactionAmountTextField: XCUIElement = {
        app.textFields["transactionAmountTextField"]
    }()
    
    lazy var transactionQuantityTextField: XCUIElement = {
        app.textFields["transactionQuantityTextField"]
    }()
    
    lazy var addTransactionButton: XCUIElement = {
        app.buttons["addTransactionButton"]
    }()
    
    lazy var spentText: XCUIElement = {
        app.staticTexts["spentText"]
    }()
    
    lazy var remainingText: XCUIElement = {
        app.staticTexts["remainingText"]
    }()
    
}
