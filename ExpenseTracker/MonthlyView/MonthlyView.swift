//
//  MonthlyView.swift
//  ExpenseTracker
//
//  Created by Paolo Encomienda on 30/1/2023.
//  Copyright © 2023 Alfian Losari. All rights reserved.
//

import CoreData
import SwiftUI

struct MonthlyView: View {
    
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(entity: MonthlyBudget.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \MonthlyBudget.date, ascending: false)])
    private var result: FetchedResults<MonthlyBudget>
    
    @State private var isAddFormPresented: Bool = false
    @State private var budgetToEdit: MonthlyBudget?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(result) { budget in
                    NavigationLink {
                        LogsTabView()
                    } label: {
                        Text(budget.name ?? "budget name not found")
                            .font(.headline)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            context.delete(budget)
                            try? context.saveContext()
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        
                        Button {
                            budgetToEdit = budget
                        } label: {
                            Label("Edit", systemImage: "square.and.pencil")
                        }
                    }
                }
                .onDelete(perform: onDelete)
                .sheet(item: $budgetToEdit, onDismiss: {
                    budgetToEdit = nil
                }) { budget in
                    MonthlyFormView(budgetToEdit: budget,
                                    context: context,
                                    name: budget.name ?? "",
                                    date: budget.date ?? Date())
                }
            }
            .sheet(isPresented: $isAddFormPresented, content: {
                MonthlyFormView(context: context)
            })
            .navigationTitle("Budgets")
            .toolbar {
                Button {
                    isAddFormPresented = true
                } label: {
                    Image(systemName: "plus")
                }
                
            }
        }
    }

    private func onDelete(with indexSet: IndexSet) {
        indexSet.forEach { index in
            let budget = result[index]
            context.delete(budget)
        }
        
        try? context.saveContext()
    }
}
