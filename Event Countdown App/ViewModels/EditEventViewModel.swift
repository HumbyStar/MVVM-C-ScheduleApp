//
//  EditEventViewModel.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 16/02/23.
//

import UIKit
import CoreData

final class EditEventViewModel {
    
    enum cell {
        case titleSubtitle(TitleSubtitleCellViewMode) // É tipo um IF para 2 tipos de células que irão ser diferentes, caso celula A, montará de um jeito, caso celula B montará de outro jeito.
        case titleImage
    }
    
    // MARK: Ele criou um array de células, que nesse caso está vazio.
    
    private(set)var cells: [AddEventViewModel.cell] = []
    
    let title = "Add"
    
    weak var coordinator: EditEventCoordinator?
    var onUpdate: () -> Void = {}
    var cellBuilder: CellBuilder
    var coreDataManager: CoreDataManager
    var event: Event
    
    var nameCellViewModel: TitleSubtitleCellViewMode?
    var dateCellViewModel: TitleSubtitleCellViewMode?
    var backgroundImageCellViewModel: TitleSubtitleCellViewMode?
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyy"
        return formatter
    }()
    
    init(cellBuilder: CellBuilder, coreDataManager: CoreDataManager = CoreDataManager.shared, event: Event) {
        self.cellBuilder = cellBuilder
        self.coreDataManager = coreDataManager
        self.event = event
    }
   
    
    func viewDidDisappear() {
        coordinator?.didFinishEditEvent()
    }
    
    func viewDidLoad() { //MARK: Onde eu de fato crio as células do meu array Cells. Então quando eu chamar ViewDidLoad, as células serão criadas/carregadas.
        
        setupCells()
        onUpdate()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> AddEventViewModel.cell {
        return cells[indexPath.row] //Array está vazio mas irá retornar o indexPath.row do array quando pedido
    }
    
    func tapToUpdate() {
        guard let name = nameCellViewModel?.subtitle, let dateString = dateCellViewModel?.subtitle, let image = backgroundImageCellViewModel?.image, let date = dateFormatter.date(from: dateString) else {return}
        coreDataManager.updateEvent(event: event, name: name, date: date, image: image)
        coordinator?.finishEditEvent()
    }
    
    func updateCell(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] { // Substitua a celula do index passado
        case .titleSubtitle(let titleSubtitleCellViewMode):
            titleSubtitleCellViewMode.update(title: subtitle)
        case .titleImage:
            break
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        //Por que o return cells[indexPath.row] não deu certo? Primeiro que pra retornar uma função eu preciso devolver um valor
        
        // Precisamos nesse caso fazer um switch, para acessar o tipo titleSubtitleCellViewModel que tem as caracteristicas dos dados que iremos construir e repassar para AddEventViewController.
        
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            guard titleSubtitleCellViewModel.type == .image else {return}
            coordinator?.startImagePicker(completion: { image in
                titleSubtitleCellViewModel.update(image: image)
            })
                // Chamamos o método e passamos que a imagem que retornar será atribuída ao titleSubtitleCellViewModel, porém precisamos esperar ela retornar
        default:
            break
        }
    }
    
    deinit {
        print("deinit from AddEventViewmodel")
    }
}

extension EditEventViewModel {
    func setupCells() {
        nameCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(type: .text)
        dateCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(type: .date) { [weak self] in
            self?.onUpdate()
        }
        backgroundImageCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(type: .image) { [weak self] in
            self?.onUpdate()
        }
        
        guard let nameCellViewModel = nameCellViewModel, let dateCellViewModel = dateCellViewModel, let backgroundImageCellViewModel = backgroundImageCellViewModel else {return}
        
        cells = [.titleSubtitle(nameCellViewModel),
                 .titleSubtitle(dateCellViewModel),
                 .titleSubtitle(backgroundImageCellViewModel)]
        
        
        guard let name = event.name, let date = event.date, let imageData = event.image, let image = UIImage(data: imageData) else {return}
        
        nameCellViewModel.update(title: name)
        dateCellViewModel.update(date: date)
        backgroundImageCellViewModel.update(image: image)
    }
}

