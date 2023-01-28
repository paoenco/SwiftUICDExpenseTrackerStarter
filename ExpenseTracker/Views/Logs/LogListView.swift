//
//  LogListView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import CoreData

struct LogListView: View {

    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    @FetchRequest(entity: ExpenseLog.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \ExpenseLog.date, ascending: false)])
    private var result: FetchedResults<ExpenseLog>
    
    init(predicate: NSPredicate?, sortDescriptor: NSSortDescriptor) {
        let fetchRequest = NSFetchRequest<ExpenseLog>(entityName: ExpenseLog.entity().name ?? "ExpenseLog")
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        
        _result = FetchRequest(fetchRequest: fetchRequest)
    }
    
    var body: some View {
        List {
            ForEach(result) { log in
                Button {
                    // TODO: Implement Edit
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
            .onDelete(perform: onDelete)
        }
    }
    
    private func onDelete(with indexSet: IndexSet) {
        // TODO: Implement Delete
    }
}

//struct LogListView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogListView()
//    }
//}
