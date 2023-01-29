//
//  EventListViewModel.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 24/01/23.
//

import Foundation

final class EventListViewModel {
    let title = "Events"
    var coordinator: EventListCoordinator?
    
    func tappedAddEvent() {
        coordinator?.startAddEvent() // Peço a coordinator chamar o método StartAddEvent, que ira executar o addEventCoordinator passando a navigation, e dentro da AddEventCoordinator será criado de fato a navigationController, e por ultimo é chamado o addEventCoordinator.start
    }
}
