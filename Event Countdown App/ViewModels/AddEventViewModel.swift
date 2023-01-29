//
//  AddEventViewModel.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 24/01/23.
//

import Foundation
import UIKit

final class AddEventViewModel {
    
    enum cell {
        case titleSubtitle(TitleSubtitleCellViewMode) // Se eu quero uma célula A preciso alimenta-la com A
        case titleImage
    }
    
    let title = "Add"
    var coordinator: AddEventCoordinator?
    
    var onUpdate: () -> Void = {}
    
    // MARK: Ele criou um array de células, que nesse caso está vazio.
    private(set)var cells: [AddEventViewModel.cell] = []
   
    
    func viewDidDisappear() {
        coordinator?.didFinishAddEvent()
    }
    
    func viewDidLoad() { //MARK: Onde eu de fato crio as células do meu array Cells. Então quando eu chamar ViewDidLoad, as células serão criadas/carregadas.
        cells = [
            .titleSubtitle(TitleSubtitleCellViewMode(title: "Name", subtitle: "", placeholder: "Add a Name", type: .text, onUpdate: {})),
            .titleSubtitle(TitleSubtitleCellViewMode(title: "Date", subtitle: "", placeholder: "Select a Date", type: .date, onUpdate: {[weak self] in
                self?.onUpdate()
            }))
        ]
        onUpdate()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> AddEventViewModel.cell {
        return cells[indexPath.row] //Array está vazio mas irá retornar o indexPath.row do array quando pedido
    }
    
    func tappedInButton() {
        print("Botão foi clicado")
        print("Precisamos pegar as informações da tela Add e Adicionar no CoreData")
        print("Também por ultimo precisamos avisar pro Coordinator dar um dismiss")
    }
    
    func updateCell(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] { // Substitua a celula do index passado
        case .titleSubtitle(let titleSubtitleCellViewMode):
            titleSubtitleCellViewMode.update(title: subtitle)
        case .titleImage:
            break
        }
    }
    
    deinit {
        print("deinit from AddEventViewmodel")
    }
}
