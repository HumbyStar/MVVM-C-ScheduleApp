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
    weak var coordinator: EventListCoordinator?
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
        EventCellViewModel.imageCache.removeAllObjects()
        let events = coreDataManager.fetchEvents()
        cells = events.map{
            let eventCellViewModel = EventCellViewModel($0)
            // Aqui está o pulo do gato, fazemos um map no array que events tiver recebido após o fetch, onde esse map, passará cada elemento dentro dos parametros de EventCellViewModel
            if let coordinator = coordinator {
                eventCellViewModel.onSelect = coordinator.onSelect
            }
            return .normal(eventCellViewModel)
        }
        onUpdate()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> EventListViewModel.Cell {
        return cells[indexPath.row]
    }
    
    func didSelect(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .normal(let eventCellViewModel):
            eventCellViewModel.didSelect()
        default:
            break
        }
    }
    
    func tappedAddEvent() {
        coordinator?.startAddEvent() // Peço a coordinator chamar o método StartAddEvent, que ira executar o addEventCoordinator passando a navigation, e dentro da AddEventCoordinator será criado de fato a navigationController, e por ultimo é chamado o addEventCoordinator.start
    }
}
