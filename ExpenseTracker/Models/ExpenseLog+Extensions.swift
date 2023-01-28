//
//  ExpenseLog+Extensions.swift
//  ExpenseTracker
//
//  Created by Paolo Encomienda on 26/1/2023.
//  Copyright © 2023 Alfian Losari. All rights reserved.
//

import Foundation
import CoreData

extension ExpenseLog {
    var categoryEnum: Category {
        Category(rawValue: category ?? "") ?? .other
    }
    
    var nameText: String { name ?? "" }
    
    var dateText: String { Utils.dateFormatter.localizedString(for: date ?? Date(), relativeTo: Date()) }
    
    var amountText: String { Utils.numberFormatter.string(from: NSNumber(value: amount?.doubleValue ?? 0)) ?? "" }
}
