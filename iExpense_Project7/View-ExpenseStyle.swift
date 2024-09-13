//
//  View-ExpenseStyle.swift
//  iExpense_Project7
//
//  Created by Jesse Sheehan on 9/11/24.
//

import SwiftUI

extension View {
    func style(for item: ExpenseItem) -> some View  {
        if item.amount < 10 {
            return self.font(.body)
        } else if item.amount < 100 {
            return self.font(.title3)
        } else {
            return self.font(.title)
        }
    }
}
