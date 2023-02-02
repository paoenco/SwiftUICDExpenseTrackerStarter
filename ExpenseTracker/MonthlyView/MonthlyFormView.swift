//
//  MonthlyFormView.swift
//  ExpenseTracker
//
//  Created by Paolo Encomienda on 30/1/2023.
//  Copyright © 2023 Alfian Losari. All rights reserved.
//

import CoreData
import SwiftUI

struct MonthlyFormView: View {
    
    var budgetToEdit: MonthlyBudget?
    var context: NSManagedObjectContext
    
    @Environment(\.dismiss) var dismiss
    
    @State var name = ""
    @State var date = Date()
    
    var title: String {
        budgetToEdit == nil ? "Create Budget" : "Edit Budget"
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .autocorrectionDisabled()
                DatePicker(selection: $date, displayedComponents: .date) {
                    Text("Date")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Dismiss")
                    }
                }
                ToolbarItem {
                    Button {
                        onSaveTapped()
                    } label: {
                        Text("Save")
                    }
                }
            }
            .navigationTitle(title)
        }
    }
    
    private func onSaveTapped() {
        let budget: MonthlyBudget
        if let budgetToEdit {
            budget = budgetToEdit
        } else {
            budget = MonthlyBudget(context: context)
            budget.id = UUID()
        }
        
        budget.name = name
        budget.date = date
        
        do {
            try context.saveContext()
        } catch {
            print("save error: \(error.localizedDescription)")
        }
        
        dismiss()
    }
}
