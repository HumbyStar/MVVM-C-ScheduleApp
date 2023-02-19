//
//  EventDetailViewModel.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 16/02/23.
//

import UIKit
import CoreData

final class EventDetailViewModel {
    private let eventID: NSManagedObjectID
    private let eventService: EventServiceProtocol
    weak var coordinator: EventDetailCoordinator?
    private let date = Date()
    
    private var event: Event? // Por que eu preciso da variavel Event aqui? No escopo.
    var onUpdate = {}
    var imageBackground: UIImage {
        guard let imageData = event?.image, let image = UIImage(data: imageData) else {return UIImage()}
        return image
    }
    
    init(eventID: NSManagedObjectID, eventService: EventServiceProtocol = EventService()) {
        self.eventID = eventID
        self.eventService = eventService
    }
    
    var remainingTimeViewModel: RemainingTimeViewModel? {
        guard let eventDate = event?.date, let remainingTimeTexts = date.timeRemaining(until: eventDate)?.components(separatedBy: " e ") else {return nil}
        var remainingTimeTextsEdited = [String]()
        for world in remainingTimeTexts {
            remainingTimeTextsEdited.append(contentsOf: world.components(separatedBy: ","))
        }
        return RemainingTimeViewModel(remainingTimeTexts: remainingTimeTextsEdited, textSize: .huge)
    }
    
    func viewDidLoad() {
        reload()
    }
    
    func reload() {
        event = eventService.getEvent(eventID)
        onUpdate()
    }
    
    @objc func tappedInEdit() {
        guard let event = event else {return}
        coordinator?.onEditEvent(event: event)
    }
    
    func viewDidDisappear(){
        coordinator?.didFinish()
    }
    
    
}
