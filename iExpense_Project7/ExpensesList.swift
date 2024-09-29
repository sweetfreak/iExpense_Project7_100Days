//
//  ExpenseSection.swift
    //ExpensesList.swift
//  iExpense_Project7
//
//  Created by Jesse Sheehan on 9/12/24.
//
import SwiftData
import SwiftUI

struct ExpensesList: View {

    @Environment(\.modelContext) var modelContext
    
    @Query private var expenses: [ExpenseItem]
    
//    let title: String
//    let expenses: [ExpenseItem]
//    let deleteItems: (IndexSet) -> Void
    
    
    
    let localCurrency = Locale.current.currency?.identifier ?? "USD"

    
    var body: some View {
        List {
            ForEach(expenses) { item in
                
                HStack {
                    
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        
                        Text(item.type)
                    }
                    Spacer()
                    
                    Text(item.amount, format: .currency(code: localCurrency))
                    // .foregroundStyle(item.amount < 10 ? .green : item.amount < 100 ? .black : .red)
                        .style(for: item)
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Purchased \(item.name) for \(item.amount.formatted(.currency(code: localCurrency)))")
                .accessibilityHint("\(item.type) expense.")
            }
            .onDelete(perform: removeItems) // deleteItems)
            
        }
    }
    
    init(type: String = "All", sortOrder: [SortDescriptor<ExpenseItem>]) {
        _expenses = Query(filter: #Predicate<ExpenseItem> {
            if type == "All" {
                return true
            } else {
                return $0.type == type
            }
        }, sort: sortOrder)
    }
    
//    func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
//       var objectsToDelete = IndexSet()
//        
//        for offset in offsets {
//            let item = inputArray[offset]
//            
//            if let index = expenses.items.firstIndex(of: item) {
//                objectsToDelete.insert(index)
//            }
//        }
//        expenses.items.remove(atOffsets: objectsToDelete)
//    }
    
    
    //TURNS INTO:
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let item = expenses[offset]
            modelContext.delete(item)
        }
    }
    
}

#Preview {
    ExpensesList(sortOrder: [SortDescriptor(\ExpenseItem.name)])
        .modelContainer(for: ExpenseItem.self)
}
