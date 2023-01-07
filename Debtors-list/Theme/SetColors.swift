//
//  SetColors.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 05.12.2022.
//

import Foundation
import UIKit

protocol ColorDelegate {
    var labelsColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var backgroundCellColor: UIColor { get }
    var backgroundCustomViewColor: UIColor { get }
    var buttonsColor: UIColor { get }
    var backgroundTabBar: UIColor { get }
    var textFieldBackgroundColor: UIColor { get }
    var infoViewColor: UIColor { get }
    var infoViewLabelColor: UIColor { get }
    var placeholderTextColor: UIColor { get }
    
}


class SetColors {
    static var currentColor: ColorDelegate = LightTheme()
    
    func navigationControllerColorSettings(_ viewController: UIViewController) {
        viewController.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: SetColors.currentColor.labelsColor]
        viewController.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: SetColors.currentColor.labelsColor]
        viewController.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Noteworthy Light", size: 30.0)!,NSAttributedString.Key.foregroundColor: SetColors.currentColor.labelsColor]
        viewController.navigationController?.navigationBar.barTintColor = SetColors.currentColor.backgroundColor
        viewController.navigationItem.rightBarButtonItem?.tintColor = SetColors.currentColor.labelsColor
        viewController.navigationController?.tabBarController?.tabBar.backgroundColor = SetColors.currentColor.backgroundCustomViewColor
        viewController.navigationController?.tabBarController?.tabBar.tintColor = SetColors.currentColor.labelsColor
    }
    
    func backButtonSettings(_ viewController: UIViewController) {
        let backButton = UIBarButtonItem()
        backButton.title = " "
        backButton.tintColor = SetColors.currentColor.labelsColor
        viewController.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}
