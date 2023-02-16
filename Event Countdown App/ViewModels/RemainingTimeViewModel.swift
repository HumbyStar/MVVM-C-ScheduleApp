//
//  RemainingTimeViewModel.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 16/02/23.
//

import UIKit

class RemainingTimeViewModel {
    enum Size {
        case normal
        case huge
    }

    let remainingTimeTexts: [String]
    let size: Size
    
    
    init(remainingTimeTexts: [String], textSize: Size) {
        self.remainingTimeTexts = remainingTimeTexts
        self.size = textSize
    }
    
    
    var fontSize: CGFloat {
        switch size {
        case .normal:
            return 25
        case .huge:
            return 50
        }
    }
    
    var alignment: UIStackView.Alignment {
        switch size {
        case .normal:
            return .trailing
        case .huge:
            return .center
        }
    }
}

