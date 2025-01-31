//
//  MonthlyLogsView.swift
//  ExpenseTracker
//
//  Created by Paolo Encomienda on 4/2/2023.
//  Copyright © 2023 Alfian Losari. All rights reserved.
//

import CoreData
import SwiftUI

struct MonthlyLogsView: View {
    
    @Environment(\.managedObjectContext)
        var context: NSManagedObjectContext
    
    var budget: MonthlyBudget
    
    @State private var searchText : String = ""
    @State private var searchBarHeight: CGFloat = 0
    @State private var sortType = SortType.date
    @State private var sortOrder = SortOrder.descending
    
    @State var selectedCategories: Set<Category> = Set()
    @State var isAddFormPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(text: $searchText, keyboardHeight: $searchBarHeight, placeholder: "Search expenses")
            FilterCategoriesView(selectedCategories: $selectedCategories)
            Divider()
            SelectSortOrderView(sortType: $sortType, sortOrder: $sortOrder)
            Divider()
            MonthlyLogListView(budget: budget)
            Spacer()
//            LogListView(predicate: ExpenseLog.predicate(with: Array(selectedCategories), searchText: searchText),
//                        sortDescriptor: ExpenseLogSort(sortType: sortType, sortOrder: sortOrder).sortDescriptor)
        }
        .padding(.bottom, searchBarHeight)
        .sheet(isPresented: $isAddFormPresented) {
            LogFormView(context: context, budget: budget)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isAddFormPresented.toggle()
                } label: {
                    Label("Add", systemImage: "plus")
                }
            }
        }
        .navigationBarTitle("\(budget.wrappedName) Expenses", displayMode: .inline)
    }
}
