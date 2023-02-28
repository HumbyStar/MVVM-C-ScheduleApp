//
//  EventDetailCoordinator.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 16/02/23.
//

import UIKit
import CoreData

class EventDetailCoordinator: Coordinator {
    private(set)var childCoordinator: [Coordinator] = []
    private let navigation: UINavigationController
    private let id: NSManagedObjectID
    var parentCoordinator: EventListCoordinator?
    var onUpdateEvent:() -> Void = {}
    
    init(navigation: UINavigationController, id: NSManagedObjectID) {
        self.id = id
        self.navigation = navigation
    }
    
    func start() {
        let eventDetailViewController = EventDetailViewController()
        let eventDetailViewModel = EventDetailViewModel(eventID: id)
        eventDetailViewModel.coordinator = self
        onUpdateEvent = {
            eventDetailViewModel.reload()
            self.parentCoordinator?.onUpdateEvent()
        }
        eventDetailViewController.viewModel = eventDetailViewModel
        navigation.pushViewController(eventDetailViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(childcoordinator: self)
    }
    
    func onEditEvent(event: Event) {
        let editEventCoordinator = EditEventCoordinator(event: event, navigation: navigation)
        editEventCoordinator.parentCoordinator = self
        childCoordinator.append(editEventCoordinator)
        editEventCoordinator.start()
    }
    
    deinit{
        print("EventDetailCoordinator saiu da memória")
    }
}
