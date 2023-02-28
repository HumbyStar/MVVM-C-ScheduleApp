//
//  NoteViewController.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 25/02/23.
//

import UIKit
import UserNotifications

class NoteViewController: UIViewController {
    
    var id: String?
    var sm = StudyManager.shared
    var note: StudyPlan?
    
    lazy var lbTitle: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var lbSubTitle: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy var noteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 3
        return view
    }()
    
    lazy var imageLogo: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var lbContent: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = note?.note.noteText ?? ""
        lb.numberOfLines = 0
        return lb
    }()
    
    lazy var btConfirm: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("Moleza 👍🏻", for: .normal)
        bt.layer.masksToBounds = false
        bt.layer.cornerRadius = 10
        bt.addTarget(self, action: #selector(scheduleNormal), for: .touchUpInside)
        return bt
    }()
    
    lazy var btCancel: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("Caramba ta dificil ainda 👎🏻", for: .normal)
        bt.layer.masksToBounds = false
        bt.layer.cornerRadius = 10
        bt.addTarget(self, action: #selector(scheduleSpecial), for: .touchUpInside)
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewCode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let id = id else {return}
        note = sm.getPlanNote(id: id)
        
        guard let note = note else {return}
        configureNote(with: note)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if self.navigationController?.navigationBar.prefersLargeTitles == false {
            print("Sou false")
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = .always
        }
        
       
    }
    
    @objc func scheduleNormal() {
        validateScheduleNormal()
        
        guard let note = note else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Lembrete"
        content.subtitle = "Matéria \(note.topic)"
        content.body = "Estudar \(note.subjectName)"
        content.categoryIdentifier = "Lembrete"
        
        let date = Date().addingTimeInterval(note.checkTimes.validate) // Criei uma data atual apartir do momento que a instancia foi criada e adicionei x tempo
        print(date)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: note.id, content: content, trigger: trigger)
        
        // Remove todas as notificações pendentes para a nota atual
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [note.id])
        
        // Adiciona a nova notificação para a nota atual
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Erro ao agendar notificação: \(error)")
            } else {
                print("Notificação agendada com sucesso!")
                
            }
        }
        
        dismiss(animated: true)
    }

    @objc func scheduleSpecial() {
        validateScheduleSpecial()
        
        guard let note = note else {return}
        
        let content = UNMutableNotificationContent()
        content.title = "Lembrete"
        content.subtitle = "Matéria \(note.topic)"
        content.body = "Estudar \(note.subjectName)"
        content.categoryIdentifier = "Lembrete"
        
        let date = Date().addingTimeInterval(note.checkTimes.validate)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: note.id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [note.id])
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Erro ao agendar notificação: \(error)")
            } else {
                print("Notificação agendada com sucesso")
            }
        }
        dismiss(animated: true)
    }
    
    func validateScheduleNormal() {
        guard let note = note else {return}
        
        switch note.checkTimes {
        case .zero:
            self.note?.checkTimes = .first
        case .first:
            self.note?.checkTimes = .second
            
        case .second:
            self.note?.checkTimes = .third
           
        case .third:
            self.note?.checkTimes = .third
        
        }
    }
    
    func validateScheduleSpecial() {
        guard let note = note else {return}
        let times = note.checkTimes

        switch times {
        case .zero:
            self.note?.checkTimes = .first
        case .first:
            self.note?.checkTimes = .first
        case .second:
            self.note?.checkTimes = .first
        case .third:
            self.note?.checkTimes = .first

        }
    }

    
    func configureNote(with note: StudyPlan) {
        guard let image = note.note.image else {return}
        self.lbTitle.text = note.topic
        self.lbTitle.font = UIFont(name: note.note.font, size: 25)
        self.lbTitle.textColor = note.note.defaultTextColor
        self.lbSubTitle.text = note.subjectName
        self.lbSubTitle.font = UIFont(name: note.note.font, size: 20)
        self.lbSubTitle.textColor = note.note.defaultTextColor
        self.noteView.backgroundColor =  note.note.color!.value
        self.noteView.layer.borderColor = note.note.defaultTextColor.cgColor
        self.imageLogo.image = UIImage(named: image.rawValue)
        self.lbContent.text = note.note.noteText
        self.lbContent.font = UIFont(name: note.note.font, size: 15)
        self.lbContent.textColor = note.note.defaultTextColor
        self.btConfirm.setTitleColor(note.note.defaultTextColor, for: .normal)
        self.btConfirm.backgroundColor = note.note.color?.value
        self.btConfirm.layer.borderWidth = 3
        self.btConfirm.layer.borderColor = note.note.defaultTextColor.cgColor
        self.btCancel.setTitleColor(note.note.defaultTextColor, for: .normal)
        self.btCancel.backgroundColor = note.note.color?.value
        self.btCancel.layer.borderWidth = 3
        self.btCancel.layer.borderColor = note.note.defaultTextColor.cgColor


    }
}

extension NoteViewController: ViewCode {
    func buildHierarchy() {
        self.view.addSubview(noteView)
        self.noteView.addSubview(scrollView)
        self.scrollView.addSubview(lbTitle)
        self.scrollView.addSubview(lbSubTitle)
        self.noteView.addSubview(imageLogo)
        self.scrollView.addSubview(lbContent)
        self.view.addSubview(btCancel)
        self.view.addSubview(btConfirm)
        
    }
    
    func setupConstrains() {
        NSLayoutConstraint.activate([
            
            self.noteView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            self.noteView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.noteView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.noteView.heightAnchor.constraint(equalToConstant: 500),
            
            self.scrollView.topAnchor.constraint(equalTo: self.noteView.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.noteView.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.noteView.trailingAnchor, constant: -20),
            self.scrollView.bottomAnchor.constraint(equalTo: self.imageLogo.topAnchor, constant: -10),
            
            self.lbTitle.topAnchor.constraint(equalTo: self.scrollView.topAnchor,constant: 50),
            self.lbTitle.widthAnchor.constraint(equalToConstant: 180),
            self.lbTitle.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 10),
        
            self.lbSubTitle.topAnchor.constraint(equalTo: self.lbTitle.bottomAnchor, constant: 10),
            self.lbSubTitle.widthAnchor.constraint(equalToConstant: 200),
            self.lbSubTitle.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20),
            
            self.lbContent.topAnchor.constraint(equalTo: self.lbSubTitle.bottomAnchor, constant: 10),
            
            self.lbContent.leadingAnchor.constraint(equalTo: self.noteView.leadingAnchor, constant: 30),
            
            self.lbContent.trailingAnchor.constraint(equalTo: self.noteView.trailingAnchor, constant: -10),
            
            self.lbContent.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            
         
            self.imageLogo.bottomAnchor.constraint(equalTo: self.noteView.bottomAnchor, constant: -20),
            self.imageLogo.heightAnchor.constraint(equalToConstant: 50),
            self.imageLogo.widthAnchor.constraint(equalToConstant: 50),
            self.imageLogo.centerXAnchor.constraint(equalTo: self.noteView.centerXAnchor),
            
            self.btCancel.topAnchor.constraint(equalTo: self.btConfirm.bottomAnchor,constant: 20),
            self.btCancel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.btCancel.heightAnchor.constraint(equalToConstant: 50),
            self.btCancel.widthAnchor.constraint(equalToConstant: 280),
            
            self.btConfirm.topAnchor.constraint(equalTo: self.noteView.bottomAnchor,constant: 40),
            self.btConfirm.heightAnchor.constraint(equalTo: self.btCancel.heightAnchor),
            self.btConfirm.widthAnchor.constraint(equalTo: self.btCancel.widthAnchor),
            self.btConfirm.centerXAnchor.constraint(equalTo: self.btCancel.centerXAnchor),
        ])
    }
    
    func extrasFeatures() {
        self.view.backgroundColor = .white
    }
}
