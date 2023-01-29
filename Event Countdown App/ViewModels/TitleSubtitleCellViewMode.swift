//
//  TitleSubtitleCellViewMode.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 27/01/23.
//
// MARK: Porque não usar um struct nesse cenario?
// Iremos usar mais pra frente usar um call e a propriedade subtitle será atualizada aqui, então conforme a complexidade aumenta faz mais sentido usarmos uma classe para isso.

import Foundation

final class TitleSubtitleCellViewMode {
    
    enum CellType {
        case text
        case date
    }
    
    let title: String
    private(set) var subtitle: String
    let placeholder: String
    let type: CellType
    private(set)var onUpdate: () -> Void = {}
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyy"
        return formatter
    }()
    
    init(title: String, subtitle: String, placeholder: String, type: CellType, onUpdate: @escaping () -> Void) {
        self.title = title
        self.subtitle = subtitle
        self.placeholder = placeholder
        self.type = type
        self.onUpdate = onUpdate
    }
    
    func update(title: String) {
        self.subtitle = title
    }
    
    func update(date: Date) {
        let date = dateFormatter.string(from: date)
        self.subtitle = date
        // realizar reload na celula de alguma forma
    }
}
