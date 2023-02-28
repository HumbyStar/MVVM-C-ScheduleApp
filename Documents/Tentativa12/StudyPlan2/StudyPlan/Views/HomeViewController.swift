//
//  HomeViewController.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 19/01/23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    let lbTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Aprender e Estudar nunca foi tão facil quanto será agora"
        label.numberOfLines = 3
        return label
    }()
    
    let centerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .purple
        return view
    }()
    
    let lbLanguages: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Georgia", size: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Crie sua própria revisão de qualquer linguagem"
        return label
    }()
    
    var cellID = "Cell"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 150, left: 5, bottom: -5, right: -5)
        layout.itemSize = CGSize(width: view.frame.width, height: 400)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MyCollectionCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.layer.masksToBounds = false
        collectionView.layer.cornerRadius = 10
        collectionView.backgroundColor = .purple
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.alpha = 0.8
        tableView.allowsSelection = false
        return tableView
    }()
    
    var temporaria = ["Swift","JavaScript","Java","TypeScript","CSharp","Ruby", "Goland"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewCode()
    }
    
    func prepareView(){
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        let attributed = [NSAttributedString.Key.foregroundColor: UIColor.purple, NSAttributedString.Key.font: UIFont(name: "Georgia", size: 30)!]
        navigationController?.navigationBar.largeTitleTextAttributes = attributed
        
    }
}

extension HomeViewController: ViewCode {
    func buildHierarchy() {
        view.addSubview(lbTitle)
        view.addSubview(collectionView)
        view.addSubview(lbLanguages)
        view.addSubview(tableView)
    }
    
    func setupConstrains() {
        NSLayoutConstraint.activate([
            lbTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            lbTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lbTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: lbTitle.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 25),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -25),
            collectionView.heightAnchor.constraint(equalToConstant: 250),
            
            lbLanguages.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            lbLanguages.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lbLanguages.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            tableView.topAnchor.constraint(equalTo: lbLanguages.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    func extrasFeatures() {
        prepareView()
        var myMutableString = NSMutableAttributedString(string: lbTitle.text!, attributes: [NSAttributedString.Key.font: UIFont(name: "Georgia", size: 20)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.purple, range: NSRange(location:0,length:8))
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.purple, range: NSRange(location: 11, length: 6))
        lbTitle.attributedText = myMutableString
        centerView.layer.masksToBounds = false
        centerView.layer.cornerRadius = 10
    }
    
    
}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temporaria.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        }
        guard let cell = cell else {return UITableViewCell()}
        cell.textLabel?.textColor = .purple
        cell.textLabel?.text = temporaria[indexPath.row]
        cell.imageView?.image = UIImage(named: temporaria[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        
        return cell
    }
    
    
}
