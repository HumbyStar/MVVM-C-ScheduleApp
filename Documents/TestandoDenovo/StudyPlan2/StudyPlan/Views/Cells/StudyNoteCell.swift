//
//  StudyNoteCell.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 17/02/23.
//

import UIKit

final class StudyNoteCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy HH:mm"
        return formatter
    }()
    
    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var lbTopic: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemPurple
        label.font = .systemFont(ofSize: 16,weight: .regular)
        return label
    }()
    
    lazy var divView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.widthAnchor.constraint(equalToConstant: 1).isActive = true
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return view
    }()
    
    lazy var divView2: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.widthAnchor.constraint(equalToConstant: 1).isActive = true
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return view
    }()
    
    lazy var lbSubjectName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemPurple
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    lazy var lbDate: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemPurple
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var horizontalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lbTopic, divView2, lbSubjectName, divView, lbDate])
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 2
        return stackView
    }()    
    
    func update(with study: StudyPlan) {
        logoImage.image = UIImage(named: study.note.image?.rawValue ?? "Swift")
        lbTopic.text = study.topic
        lbSubjectName.text = study.subjectName
        lbDate.text = dateFormatter.string(from: study.date)
    }
}

extension StudyNoteCell: ViewCode {
    func buildHierarchy() {
        contentView.addSubview(logoImage)
        contentView.addSubview(horizontalStack)
    }
    func setupConstrains() {
        NSLayoutConstraint.activate([
            logoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 3),
            logoImage.heightAnchor.constraint(equalToConstant: 35),
            logoImage.widthAnchor.constraint(equalToConstant: 50),
            logoImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            horizontalStack.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor,constant: 10),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            horizontalStack.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
}
