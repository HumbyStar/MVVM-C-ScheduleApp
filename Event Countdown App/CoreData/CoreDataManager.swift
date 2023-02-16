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
    
    func getEvent(_ id: NSManagedObjectID) -> Event? {
        do {
            return try context.existingObject(with: id) as? Event
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func updateEvent(event: Event,name: String, date: Date, image: UIImage) {
        event.setValue(name, forKey: "name")// Ex: New Year
        let imageData = image.jpegData(compressionQuality: 1)
        event.setValue(imageData, forKey: "image")
        event.setValue(date, forKey: "date")
        do {
            try context.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func saveEvent(name: String, date: Date, image: UIImage) {
        let event = Event(context: context)
        event.setValue(name, forKey: "name")// Ex: New Year
        let imageData = image.jpegData(compressionQuality: 1)
        event.setValue(imageData, forKey: "image")
        event.setValue(date, forKey: "date")
        do {
            try context.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchEvents() -> [Event] { // Vamos montar meu array de Eventos
        do {
            let fetchRequest = NSFetchRequest<Event>(entityName: "Event")
            let events = try context.fetch(fetchRequest)
            return events
        }
        catch {
            print(error.localizedDescription)
            return []
        }
    }
}
