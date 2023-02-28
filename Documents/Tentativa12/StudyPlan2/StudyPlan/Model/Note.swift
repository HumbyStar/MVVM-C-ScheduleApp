//
//  Note.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 16/02/23.
//
// Minha Classe Note criará uma Nota, contendo View, Cor(escolha do usuário), Fonte, imagem da linguagem em si

import UIKit

struct Note: Codable {
    let color: Colors?
    var font: String = "Courier-Bold"
    let image: ImagesLG?
    let noteText: String?
    
    
    var defaultTextColor: UIColor {
        switch color {
        case .black:
            return .white
        case .green:
            return .black //UIColor(red: 75/255.0, green: 0/255.0, blue: 130/255.0, alpha: 1.0)
        case .yellow:
            return .black//.red
        case .orange:
            return .orange
        case .purple:
            return .yellow
        case .red:
            return .black
        case .none:
            return .black
        }
    }
}
