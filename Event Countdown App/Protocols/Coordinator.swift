//
//  Coordinator.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 26/01/23.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinator: [Coordinator] {get}
    func start()
    func childDidFinish(childcoordinator: Coordinator)
}

extension Coordinator {
    func childDidFinish(childcoordinator: Coordinator) {
        
    }
}
