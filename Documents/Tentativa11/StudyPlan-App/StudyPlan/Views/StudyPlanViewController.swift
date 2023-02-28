//
//  ViewController.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 16/01/23.
// MARK: AutoresizingMaskIntoContraints tem que marcar como FALSE

import UIKit
import UserNotifications

final class StudyPlanViewController: UIViewController{
    
    var colors: [Colors] = [.red, .black, .green, .purple, .orange, .yellow]
    var images: [ImagesLG] = [.CSharp,.Goland,.Java,.JavaScript,.Swift,.Ruby,.TypeScript]
    
    var color: Colors? //Preciso alimentar com a cor selecionada
    var image: ImagesLG? // Preciso alimentar com a imagem selecionada
    
    var studyPlan: StudyPlan?
    let id = String(Date().timeIntervalSince1970)
    
    let sm = StudyManager.shared
    
    lazy var lbDetail: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Preencha a matéria e assunto"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .purple
        return label
    }()
    
    lazy var firstTextfield: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .systemGroupedBackground
        textfield.textAlignment = .center
        textfield.attributedPlaceholder = NSAttributedString(string: "Digite a Matéria", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textfield.textColor = .black
        textfield.layer.masksToBounds = false
        textfield.layer.cornerRadius = 5
        textfield.delegate = self
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    lazy var secondTextField: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .systemGroupedBackground
        textfield.textAlignment = .center
        textfield.layer.masksToBounds = false
        textfield.layer.cornerRadius = 5
        textfield.attributedPlaceholder = NSAttributedString(string: "Digite o Assunto", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textfield.textColor = .black
        textfield.delegate = self
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    lazy var lbTextPicker: UILabel = {
        let textlabel = UILabel()
        textlabel.textColor = .purple
        textlabel.textAlignment = .center
        textlabel.text = "Data de estudo"
        textlabel.translatesAutoresizingMaskIntoConstraints = false
        return textlabel
    }()
    
    lazy var dpDate: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .compact
        picker.datePickerMode = .dateAndTime
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
        
    }()
    
    lazy var lbSelectColor: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Selecione a cor"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .purple
        return label
    }()
    
    lazy var colorsCollection: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.masksToBounds = false
        collectionView.layer.cornerRadius = 10
        collectionView.backgroundColor = .clear
        collectionView.register(ColorCollectionCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsSelection = true
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: false)
        return collectionView
    }()
    
    lazy var cvLanguages: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.masksToBounds = false
        collectionView.layer.cornerRadius = 10
        collectionView.delaysContentTouches = false
        collectionView.backgroundColor = .clear
        collectionView.register(ImagesCollectionCell.self, forCellWithReuseIdentifier: "cell2")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsSelection = true
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: false)
        return collectionView
    }()
    
    lazy var lbWriteNote: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Escreva a sintaxe do código"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .purple
        return label
    }()
    
    lazy var txtNote: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .systemGroupedBackground
        return textView
    }()
    
    lazy var btConfirm: UIButton = {
        let button = UIButton()
        button.setTitle("Cadastrar Aula", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .purple
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewCode()
    }
    
    @objc func schedule(sender: UIButton!) {
        let note = Note(color: color, image: image, noteText: txtNote.text)
        self.studyPlan = StudyPlan(topic: firstTextfield.text!, subjectName: secondTextField.text!, date: dpDate.date, done: false, id: id, note: note, checkTimes: .zero )
        buildNotification()
        
        
        navigationController?.popViewController(animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        firstTextfield.resignFirstResponder()
        secondTextField.resignFirstResponder()
    }
    
    func buildNotification() {
        guard let studyPlan = studyPlan else {return}
        let content = UNMutableNotificationContent()
        content.title = "Lembrete"
        content.subtitle = "Matéria \(studyPlan.topic)"
        content.body = "Estudar \(studyPlan.subjectName)"
        content.categoryIdentifier = "Lembrete"
        
        let dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: dpDate.date)
        print(dpDate.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request,withCompletionHandler: nil)
        sm.addPlan(studyPlan)
        //Quando esse request for executado, terei que ter uma função para schedule apos 24H, 7 Dias e 30 dias...
    }
}

extension StudyPlanViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colorsCollection {
            return colors.count
        } else {
            return images.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == colorsCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ColorCollectionCell
            
            //cell.color = colors[indexPath.row]
            cell.setupCell(with: colors[indexPath.row].value)
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! ImagesCollectionCell
            cell.setupCell(with: images[indexPath.row])
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cvLanguages {
            self.image = images[indexPath.row]
        } else {
            self.color = colors[indexPath.row]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
}


extension StudyPlanViewController: ViewCode {
    func buildHierarchy() {
        [lbDetail, firstTextfield, secondTextField, lbTextPicker, dpDate, lbSelectColor, colorsCollection, cvLanguages, lbWriteNote, txtNote, btConfirm].forEach{
            view.addSubview($0)
        }
    }
    
    func setupConstrains() {
        NSLayoutConstraint.activate([
            
            lbDetail.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            lbDetail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lbDetail.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            firstTextfield.topAnchor.constraint(equalTo: lbDetail.bottomAnchor,constant: 5),
            firstTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstTextfield.trailingAnchor.constraint(equalTo: secondTextField.leadingAnchor, constant: -10),
            
            secondTextField.topAnchor.constraint(equalTo:  lbDetail.bottomAnchor,constant: 5),
            secondTextField.widthAnchor.constraint(equalTo: firstTextfield.widthAnchor),
            secondTextField.leadingAnchor.constraint(equalTo: firstTextfield.trailingAnchor, constant: 10),
            secondTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            lbTextPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lbTextPicker.topAnchor.constraint(equalTo: firstTextfield.topAnchor, constant: 50),
            lbTextPicker.widthAnchor.constraint(equalToConstant: 150),
            
            dpDate.topAnchor.constraint(equalTo: lbTextPicker.topAnchor, constant: 30),
            dpDate.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            lbSelectColor.topAnchor.constraint(equalTo: dpDate.bottomAnchor,constant: 20),
            lbSelectColor.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lbSelectColor.widthAnchor.constraint(equalToConstant: 200),
            
            colorsCollection.topAnchor.constraint(equalTo: lbSelectColor.bottomAnchor),
            colorsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            colorsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            colorsCollection.heightAnchor.constraint(equalToConstant: 100),
            
            cvLanguages.topAnchor.constraint(equalTo: colorsCollection.bottomAnchor,constant: 20),
            cvLanguages.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            cvLanguages.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            cvLanguages.heightAnchor.constraint(equalToConstant: 50),
            
            lbWriteNote.topAnchor.constraint(equalTo: cvLanguages.bottomAnchor, constant: 20),
            lbWriteNote.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lbWriteNote.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            txtNote.topAnchor.constraint(equalTo: lbWriteNote.bottomAnchor,constant: 5),
            txtNote.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            txtNote.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            txtNote.bottomAnchor.constraint(equalTo: btConfirm.topAnchor,constant: -20),
            
            btConfirm.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -5),
            btConfirm.trailingAnchor.constraint(equalTo:lbTextPicker.trailingAnchor),
            btConfirm.leadingAnchor.constraint(equalTo: lbTextPicker.leadingAnchor),
            btConfirm.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func extrasFeatures() {
        view.backgroundColor = .white
        title = "Cadastrar"
        navigationController?.navigationBar.prefersLargeTitles = true
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        dpDate.minimumDate = Date()
        btConfirm.addTarget(self, action: #selector(schedule), for: .touchUpInside)
    }
}

extension StudyPlanViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == firstTextfield {
            let maxLenght = 12
            let currentText: NSString = textField.text! as NSString
            let newString: NSString = currentText.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLenght
        } else {
            let maxLenght = 16
            let currentText: NSString = textField.text! as NSString
            let newText: NSString = currentText.replacingCharacters(in: range, with: string) as NSString
            return newText.length <= maxLenght
        }
       
    }
}

