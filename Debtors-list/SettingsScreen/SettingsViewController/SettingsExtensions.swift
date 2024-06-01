//
//  Extensions.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 30.03.2024.
//

import Foundation
import UIKit

//MARK: - Settings TableView Delegate
extension SettingsViewController: SettingsTableViewDelegate {
    func showAds() {
        rewardedAdManager.showRewardedAd(viewController: self)
    }
    
    
    func showNotificationsSettings() {
        let vc = NotificationsSettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func switchTheme(sender: UISwitch) {
        if sender.isOn == false{
            UIView.animate(withDuration: 0.8) {
                SetColors.currentColor = LightTheme()
                self.settingsTableView.backgroundColor = SetColors.currentColor.backgroundColor
                self.view.backgroundColor = SetColors.currentColor.backgroundColor
                self.navigationController?.navigationBar.barStyle = .default
                self.setColors.navigationControllerColorSettings(self)
                self.settingsTableView.reloadData()
            }
        }else{
            UIView.animate(withDuration: 0.8) {
                SetColors.currentColor = DarkTheme()
                self.navigationController?.navigationBar.barStyle = .black
                self.settingsTableView.backgroundColor = SetColors.currentColor.backgroundColor
                self.view.backgroundColor = SetColors.currentColor.backgroundColor
                self.setColors.navigationControllerColorSettings(self)
                self.settingsTableView.reloadData()
            }
        }
        UserDefaults.standard.set(sender.isOn, forKey: "LightTheme")
    }
    
    
    func switchIdDidChange(sender: UISwitch) {
        MainViewController.faceTouchId = true
        UserDefaults.standard.set(sender.isOn, forKey: "idIsOn")
    }
    
    
    func switchRoundDidChange(sender: UISwitch) {
        MainViewController.roundResult = true
        UserDefaults.standard.set(sender.isOn, forKey: "Round")
    }
}
