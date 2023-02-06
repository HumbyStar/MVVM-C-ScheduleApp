//
//  ImagePickerCoordinator.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 31/01/23.
//

import UIKit

class ImagePickerCoordinator: NSObject, Coordinator {
    private(set)var childCoordinator: [Coordinator] = []
    private var navigation: UINavigationController?
    
    var parentCoordinator: AddEventCoordinator?
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        navigation?.present(imagePickerController, animated: true)
    }
    
    deinit {
        print("deinit from ImagePickerCoordinator")
    }
}

extension ImagePickerCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            parentCoordinator?.finishPickingMedia(image: image) 
            
            // Aqui é onde eu pego a imagem da galeria e entrego para o parametro da função finishPickingMedia, e lá iremos dizer para completion ser executada
        }
        parentCoordinator?.childDidFinish(coordinator: self)
    }
}
