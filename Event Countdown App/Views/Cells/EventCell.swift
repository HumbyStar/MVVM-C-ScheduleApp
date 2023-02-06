//
//  EventCell.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 04/02/23.
//

import UIKit

class EventCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var timeRemainingLabels = [UILabel(), UILabel(), UILabel(), UILabel()]
    private var lbDate = UILabel()
    private var lbEvent = UILabel()
    private var backgroundImage = UIImageView()
    private var stackView = UIStackView()
    private var view = UIView()
    
    func update(with viewModel: EventCellViewModel) {
        viewModel.timeRemainingStrings.enumerated().forEach{
            timeRemainingLabels[$0.offset].text = $0.element
        }
        lbDate.text = viewModel.dateText
        lbEvent.text = viewModel.eventName
        viewModel.loadImage { image in
            self.backgroundImage.image = image
        }
    }
}

extension EventCell: ViewCode {
    func buildHierarquic() {
        contentView.addSubview(backgroundImage)
        contentView.addSubview(stackView)
        contentView.addSubview(lbEvent)
    }
    func setupConstraint() {
        backgroundImage.pinEdgesToConstrains(edges: [.top, .leading, .trailing])
        let bottomConstraint = backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        bottomConstraint.priority = .required - 1
        bottomConstraint.isActive = true
        backgroundImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
        stackView.pinEdgesToConstrains(edges: [.top, .trailing, .bottom])
        lbEvent.pinEdgesToConstrains(edges: [.bottom, .leading])
        
    }
    func extrasFeatures() {
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        lbEvent.translatesAutoresizingMaskIntoConstraints = false
        timeRemainingLabels.forEach {
            stackView.addArrangedSubview($0)
            $0.font = .systemFont(ofSize: 28, weight: .medium)
            $0.textColor = .white
        }
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(lbDate)
        
        lbDate.font = .systemFont(ofSize: 22, weight: .medium)
        lbDate.textColor = .white
        lbEvent.font = .systemFont(ofSize: 32, weight: .bold)
        lbEvent.textColor = .white
    }
}
