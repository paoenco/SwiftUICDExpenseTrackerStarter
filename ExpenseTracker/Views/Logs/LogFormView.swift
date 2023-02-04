//
//  LogFormView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import CoreData

struct LogFormView: View {
    
    var logToEdit: ExpenseLog?
    var context: NSManagedObjectContext
    @ObservedObject var budget: MonthlyBudget
        
    @State var name: String = ""
    @State var amount: Double = 0
    @State var category: Category = .utilities
    @State var date: Date = Date()
    
    @Environment(\.presentationMode)
    var presentationMode
    
    var title: String {
        logToEdit == nil ? "Create Expense Log" : "Edit Expense Log"
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .disableAutocorrection(true)
                TextField("Amount", value: $amount, formatter: Utils.numberFormatter)
                    .keyboardType(.numbersAndPunctuation)
                    
                Picker(selection: $category, label: Text("Category")) {
                    ForEach(Category.allCases) { category in
                        Text(category.rawValue.capitalized).tag(category)
                    }
                }
                DatePicker(selection: $date, displayedComponents: .date) {
                    Text("Date")
                }
            }

            .navigationBarItems(
                leading: Button(action: self.onCancelTapped) { Text("Cancel")},
                trailing: Button(action: self.onSaveTapped) { Text("Save")}
            ).navigationBarTitle(title)
            
        }
        
    }
    
    private func onCancelTapped() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func onSaveTapped() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        let log: ExpenseLog
        if let logToEdit = logToEdit {
            log = logToEdit
        } else {
            log = ExpenseLog(context: context)
            log.id = UUID()
        }
        
        log.name = name
        log.category = category.rawValue
        log.amount = NSDecimalNumber(value: amount)
        log.date = date
        log.monthlyBudget = budget
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
}

//struct LogFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        return LogFormView()
//    }
//}
