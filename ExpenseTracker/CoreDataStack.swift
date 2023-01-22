//
//  CoreDataStack.swift
//  ExpenseTracker
//
//  Created by Paolo Encomienda on 22/1/2023.
//  Copyright © 2023 Alfian Losari. All rights reserved.
//

import CoreData

class CoreDataStack {
    private let containerName: String
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as? NSError {
                print(error.localizedDescription)
            }
            print(storeDescription)
        }
        
        return container
    }()
    
    var viewContext: NSManagedObjectContext { persistentContainer.viewContext }
    
    init(containerName: String) {
        self.containerName = containerName
    }
}

extension NSManagedObjectContext {
    func saveContext() throws {
        guard hasChanges else { return }
        try save()
    }
}
