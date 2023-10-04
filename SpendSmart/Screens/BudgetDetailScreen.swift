//
//  BudgetDetailScreen.swift
//  SpendSmart
//
//  Created by Mohammad Azam on 10/1/23.
//

import SwiftUI
import SwiftData

struct BudgetDetailScreen: View {
    
    @Query private var transactions: [Transaction]
    @Environment(\.modelContext) private var context
    @Environment(\.showMessage) private var showMessage
    
    let budgetCategory: BudgetCategory
      
    @State private var title: String = ""
    @State private var amount: Decimal?
    
    @State private var transactionTitle: String = ""
    @State private var transactionAmount: Decimal?
    @State private var transactionQuantity: Int? = 1
    
    private var isBudgetCategoryFormValid: Bool {
        !title.isEmpty && amount != nil
    }
    
    private var isAddTransactionFormValid: Bool {
        !transactionTitle.isEmpty && transactionAmount != nil && transactionQuantity != nil
    }
    
    private var transactionsByBudgetCategory: [Transaction] {
        
        transactions.filter { $0.budgetCategory!.id == budgetCategory.id }
    }
    
    private func updateBudgetCategory() {
        do {
            try budgetCategory.update(context: context, title: title, amount: amount ?? 0.0)
        } catch {
            showMessage(.error(error))
        }
    }
    
    private func saveTransaction() {
        let transaction = Transaction(title: transactionTitle, amount: transactionAmount ?? 0.0, quantity: transactionQuantity ?? 1)
        budgetCategory.addTransaction(context: context, transaction: transaction)
        transactionTitle = ""
        transactionAmount = nil
        transactionQuantity = 1
    }
    
    private func deleteTransaction(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let transaction = transactions[index]
            transaction.delete(context: context)
        }
    }
    
    var body: some View {
        
        Form {
            TextField("Title", text: $title)
            TextField("Amount", value: $amount, format: .currency(code: Locale.currencyCode))
                .keyboardType(.decimalPad)
            Button("Update") {
                updateBudgetCategory()
            }.disabled(!isBudgetCategoryFormValid)
                .buttonStyle(.bordered)
            
            
            Section("New Transaction") {
                TextField("Title", text: $transactionTitle)
                    .accessibilityIdentifier("transactionTitleTextField")
                
                TextField("Amount", value: $transactionAmount, format: .currency(code: Locale.currencyCode))
                    .keyboardType(.decimalPad)
                    .accessibilityIdentifier("transactionAmountTextField")
                
                TextField("Quantity", value: $transactionQuantity, format: .number)
                    .accessibilityIdentifier("transactionQuantityTextField")
                
                Button("Add Transaction") {
                    saveTransaction()
                }.buttonStyle(.bordered)
                .disabled(!isAddTransactionFormValid)
                .accessibilityIdentifier("addTransactionButton")
            }
            
            Section("Transactions") {
                VStack {
                    Text("Spent: \(String(describing: budgetCategory.total.formatted(.currency(code: Locale.currencyCode))))")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .accessibilityIdentifier("spentText")
                    
                    Text("Remaining: \(String(describing: budgetCategory.remaining.formatted(.currency(code: Locale.currencyCode))))")
                        .font(.caption)
                        .accessibilityIdentifier("remainingText")
                }
               
                List {
                    ForEach(transactionsByBudgetCategory) { transaction in
                        HStack {
                            Text("\(transaction.title) (\(transaction.quantity))")
                            Spacer()
                            Text(transaction.total, format: .currency(code: Locale.currencyCode))
                        }
                    }.onDelete(perform: deleteTransaction)
                }.accessibilityIdentifier("transactionList")
            }
        }
        .onAppear {
            title = budgetCategory.title
            amount = budgetCategory.amount
        }
        .navigationTitle(budgetCategory.title)
    }
}

struct BudgetDetailScreenContainer: View {
    
    @Query private var budgetCategories: [BudgetCategory]
    
    var body: some View {
        BudgetDetailScreen(budgetCategory: budgetCategories[0])
    }
}

#Preview { @MainActor in
    NavigationStack {
        BudgetDetailScreenContainer()
            .modelContainer(previewContainer)
            .withMessageWrapper()
    }
}
