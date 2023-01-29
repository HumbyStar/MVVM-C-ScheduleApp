//
//  TitleSubtitleCell.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 27/01/23.
//

import UIKit

class TitleSubtitleCell: UITableViewCell {
    private let titleLabel = UILabel()
    let subtitleTextfield = UITextField()
    private var stackVertical = UIStackView()
    private let constant: CGFloat = 15
    
    private var viewModel: TitleSubtitleCellViewMode?
    
    var datePicker = UIDatePicker(frame: .init(x: 100, y: 300, width: 100, height: 100))
    private let toolbar = UIToolbar(frame: .init(x: 0, y: 0, width: 100, height: 40))
    
    
    lazy var doneButton: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapped))
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with viewModel: TitleSubtitleCellViewMode) {
        titleLabel.text = viewModel.title
        subtitleTextfield.text = viewModel.subtitle
        subtitleTextfield.placeholder = viewModel.placeholder
        subtitleTextfield.inputView = viewModel.type == .text ? nil : datePicker
        subtitleTextfield.inputAccessoryView = viewModel.type == .text ? nil : toolbar
    }
    
    @objc func tapped() {
        viewModel?.update(date: datePicker.date)
    }
}

extension TitleSubtitleCell: ViewCode {
    func buildHierarquic() {
        contentView.addSubview(stackVertical)
        stackVertical.addArrangedSubview(titleLabel)
        stackVertical.addArrangedSubview(subtitleTextfield)
    }
    func setupConstraint() {
        NSLayoutConstraint.activate([
            stackVertical.topAnchor.constraint(equalTo: contentView.topAnchor, constant: constant),
            stackVertical.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constant),
            stackVertical.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: constant),
            stackVertical.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -constant)
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
        toolbar.backgroundColor = .white
        toolbar.setItems([doneButton], animated: true)
        
    }
}
