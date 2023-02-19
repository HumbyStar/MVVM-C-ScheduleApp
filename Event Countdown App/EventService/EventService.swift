//
//  EventService.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 19/02/23.
//

import UIKit
import CoreData


final class EventService: EventServiceProtocol {
    enum EventAction{
        case add
        case update(Event)
    }
    
    struct EventInputData {
        let name: String
        let date: Date
        let image: UIImage
    }
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    
    func perform(_ action: EventAction, data: EventInputData) {
        var event: Event
        
        switch action {
        case .add:
            event = Event(context: coreDataManager.context)
        case .update(let eventUpdate):
            event = eventUpdate
        }
        event.setValue(data.name, forKey: "name")
        let resizedImage = data.image.resizeTheImage(newHeight: 250)
        let imageData = resizedImage.jpegData(compressionQuality: 0.5)
        event.setValue(imageData, forKey: "image")
        event.setValue(data.date, forKey: "date")
        coreDataManager.save()
    }
    
    func getEvent(_ id: NSManagedObjectID) -> Event? {
        coreDataManager.get(id)
    }
    
    func getAllEvents() -> [Event] {
        coreDataManager.getAll()
    }
}
