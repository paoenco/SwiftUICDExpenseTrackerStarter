//
//  MonthlyLogListView.swift
//  ExpenseTracker
//
//  Created by Paolo Encomienda on 4/2/2023.
//  Copyright © 2023 Alfian Losari. All rights reserved.
//

import CoreData
import SwiftUI

struct MonthlyLogListView: View {
    @Environment(\.managedObjectContext) private var context: NSManagedObjectContext
    @ObservedObject var budget: MonthlyBudget
    
    @State private var logToEdit: ExpenseLog?
    
    var body: some View {
        List {
            ForEach(budget.wrappedExpenses) { log in
                Button {
                    logToEdit = log
                } label: {
                    HStack(spacing: 16) {
                        CategoryImageView(category: log.categoryEnum)
                        VStack {
                            Text(log.nameText)
                                .font(.headline)
                            Text(log.dateText)
                                .font(.subheadline)
                        }
                        Spacer()
                        Text(log.amountText)
                            .font(.headline)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }
}

//struct MonthlyLogListView_Previews: PreviewProvider {
//    static var previews: some View {
//        MonthlyLogListView()
//    }
//}
