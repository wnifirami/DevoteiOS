//
//  Persistence.swift
//  DevoteIos
//
//  Created by Rami Ounifi on 17/5/2021.
//

import CoreData

struct PersistenceController {
    // MARK: - Persistance controller
    static let shared = PersistenceController()
    // MARK: - Persistant container
    let container: NSPersistentContainer
    // MARK: - Initialization
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "DevoteIos")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    // MARK: - Preview
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<5 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = "sample task n\(i)"
            newItem.completion = false
            newItem.id = UUID()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
