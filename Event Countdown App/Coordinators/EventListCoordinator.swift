//
//  EventCoordinator.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 24/01/23.
//

import UIKit
import CoreData

final class EventListCoordinator: Coordinator, EventUpdatingCoordinator {
    private(set) var childCoordinator: [Coordinator] = []
    
    private let navigation: UINavigationController
    var onUpdateEvent = {} // Uma call que chamará uma função
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        let eventListViewController = EventListViewController()
        let eventListViewModel = EventListViewModel()
        eventListViewModel.coordinator = self
        onUpdateEvent = eventListViewModel.reload
        eventListViewController.viewModel = eventListViewModel
        navigation.setViewControllers([eventListViewController], animated: false)
    }
    
    func onSelect(_ id: NSManagedObjectID){
        print(id)
        let eventDetailCoordinator = EventDetailCoordinator(navigation: navigation, id: id)
        eventDetailCoordinator.parentCoordinator = self
        childCoordinator.append(eventDetailCoordinator)
        eventDetailCoordinator.start()
    }
    
    func startAddEvent() {
        let addEventCoordinator = AddEventCoordinator(navigation: navigation)
        addEventCoordinator.parentCoordinator = self
        childCoordinator.append(addEventCoordinator)
        addEventCoordinator.start()
    }
    
    func childDidFinish(childcoordinator: Coordinator){
        if let index = childCoordinator.firstIndex(where: { coordinator in
            return childcoordinator === coordinator
        }) {
            childCoordinator.remove(at: index)
        }
    }
}

