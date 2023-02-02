//
//  MonthlyFormView.swift
//  ExpenseTracker
//
//  Created by Paolo Encomienda on 30/1/2023.
//  Copyright © 2023 Alfian Losari. All rights reserved.
//

import SwiftUI

struct MonthlyFormView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var name = ""
    @State var date = Date()
    
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
        }
    }
    
    private func onSaveTapped() {
        
    }
}
