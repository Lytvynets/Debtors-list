//
//  TabBar.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 05.12.2022.
//

import Foundation
import UIKit

class TabBarVC: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = SetColors.currentColor.backgroundCustomViewColor
        tabBar.tintColor = SetColors.currentColor.labelsColor
        tabBar.unselectedItemTintColor = .gray
        setup()
    }
    
    
    func setup(){
        viewControllers = [
            createNavController(rootVC: MainScreen(), title: "Last operations", image: UIImage(named: "icons8-ledger-25")!),
            createNavController(rootVC: DebtorsList(), title: "Given", image: UIImage(named: "icons8-safe-out-25")!),
            createNavController(rootVC: DebtList(), title: "Taken", image: UIImage(named: "icons8-safe-in-25")!),
            createNavController(rootVC: Settings2(), title: "Settings", image: UIImage(named: "icons8-settings-75")!)
        ]
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabBar.tintColor = SetColors.currentColor.labelsColor
        self.tabBar.backgroundColor = SetColors.currentColor.backgroundCustomViewColor
        self.tabBar.barTintColor = SetColors.currentColor.backgroundCustomViewColor
    }
    
    
    func createNavController (rootVC: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootVC)
        navController.tabBarItem.image = image
        navController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: SetColors.currentColor.labelsColor]
        navController.navigationBar.prefersLargeTitles = true
        rootVC.navigationItem.title = title
        return navController
    }
}
