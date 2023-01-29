//
//  Coordinator.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 24/01/23.
//
// MARK: O uso do get e set no protocol e classe significa que a variavel childCoordinator só pode ficar acessível dentro dos mesmos, não podendo ser modificada ou chamada fora desse dois cenários.

import UIKit

final class AppCoordinator: Coordinator {
    private(set) var childCoordinator: [Coordinator] = []
    private let window: UIWindow
    
    init (window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigation = UINavigationController()
        let eventListCoordinator = EventListCoordinator(navigation: navigation)
        eventListCoordinator.start()
        childCoordinator.append(eventListCoordinator)
        
        
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
    
    
}
