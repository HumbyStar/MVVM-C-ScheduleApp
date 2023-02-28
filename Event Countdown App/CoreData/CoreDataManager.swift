//
//  CoreDataManager.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 24/01/23.
//

import CoreData
import UIKit

final class CoreDataManager {
    static let shared = CoreDataManager()
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "EventCountdownApp")
        persistentContainer.loadPersistentStores { _,error in
            print(error?.localizedDescription ?? "")
        }
        return persistentContainer
    }()
    
    var context: NSManagedObjectContext {
       return persistentContainer.viewContext
    }
    
    func get<T: NSManagedObject>(_ id: NSManagedObjectID) -> T? {
        do {
            return try context.existingObject(with: id) as? T
        } catch {
            print(error)
        }
        return nil
    }
    
    func save() {
        do {
            try context.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func getAll<T:NSManagedObject>() -> [T] {
        do{
            let fetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
//            let backgroundContext = persistentContainer.newBackgroundContext()
//            backgroundContext.perform {
//                   ESTUDAR SUA IMPLEMENTAÇÃO MAIS TARDAR
//            }
            return try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
