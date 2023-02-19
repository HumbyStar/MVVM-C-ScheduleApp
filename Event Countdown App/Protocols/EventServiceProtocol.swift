//
//  EventServiceProtocol.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 19/02/23.
//

import Foundation
import CoreData

protocol EventServiceProtocol {
    func perform(_ action: EventService.EventAction, data: EventService.EventInputData)
    func getEvent(_ id: NSManagedObjectID) -> Event?
    func getAllEvents() -> [Event]
}
