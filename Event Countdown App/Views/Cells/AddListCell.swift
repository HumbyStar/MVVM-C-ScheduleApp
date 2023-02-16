//
//  TitleSubtitleCell.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 27/01/23.
//

import UIKit

class AddListCell: UITableViewCell {
    private let titleLabel = UILabel()
    let subtitleTextfield = UITextField()
    private var stackVertical = UIStackView()
    private let constant: CGFloat = 15
    
    private var viewModel: TitleSubtitleCellViewMode?
    
    var datePicker = UIDatePicker(frame: .init(x: 100, y: 300, width: 100, height: 100))
    private let toolbar = UIToolbar(frame: .init(x: 0, y: 0, width: 100, height: 40))
    
    var photoImage = UIImageView()
    
    lazy var doneButton: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with viewModel: TitleSubtitleCellViewMode) {
        self.viewModel = viewModel // Referente ao parametro, lembra estamos alimentando com um TitleSubtitleViewModel
        titleLabel.text = viewModel.title
        subtitleTextfield.text = viewModel.subtitle
        subtitleTextfield.placeholder = viewModel.placeholder
        
        
        subtitleTextfield.inputView = viewModel.type == .text ? nil : datePicker
        subtitleTextfield.inputAccessoryView = viewModel.type == .text ? nil : toolbar
        
        self.photoImage.isHidden = viewModel.type != .image
        self.subtitleTextfield.isHidden = viewModel.type == .image
        photoImage.image = viewModel.image
    }
    
    @objc func tappedDone() {
        viewModel?.update(date: datePicker.date)
    }
}

extension AddListCell: ViewCode {
    func buildHierarquic() {
        contentView.addSubview(stackVertical)
        stackVertical.addArrangedSubview(titleLabel)
        stackVertical.addArrangedSubview(subtitleTextfield)
        stackVertical.addArrangedSubview(photoImage)
    }
    func setupConstraint() {
        NSLayoutConstraint.activate([
            stackVertical.topAnchor.constraint(equalTo: contentView.topAnchor, constant: constant),
            stackVertical.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constant),
            stackVertical.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constant),
            stackVertical.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -constant),
            
            photoImage.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    func extrasFeatures() {
        stackVertical.axis = .vertical
        titleLabel.font = .systemFont(ofSize: 22,weight: .medium)
        subtitleTextfield.font = .systemFont(ofSize: 20,weight: .medium)
        subtitleTextfield.textColor = .black
        contentView.backgroundColor = .white
        titleLabel.textColor = .black
        
        [stackVertical, titleLabel, subtitleTextfield].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        datePicker.preferredDatePickerStyle = .wheels// Ou seja só faltava isso aqui antes.
        datePicker.datePickerMode = .date
        toolbar.backgroundColor = .white
        toolbar.setItems([doneButton], animated: true)
        photoImage.layer.cornerRadius = 10
        photoImage.backgroundColor = .lightGray
        stackVertical.spacing = viewModel?.type == .image ? 16 : 1
        
    }
}
