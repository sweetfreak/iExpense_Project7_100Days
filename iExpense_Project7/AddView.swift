//
//  AddView.swift
//  iExpense_Project7
//
//  Created by Jesse Sheehan on 8/21/24.
//
import SwiftData
import SwiftUI

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = "Name"
    @State private var type = "Personal"
    @State private var amount = 0.0
    //@State private var currency = "USD"
    
    //var expenses: Expenses
    
    static let types = ["Business", "Personal"]
    
    //let currencies = ["USD", "EUR", "AUD", "GNF", "BAM", "XAF", "BIF", "AED", "RWF", "SZL", "ILS", "NZD", "KYD", "TZS", "TWD", "CNY", "CHF", "INR", "THB", "RWF", "TRY", "CHF", "XOF"]
    let localCurrency = Locale.current.currency?.identifier ?? "USD"

    
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
//                    ForEach(types, id: \.self) {
//                        Text($0)
//                    }
                    
                    
                }
                
                TextField("Amount", value: $amount, format: .currency(code: localCurrency))
                    .keyboardType(.decimalPad)
                
//                Picker("Currency", selection: $currency) {
//                    ForEach(currencies, id:\.self) {
//                        Text($0)
//                    }
//                }.pickerStyle(.menu)
            }
            
            .navigationTitle("Add New Expense")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.red)
                }
                ToolbarItem(placement: .destructiveAction) {
                    if name != "Enter Purchase Title" && amount != 0.0  {
                        Button("Save") {
                            let item = ExpenseItem(name: name, type: type, amount: amount)
                            //expenses.items.append(item)
                            modelContext.insert(item)
                            dismiss()
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

#Preview {
    AddView()//expenses: Expenses())
        .modelContainer(for: ExpenseItem.self)
}
