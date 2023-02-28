//
//  CustomTabBarController.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 19/01/23.
//
//  MARK: Explicação de como Embedar a TabBar em uma NavigationController. Precisamos colocar a ViewController dentro da NavigationController e inicialiar a tabBar com a NavigationController, então como fazemos isso ?

import UIKit

final class CustomTabBarController: UITabBarController {
    
    //MARK: Hierarquia de Views

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Instantiate ViewController
        let studyPlanTVC = StudyPlanTableViewController()
        let settingsVC = SettingsViewController()
        let homeVC = HomeViewController()
        
        //Change Titles
        studyPlanTVC.title = "Planos de Estudo"
        settingsVC.title = "Configurações"
        homeVC.title = "Home"
        
        //Associate ViewControllers to a NavigationController
        let firstNavigation = UINavigationController(rootViewController: studyPlanTVC)
        let secondNavigation = UINavigationController(rootViewController: settingsVC)
        let thirdNavigation = UINavigationController(rootViewController: homeVC)
        
    
        //Associate TabBar to NavigationController
        self.viewControllers = [thirdNavigation,firstNavigation,secondNavigation]
        
        //Define third configuration
        self.tabBar.tintColor = .purple
    }
    
}
