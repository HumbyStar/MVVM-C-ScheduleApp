//
//  ViewController.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 24/01/23.
//

import UIKit

class EventListViewController: UIViewController {
    
    var viewModel: EventListViewModel!
    
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(EventCell.self, forCellReuseIdentifier: "cell")
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewCode()
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

extension EventListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cellForRowAt(indexPath: indexPath)
        switch cellViewModel {
        case .normal(let eventCellViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EventCell
            cell.update(with: eventCellViewModel)
            return cell
        case .special:
            return UITableViewCell()
        }
    }
}

extension EventListViewController: ViewCode {
    func buildHierarquic() {
        view.addSubview(tableView)
    }
    func setupConstraint() {
        tableView.pinEdgesToConstrains(edges: [.leading,.trailing,.bottom])
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    func extrasFeatures() {
        viewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.viewDidLoad()
    }
}


