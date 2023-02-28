//
//  StudyPlanTableViewController.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 16/01/23.
//

import UIKit
import UserNotifications

final class StudyPlanTableViewController: UITableViewController {
    let ud = UserDefaults.standard
    let sm = StudyManager.shared

    let center = UNUserNotificationCenter.current()
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy HH:mm"
        return formatter
    }()
    
    lazy var verticalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lbText, image])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: tableView.topAnchor,constant: 100).isActive = true
        return stackView
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "amico")
        return image
    }()
   
    lazy var lbText: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .purple
        label.font = UIFont(name: "SF Mono", size: 16)
        label.numberOfLines = 2
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareView()
        tableView.reloadData()
        getNotification()
        NotificationCenter.default.addObserver(self, selector: #selector(getNotification), name: NSNotification.Name("Refresh"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extrasFeatures()
    }
    
    @objc func getNotification() {
        center.delegate = self
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .notDetermined {
                
                //MARK: Só vai configurar a notificação se tiver authorization
                print("Estamos dentro de NotDetermined")
                let options: UNAuthorizationOptions = [.alert,.badge,.carPlay,.sound]
                self.center.requestAuthorization(options: options) { success, error in
                    if error == nil {
                        print("A primeira resposta do usuario ao pedir a notificação foi: \(success)")
                    } else {
                        print(error?.localizedDescription)
                    }
                }
            } else if settings.authorizationStatus == .denied {
                print("Estamos dentro de Denied")
                DispatchQueue.main.async {
                    self.warningAuthorization()
                }
            } else if settings.authorizationStatus == .authorized {
                print ("Estamos dentro de Authorized")//Agora preciso passar esse valor para a var da table
            }
        }
        let confirmAction = UNNotificationAction(identifier: "Confirmar", title: "Abrir Notas p/ Revisão 🤩", options: [.foreground])
        let cancelAction = UNNotificationAction(identifier: "Cancelar", title: "Deixar pra depois 👎🏻")
        let category = UNNotificationCategory(identifier:"Lembrete", actions: [confirmAction, cancelAction], intentIdentifiers: [], options: .customDismissAction)
        center.setNotificationCategories([category])
    }
    
    @objc func warningAuthorization() {
        
        let alert = UIAlertController(title: "Erro", message: "O app precisa da permissão para exibir as notificações", preferredStyle: .alert  )
            let okAction = UIAlertAction(title: "Dar permissão", style: .default) { _ in
                
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    NotificationCenter.default.post(name: NSNotification.Name("Change"), object: nil)
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                }
            }
            let cancelAction = UIAlertAction(title: "Não dar permissão", style: .default)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            present(alert, animated: true)
    }
    
    
    
    
    @objc func onReceived(notification: Notification) {
        if let userInfo = notification.userInfo, let id = userInfo["id"] as? String { // Apesar de não precisar usar nesse cenário, esse código seria o utilizado para um interligar as telas como por exemplo um retorno de SceneDelegate
            //sm.setDonePlan(id: id)
            tableView.reloadData()
            let noteViewController = NoteViewController()
            noteViewController.id = id
            navigationController?.present(noteViewController, animated: true)
        }
        
       
        
    }

    func prepareView() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        if self.navigationController?.navigationBar.prefersLargeTitles == false {
            print("Sou false")
        } else {
            print("Sou true")
        }
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = "Planos de Estudo"
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.purple, NSAttributedString.Key.font: UIFont(name: "Georgia", size: 30)!]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        let btPlus = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(push))
        navigationItem.rightBarButtonItem = btPlus
    }
    
    @objc func push() {
        navigationController?.pushViewController(StudyPlanViewController(), animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sm.studyPlan.count == 0 {
            lbText.text = "Voce não possui nenhum \n estudo programado"
            image.image = UIImage(named: "amico")
            tableView.backgroundView = verticalStack
            
        } else {
            lbText.text = nil
            image.image = nil
        }
        
        return sm.studyPlan.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.register(StudyNoteCell.self, forCellReuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StudyNoteCell

        let studyPlan = sm.studyPlan[indexPath.row] // Acho que terei que passar pra celula
        cell.backgroundColor = .clear
        cell.update(with: studyPlan)
        cell.backgroundColor = studyPlan.done ? .green : .white
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            sm.removePlan(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = sm.studyPlan[indexPath.row].id
        let noteViewController = NoteViewController()
        noteViewController.id = id
        navigationController?.present(noteViewController, animated: true)
        
    }
}

extension StudyPlanTableViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let id = response.notification.request.identifier
    
        switch response.actionIdentifier {
        case "Confirmar":
            print("Confirmado")
            NotificationCenter.default.post(name: NSNotification.Name("Confirmed"), object: nil, userInfo: ["id":id])
        case "Cancelar":
            print("Cancelado")
        case UNNotificationDefaultActionIdentifier:
            print("Usuario tocou na notificação")
        case UNNotificationDismissActionIdentifier:
            print("Usuário deu dismiss na notificacao")
        default:
            break
        }
    }
}

extension StudyPlanTableViewController: ViewCode {
    func extrasFeatures() {
        tableView.separatorStyle = .none
        
        tableView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(onReceived(notification:)), name: NSNotification.Name("Confirmed"), object: nil)
        
        prepareView()
    }
}





