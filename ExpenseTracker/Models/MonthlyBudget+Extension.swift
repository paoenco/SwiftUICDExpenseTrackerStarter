//
//  MonthlyBudget+Extension.swift
//  ExpenseTracker
//
//  Created by Paolo Encomienda on 2/2/2023.
//  Copyright © 2023 Alfian Losari. All rights reserved.
//

import CoreData
import Foundation

extension MonthlyBudget {
    var wrappedDate: Date { date ?? Date() }
    var wrappedName: String { name ?? "Unknown Name" }
    var wrappedExpenses: [ExpenseLog] {
        let set = expenses as? Set<ExpenseLog> ?? []
        return set.sorted { firstExpenseLog, secondExponseLog in
            (firstExpenseLog.date ?? Date()) < (secondExponseLog.date ?? Date())
        }
    }
}
