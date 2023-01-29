//
//  ViewController.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 24/01/23.
//

import UIKit

class EventListViewController: UIViewController {
    
    var viewModel: EventListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .white
        let image = UIImage(systemName: "plus.circle.fill")
        let rightBarButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(tappedBarAddEvent))
        rightBarButton.tintColor = .primary
        navigationItem.rightBarButtonItem = rightBarButton
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }

    @objc private func tappedBarAddEvent() {
        viewModel.tappedAddEvent()
    }
    

}

