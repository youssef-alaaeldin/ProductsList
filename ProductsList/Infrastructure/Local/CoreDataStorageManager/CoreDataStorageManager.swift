//
//  CoreDataStorageManager.swift
//  ProductsList
//
//  Created by Yousuf Abdelfattah on 10/05/2025.
//

import CoreData

class CoreDataStorageManager: StorageManagerProtocol {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: AppConstants.coreDataContainer)
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("CoreData Save error: \(error)")
            }
        }
    }
    
    func save<Entity: NSManagedObject>(_ type: Entity.Type, count: Int, configure: (Entity, Int) -> Void) {
        clear(type)

        for index in 0..<count {
            let entity = Entity(context: context)
            configure(entity, index)
        }

        saveContext()
    }
    
    func fetch<T: NSManagedObject>(_ type: T.Type) -> [T] {
        let entityName = String(describing: T.self)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            guard let results = try context.fetch(fetchRequest) as? [T] else { return [] }
            return results
        } catch {
            print("Failed to fetch \(T.self): \(error)")
            return []
        }
    }
    
    func clear<T: NSManagedObject>(_ type: T.Type) {
        let entityName = String(describing: T.self)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Failed to clear \(T.self): \(error)")
        }
    }
}
