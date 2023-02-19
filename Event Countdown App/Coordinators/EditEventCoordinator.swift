//
//  EditEventCoordinator.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 16/02/23.
//

import UIKit

class EditEventCoordinator: Coordinator {
    private(set)var childCoordinator: [Coordinator] = []
    private let navigation: UINavigationController
    private let event: Event
    var parentCoordinator: (EventUpdatingCoordinator & Coordinator)?
    var completion: (UIImage) -> Void = {_ in }
    
    init(event: Event, navigation: UINavigationController){
        self.navigation = navigation
        self.event = event
    }
    
    func start() {
        let editEventViewController = EditEventViewController()
        let editEventViewModel = EditEventViewModel(cellBuilder: CellBuilder(), event: event)
        editEventViewModel.coordinator = self
        editEventViewController.viewModel = editEventViewModel
        navigation.pushViewController(editEventViewController, animated: true)
    }
    
    func didFinishEditEvent() {
        childDidFinish(childcoordinator: self)
    }
    
    func finishEditEvent(){
        parentCoordinator?.onUpdateEvent()
        navigation.popViewController(animated: true)
    }
    
    func startImagePicker(completion: @escaping (UIImage) -> Void) {
        self.completion = completion
        let imagePickerCoordinator = ImagePickerCoordinator(navigation: navigation)
        imagePickerCoordinator.parentCoordinator = self
        imagePickerCoordinator.onFinishPicking = { image in
            completion(image)
        }
        childCoordinator.append(imagePickerCoordinator)
        imagePickerCoordinator.start()
    }
    
    
}
