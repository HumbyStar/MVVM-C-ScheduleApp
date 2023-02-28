//
//  EventDetailViewController.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 16/02/23.
//

import UIKit

class EventDetailViewController: UIViewController {
    var viewModel: EventDetailViewModel?
    
    lazy var ivBackground: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var remainingTimeStackView: RemainingTimeStackView = {
        let stackView = RemainingTimeStackView()
        stackView.setup()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewCode()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.viewDidDisappear()
    }
}

extension EventDetailViewController: ViewCode {
    func buildHierarquic() {
        view.addSubview(ivBackground)
        view.addSubview(remainingTimeStackView)
    }
    func setupConstraint() {
        ivBackground.pinEdgesToConstrains(edges: [.top,.leading,.trailing,.bottom])
        NSLayoutConstraint.activate([
            remainingTimeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            remainingTimeStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            remainingTimeStackView.widthAnchor.constraint(equalToConstant: 300),
            remainingTimeStackView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    func extrasFeatures() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .plain, target: viewModel, action: #selector(viewModel?.tappedInEdit))
        viewModel?.onUpdate = {
            self.ivBackground.image = self.viewModel?.imageBackground
            guard let remainingTimeViewModel = self.viewModel?.remainingTimeViewModel else {return}
            self.remainingTimeStackView.update(with: remainingTimeViewModel)
        }
        viewModel?.viewDidLoad()
    }
}
