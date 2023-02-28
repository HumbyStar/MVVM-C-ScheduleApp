//
//  AddEventViewController.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 24/01/23.
//

import UIKit

class AddEventViewController: UIViewController {
    
    var viewModel: AddEventViewModel!
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(AddListCell.self, forCellReuseIdentifier: "TitleSubtitleCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewCode()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    
    deinit {
        print("deinit from AddEventcontroller")
    }
    
    @objc func tappedInButton() {
        viewModel.tappedInButton()
    }
}

extension AddEventViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cellForRow(at: indexPath)//Nesse método ja tenho acesso as células[indexPath.row] porque as retorno na ViewModel.
        switch cellViewModel {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleSubtitleCell", for: indexPath) as! AddListCell
            cell.update(with: titleSubtitleCellViewModel)
            cell.subtitleTextfield.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension AddEventViewController: ViewCode{
    func buildHierarquic() {
        view.addSubview(tableView)
    }
    func setupConstraint() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    func extrasFeatures() {
        view.backgroundColor = .white
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(tappedInButton))
        navigationController?.navigationBar.tintColor = .black
        self.navigationItem.largeTitleDisplayMode = .always
        viewModel.viewDidLoad()
        viewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension AddEventViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else {return false}
        let text = currentText + string
        let point = textField.convert(textField.bounds.origin, to: tableView)
        print(point)
        if let indexPath = tableView.indexPathForRow(at: point) {
            //Chamar o método da ViewModel para atualizar a celula que está em TitleSubTitleCell
            viewModel.updateCell(indexPath: indexPath, subtitle: text)
        }
        return true
    }
}

