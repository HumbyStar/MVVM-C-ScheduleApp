//
//  LoginViewController.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 27/02/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "DevNote")
        return image
    }()
    
    lazy var tfLogin: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .emailAddress
        tf.autocorrectionType = .no
        tf.borderStyle = .roundedRect
        tf.placeholder = "Login"
        tf.layer.masksToBounds = false
        tf.layer.cornerRadius = 10
        //tf.backgroundColor =  UIColor(red: 204/255, green: 176/255, blue: 217/255, alpha: 1.0)
        tf.backgroundColor = .white
        return tf
    }()
    
    lazy var tfPassword: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .emailAddress
        tf.autocorrectionType = .no
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        tf.placeholder = "Digite a senha"
        tf.layer.masksToBounds = false
        tf.layer.cornerRadius = 10
        //tf.backgroundColor =  UIColor(red: 204/255, green: 176/255, blue: 217/255, alpha: 1.0)
        tf.backgroundColor =  .white
        return tf
    }()
    
    lazy var btLogin: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("Entrar", for: .normal)
        bt.setTitleColor(.purple, for: .normal)
        //bt.backgroundColor = UIColor(red: 204/255, green: 176/255, blue: 217/255, alpha: 1.0)
        bt.backgroundColor = .white
        bt.layer.masksToBounds = false
        bt.layer.cornerRadius = 10
        bt.addTarget(self, action: #selector(tappedInButton), for: .touchUpInside)
        return bt
    }()
    
    lazy var btLoginWithGoogle: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "google2"), for: .normal)
        bt.imageView?.contentMode = .scaleAspectFit
        bt.titleLabel?.textAlignment = .center
        bt.setTitleColor(.systemGray, for: .normal)
        bt.backgroundColor = .white
        bt.titleLabel?.font = .systemFont(ofSize: 14)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.layer.masksToBounds = false
        bt.layer.cornerRadius = 10
        bt.addTarget(self, action: #selector(tapToLoginWithGoogle), for: .touchUpInside)
        return bt
    }()
    
    lazy var btLoginWithApple: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setImage(UIImage(systemName: "apple.logo"), for: .normal)
        bt.tintColor = .black
        bt.imageView?.contentMode = .scaleAspectFit
        bt.titleLabel?.textAlignment = .center
        bt.setTitleColor(.systemGray, for: .normal)
        bt.backgroundColor = .white
        bt.titleLabel?.font = .systemFont(ofSize: 14)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.layer.masksToBounds = false
        bt.layer.cornerRadius = 10
        bt.addTarget(self, action: #selector(tapToLoginWithApple), for: .touchUpInside)
        return bt
    }()
    
    lazy var btRegister: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("Registrar", for: .normal)
        bt.titleLabel?.font = .systemFont(ofSize: 14)
        bt.setTitleColor(.purple, for: .normal)
        bt.layer.masksToBounds = false
        bt.layer.cornerRadius = 10
        bt.addTarget(self, action: #selector(tapToRegister), for: .touchUpInside)
        return bt
    }()

    @objc func tappedInButton() {
        print("Loguei na tela")
        let customTab = CustomTabBarController()
        customTab.modalPresentationStyle = .fullScreen
        present(customTab, animated: true)
    }
    
    @objc func tapToLoginWithGoogle() {
        print("Logar com google")
    }
    
    @objc func tapToLoginWithApple() {
        print("Logar com Apple")
    }
    
    @objc func tapToRegister() {
        print("Tela para registrar")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewCode()
    }
}

extension LoginViewController: ViewCode {
    
    func buildHierarchy() {
        [logoImage, tfLogin, tfPassword, btLogin, btLoginWithGoogle, btLoginWithApple,btRegister].forEach({
            self.view.addSubview($0)
        })
    }
    
    func setupConstrains() {
        NSLayoutConstraint.activate([
            self.logoImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logoImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 40),
            self.logoImage.heightAnchor.constraint(equalToConstant: 220),
            self.logoImage.widthAnchor.constraint(equalToConstant: 300),
            
            self.tfLogin.topAnchor.constraint(equalTo: self.logoImage.bottomAnchor, constant: 20),
            self.tfLogin.widthAnchor.constraint(equalToConstant: 340),
            self.tfLogin.heightAnchor.constraint(equalToConstant: 50),
            self.tfLogin.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.tfPassword.topAnchor.constraint(equalTo: self.tfLogin.bottomAnchor, constant: 10),
            self.tfPassword.heightAnchor.constraint(equalTo: self.tfLogin.heightAnchor),
            self.tfPassword.widthAnchor.constraint(equalTo: self.tfLogin.widthAnchor),
            self.tfPassword.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.btLogin.topAnchor.constraint(equalTo: self.tfPassword.bottomAnchor, constant: 40),
            self.btLogin.heightAnchor.constraint(equalTo: self.tfLogin.heightAnchor),
            self.btLogin.widthAnchor.constraint(equalTo: self.tfLogin.widthAnchor),
            self.btLogin.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.btLoginWithGoogle.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            self.btLoginWithGoogle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 135),
            self.btLoginWithGoogle.heightAnchor.constraint(equalTo: self.tfLogin.heightAnchor),
            self.btLoginWithGoogle.widthAnchor.constraint(equalToConstant: 50),
            
            self.btLoginWithApple.centerYAnchor.constraint(equalTo: self.btLoginWithGoogle.centerYAnchor),
            self.btLoginWithApple.leadingAnchor.constraint(equalTo: self.btLoginWithGoogle.trailingAnchor, constant: 30),
            self.btLoginWithApple.heightAnchor.constraint(equalTo: self.tfLogin.heightAnchor),
            self.btLoginWithApple.widthAnchor.constraint(equalToConstant: 50),
            
            self.btRegister.topAnchor.constraint(equalTo: self.btLogin.bottomAnchor, constant: 2),
            self.btRegister.widthAnchor.constraint(equalToConstant: 100),
            self.btRegister.heightAnchor.constraint(equalToConstant: 50),
            self.btRegister.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    func extrasFeatures() {
        self.view.backgroundColor = UIColor(red: 0xE4/255, green: 0xC5/255, blue: 0xF2/255, alpha: 1.0)
    }
    
}
