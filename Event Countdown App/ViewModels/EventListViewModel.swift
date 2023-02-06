//
//  EventListViewModel.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 24/01/23.
//

import Foundation

final class EventListViewModel {
    
    enum Cell {
        case normal(EventCellViewModel)
        case special
    }
    
    let title = "Events"
    var coordinator: EventListCoordinator?
    private(set)var cells: [Cell] = []
    private let coreDataManager: CoreDataManager
    var onUpdate = {}
    
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
        onUpdate()
    }
    
    func viewDidLoad() {
        reload()
    }
    
    func reload() {
        let events = coreDataManager.fetchEvents()
        cells = events.map{
            .normal(EventCellViewModel($0))
            // Aqui está o pulo do gato, fazemos um map no array que events tiver recebido após o fetch, onde esse map, passará cada elemento dentro dos parametros de EventCellViewModel
        }
        onUpdate()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> EventListViewModel.Cell {
        return cells[indexPath.row]
    }
    
    func tappedAddEvent() {
        coordinator?.startAddEvent() // Peço a coordinator chamar o método StartAddEvent, que ira executar o addEventCoordinator passando a navigation, e dentro da AddEventCoordinator será criado de fato a navigationController, e por ultimo é chamado o addEventCoordinator.start
    }
}
