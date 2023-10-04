//
//  BudgetListScreen.swift
//  SpendSmart
//
//  Created by Mohammad Azam on 9/30/23.
//

import SwiftUI
import SwiftData

struct BudgetListScreen: View {
    
    @Query private var budgetCategories: [BudgetCategory]
    @State private var isPresented: Bool = false
    
    private var total: Decimal {
        budgetCategories.reduce(0) { result, budgetCategory in
            result + budgetCategory.amount
        }
    }
    
    private var remaining: Decimal {
        budgetCategories.reduce(0) { result, budgetCategory in
            result + (budgetCategory.remaining)
        }
    }
    
    var body: some View {
        List {
            ForEach(budgetCategories) { budgetCategory in
                NavigationLink {
                    BudgetDetailScreen(budgetCategory: budgetCategory)
                } label: {
                    BudgetCategoryView(budgetCategory: budgetCategory)
                }
            }
            
            VStack {
                Text("Total: \(String(describing: total.formatted(.currency(code: Locale.currencyCode))))")
                    .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
                Text("Remaining: \(String(describing: remaining.formatted(.currency(code: Locale.currencyCode))))")
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
           
        }.accessibilityIdentifier("budgetCategoryList")
        .navigationTitle("Spend Smart")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add category") {
                    isPresented = true
                }.accessibilityIdentifier("AddBudgetCategoryButton")
            }
        }.sheet(isPresented: $isPresented, content: {
            NavigationStack {
                AddBudgetCategoryScreen()
                    .withMessageWrapper()
            }
        })
    }
}

struct BudgetCategoryView: View {
    
    let budgetCategory: BudgetCategory
    
    var body: some View {
        HStack {
            Text(budgetCategory.title)
            Spacer()
            Text(budgetCategory.amount, format: .currency(code: Locale.currencyCode))
        }
    }
}

#Preview { @MainActor in 
    NavigationStack {
        BudgetListScreen()
            .modelContainer(previewContainer)
            .withMessageWrapper()
    }
}
