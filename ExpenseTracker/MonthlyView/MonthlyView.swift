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
    
    @State var isAddFormPresented: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(result) { budget in
                    Text(budget.name ?? "no budget name")
                }
            }
            .sheet(isPresented: $isAddFormPresented) {
                MonthlyFormView()
            }
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

}
