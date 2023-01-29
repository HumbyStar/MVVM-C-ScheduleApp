//
//  EventCoordinator.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 24/01/23.
//

import UIKit

final class EventListCoordinator: Coordinator {
    private(set) var childCoordinator: [Coordinator] = []
    
    private let navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        let eventListViewController = EventListViewController()
        let eventListViewModel = EventListViewModel()
        eventListViewModel.coordinator = self
        eventListViewController.viewModel = eventListViewModel
        navigation.setViewControllers([eventListViewController], animated: false)
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
