//
//  BudgetListScreen.swift
//  SpendSmartUITests
//
//  Created by Mohammad Azam on 10/2/23.
//

import Foundation
import XCTest

struct BudgetListScreen {
    
    private var app: XCUIApplication
    
    private struct Elements {
        static let addBudgetCategoryButton = "AddBudgetCategoryButton"
        static let titleTextField = "titleTextField"
        static let amountTextField = "amountTextField"
        static let saveBudgetCategoryButton = "saveBudgetCategoryButton"
    }
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    lazy var addBudgetCategoryButton: XCUIElement = {
        app.buttons[Elements.addBudgetCategoryButton]
    }()
    
    lazy var titleTextField: XCUIElement = {
        app.textFields[Elements.titleTextField]
    }()
    
    lazy var amountTextField: XCUIElement = {
        app.textFields[Elements.amountTextField]
    }()
    
    lazy var saveBudgetCategoryButton: XCUIElement = {
        app.buttons[Elements.saveBudgetCategoryButton]
    }()
}
