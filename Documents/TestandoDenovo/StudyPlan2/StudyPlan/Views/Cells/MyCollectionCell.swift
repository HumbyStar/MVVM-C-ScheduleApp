//
//  MyCell.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 20/01/23.
//

import UIKit

final class MyCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let bannerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.4
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lbQuestion: UILabel = {
        let label = UILabel()
        label.text = "Qual é a forma correta de declarar uma closure?"
        label.numberOfLines = 2
        label.font = UIFont(name: "Courier-Bold", size: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemYellow
        return label
    }()
    
    var lbOption1: UILabel = {
        let label = UILabel()
        label.text = "A: func closure () {}"
        label.font = UIFont(name: "Courier-Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemYellow
        label.numberOfLines = 2
        return label
    }()
    
    var lbOption2: UILabel = {
        let label = UILabel()
        label.text = "B: typealias closure = Double"
        label.font = UIFont(name: "Courier-Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemYellow
        label.numberOfLines = 2
        return label
    }()
    
    var lbOption3: UILabel = {
        let label = UILabel()
        label.text = "C: {(Parameter) -> String in }"
        label.font = UIFont(name: "Courier-Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemYellow
        label.numberOfLines = 2
        return label
    }()
    
    var lbOption4: UILabel = {
        let label = UILabel()
        label.text = "D: var myClosure = numeros.enumerated()"
        label.font = UIFont(name: "Courier-Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .systemYellow
        return label
    }()
}

extension MyCollectionCell: ViewCode {
    func buildHierarchy() {
        contentView.addSubview(bannerView)
        contentView.addSubview(lbQuestion)
        contentView.addSubview(lbOption1)
        contentView.addSubview(lbOption2)
        contentView.addSubview(lbOption3)
        contentView.addSubview(lbOption4)
    }
    
    func setupConstrains() {
        NSLayoutConstraint.activate([
            
            bannerView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            bannerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            bannerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -70),
            bannerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -160),
            
            lbQuestion.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            lbQuestion.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            lbQuestion.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 12),
            lbQuestion.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -60),
            
            lbOption1.topAnchor.constraint(equalTo: lbQuestion.bottomAnchor, constant: 15),
            lbOption1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            lbOption1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -60),
            
            lbOption2.topAnchor.constraint(equalTo: lbOption1.bottomAnchor, constant: 15),
            lbOption2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            lbOption2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -60),
            
            lbOption3.topAnchor.constraint(equalTo: lbOption2.bottomAnchor, constant: 15),
            lbOption3.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            lbOption3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -60),
            
            lbOption4.topAnchor.constraint(equalTo: lbOption3.bottomAnchor, constant: 15),
            lbOption4.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            lbOption4.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -60)
        ])
    }
    
    func extrasFeatures() {
        print("")
    }
    
    
}
