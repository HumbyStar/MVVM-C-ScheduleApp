//
//  EventCellViewModel.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 04/02/23.
//

import UIKit

class EventCellViewModel {
    
    let event: Event // Só é possivel montar cada event, graças a essa propriedade..
    let date = Date()
    private static let imageCache = NSCache<NSString,UIImage>()
    private let imageQueue = DispatchQueue(label: "imageQueue", qos: .background)
    // .background como QoS, você está indicando que a tarefa que será executada na fila de imagens (imageQueue) tem prioridade baixa e pode ser executada a qualquer momento, dependendo da disponibilidade de recursos.
    
    private var cacheKey: String {
        event.objectID.description
    }
    
    init (_ event: Event) { //Aqui construímos de fato o evento... 
        self.event = event
    }
    
    var timeRemainingStrings: [String] {
        guard let eventDate = event.date else {return []}
        return date.timeRemaining(until: eventDate)?.components(separatedBy: ",") ?? []
    }
    
    var dateText: String {
        guard let eventDate = event.date else {return ""}
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: eventDate)
    }
    
    var eventName: String? {
        event.name
    }
    
    //Se minha imagem recuperar a imagem de cache através da cacheKey como NSString
    func loadImage(completion: @escaping (UIImage) -> Void) {
        if let image = Self.imageCache.object(forKey: cacheKey as NSString) {
            completion(image)
        } else {
            imageQueue.async {
                guard let imageData = self.event.image, let image = UIImage(data: imageData) else {
                    completion(UIImage())
                    return
                }
                Self.imageCache.setObject(image, forKey: self.cacheKey as NSString)
                DispatchQueue.main.async { // Preciso voltar a imagem pra thread principal
                    completion(image)
                }
            }
        }
    }
}
