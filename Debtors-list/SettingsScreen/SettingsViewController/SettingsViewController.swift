//
//  Settings.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 05.12.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var rewardedAdManager = RewardedAdManager()
    var setColors = SetColors()
    let settingsTableView = SettingsTableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(settingsTableView)
        view.backgroundColor = SetColors.currentColor.backgroundColor
        settingsTableView.settingsTableViewDelegate = self
        rewardedAdManager.loadRewardedAd()
        setColors.navigationControllerColorSettings(self)
        setConstraints()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = UserDefaults.standard.bool(forKey: "LightTheme") ? .black : .default
        setColors.navigationControllerColorSettings(self)
        settingsTableView.backgroundColor = SetColors.currentColor.backgroundColor
    }
    
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
}
