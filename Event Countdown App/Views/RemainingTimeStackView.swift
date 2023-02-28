//
//  RemainingTimeStackView.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 16/02/23.
//

import UIKit

class RemainingTimeStackView: UIStackView {
    
    private let remainingTimeLabels = [UILabel(), UILabel(), UILabel(), UILabel()]
    
    func setup() {
        remainingTimeLabels.forEach({
            addArrangedSubview($0)
        })
        axis = .vertical
        distribution = .fillEqually
    }
    
    func update(with ViewModel: RemainingTimeViewModel) {
        remainingTimeLabels.forEach({
            $0.text = ""
            $0.font = .systemFont(ofSize: ViewModel.fontSize, weight: .regular)
            $0.textColor = .white
        })
        ViewModel.remainingTimeTexts.enumerated().forEach{
            remainingTimeLabels[$0.offset].text = $0.element
        }
        alignment = ViewModel.alignment
    }
}
