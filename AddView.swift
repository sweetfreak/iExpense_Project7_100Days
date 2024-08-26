//
//  AddView.swift
//  iExpense_Project7
//
//  Created by Jesse Sheehan on 8/21/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var currency = "USD"
    
    var expenses: Expenses
    
    let types = ["Business", "Personal"]
    let currencies = ["USD", "EUR", "AUD", "GNF", "BAM", "XAF", "BIF", "AED", "RWF", "SZL", "ILS", "NZD", "KYD", "TZS", "TWD", "CNY", "CHF", "INR", "THB", "RWF", "TRY", "CHF", "XOF"]

    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: currency))
                    .keyboardType(.decimalPad)
                
                Picker("Currency", selection: $currency) {
                    ForEach(currencies, id:\.self) {
                        Text($0)
                    }
                }.pickerStyle(.menu)
            }
            
            .navigationTitle("Add New Expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount, currency: currency)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
