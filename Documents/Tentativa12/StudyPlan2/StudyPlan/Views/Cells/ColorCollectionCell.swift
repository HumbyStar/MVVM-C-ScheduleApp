//
//  MyCollectionCell.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 17/02/23.
//

import UIKit

final class ColorCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       configureViewCode()
    }
    
    lazy var noteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? UIColor.systemPurple : .clear
        }
    }
    
    //Ao invés de chamar uma função também posso fazer com variavel computada.
//    lazy var color: Colors = .black {
//        didSet {
//            self.noteView.backgroundColor = color.value
//        }
//    }
    
    func setupCell(with color: UIColor) {
        self.noteView.backgroundColor = color
    }
}

extension ColorCollectionCell: ViewCode {
    func buildHierarchy() {
        contentView.addSubview(noteView)
    }
    func setupConstrains() {
        NSLayoutConstraint.activate([
            self.noteView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.noteView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.noteView.heightAnchor.constraint(equalToConstant: 50),
            self.noteView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
