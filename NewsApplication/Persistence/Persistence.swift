//
//  Persistence.swift
//  NewsApplication
//
//  Created by Ayush on 16/09/24.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "YourDataModelName")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error loading Core Data stack: \(error)")
            }
        }
    }

    func save(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
