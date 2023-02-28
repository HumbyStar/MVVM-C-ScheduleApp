//
//  SettingsViewController.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 19/01/23.
//

import UIKit

final class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareView()
    }
    
    func prepareView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        let attribute = [NSAttributedString.Key.foregroundColor: UIColor.purple, NSAttributedString.Key.font: UIFont(name: "Georgia", size: 30)]
        navigationController?.navigationBar.largeTitleTextAttributes = attribute
        title = "Configurações"
    }
}
