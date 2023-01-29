//
//  AddEventCoordinator.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 24/01/23.
//

import Foundation
import UIKit

class AddEventCoordinator: Coordinator {
    private(set) var childCoordinator: [Coordinator] = []
    
    private let navigation: UINavigationController
    
    var parentCoordinator: EventListCoordinator?
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        
        let addEventviewController = AddEventViewController()
        //modalNavigation.setViewControllers([addEventviewController], animated: false)
        let modalNavigation = UINavigationController(rootViewController: addEventviewController)
        let addEventViewModel = AddEventViewModel()
        addEventViewModel.coordinator = self
        addEventviewController.viewModel = addEventViewModel
        navigation.present(modalNavigation, animated: true)
        
        // Encontramos um bug, parece que o LargeTitle entra em conflito quando usamos modalNavigation.setViewControllers, então por isso ja montamos a navigation com uma rootViewController pois assim o bug parece ter solução
    }
    
    func didFinishAddEvent() {
        parentCoordinator?.childDidFinish(childcoordinator: self)
    }
    
    deinit {
        print("deinit from AddEventCoordinator")
    }
}
