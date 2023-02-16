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
    private var modalNavigation: UINavigationController?
    
    var parentCoordinator: EventListCoordinator?
    var completion: (UIImage) -> Void = { _ in} // 1 -> Aqui eu criei a expressão
    // A Variável completion é uma closure que será chamada depois da seleção de imagem.
    
    //Em resumo, a closure "completion" permite que o objeto que chamou o método startImageCoordinator (AddEventViewModel) saiba quando a seleção de imagem foi concluída e receba a imagem selecionada.
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        let addEventviewController = AddEventViewController()
        self.modalNavigation = UINavigationController(rootViewController: addEventviewController)
        let addEventViewModel = AddEventViewModel(cellBuilder: CellBuilder())
        addEventViewModel.coordinator = self
        addEventviewController.viewModel = addEventViewModel
        if let modalNavigation = modalNavigation {
            navigation.present(modalNavigation, animated: true)
        }
        // Encontramos um bug, parece que o LargeTitle entra em conflito quando usamos modalNavigation.setViewControllers, então por isso ja montamos a navigation com uma rootViewController pois assim o bug parece ter solução.
    }
    
    func didFinishAddEvent() {
        parentCoordinator?.onSaveEvent()
        parentCoordinator?.childDidFinish(childcoordinator: self)
    }
    
    func startImagePicker(completion: @escaping (UIImage) -> Void) { //2 -> Aqui é onde de fato eu passo o parametro
        //print("Start image Picker")
        // Precisamos iniciar imagePickerCoordinator
        self.completion = completion // 3 -> Aqui é onde de fato eu coloco o parametro e o bloco executavel dentro da variavel completion.
        guard let modalNavigation = modalNavigation else {return}
        let imagePickerCoordinator = ImagePickerCoordinator(navigation: modalNavigation)
        imagePickerCoordinator.parentCoordinator = self
        imagePickerCoordinator.onFinishPicking = { image in
            completion(image)
        }
        childCoordinator.append(imagePickerCoordinator)
        imagePickerCoordinator.start()
    }

    func childDidFinish(coordinator: Coordinator) {
        if let index = childCoordinator.firstIndex(where: { coord in
            return coordinator === coord
        }) {
            childCoordinator.remove(at: index)
        }
    }
    
    func finishSaveEvent() {
        print(CoreDataManager().fetchEvents().first?.name)
        print("encerramos a tela")
        navigation.dismiss(animated: true)
    }
    
    deinit {
        print("deinit from AddEventCoordinator")
    }
}
