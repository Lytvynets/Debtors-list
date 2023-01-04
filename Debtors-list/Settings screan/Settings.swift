//
//  Settings.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 05.12.2022.
//

import UIKit

class Settings2: UIViewController {
    
    var sectionTitles = ["   ", "   ", "   "]
    var sectionContent = [["Notification"],["Touch id", "Round the result", "Dark theme"], ["Privacy policy", "Other apps"]]
    var customizeСells = CustomizeСells()
    var setColors = SetColors()
    let privacyPolicyUrl = "https://www.termsfeed.com/live/5a26bfcc-4d37-48ac-8beb-58532329e612"
    let otherAppsUrl = "https://apps.apple.com/us/developer/vladyslav-lytvynets/id1660079103"
    let cellSpacingHeight: CGFloat = 5
    
    
    let settingsTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var colorSwitch: UISwitch = {
        var colorSwitch = UISwitch()
        colorSwitch.translatesAutoresizingMaskIntoConstraints = false
        colorSwitch.addTarget(self, action: #selector(switchStateDidChange), for: .valueChanged)
        colorSwitch.setOn(false, animated: false)
        return colorSwitch
    }()
    
    lazy var roundResultSwitch: UISwitch = {
        var colorSwitch = UISwitch()
        colorSwitch.translatesAutoresizingMaskIntoConstraints = false
        colorSwitch.addTarget(self, action: #selector(switchRoundDidChange), for: .valueChanged)
        colorSwitch.setOn(false, animated: false)
        return colorSwitch
    }()
    
    lazy var touchIdSwitch: UISwitch = {
        var colorSwitch = UISwitch()
        colorSwitch.translatesAutoresizingMaskIntoConstraints = false
        colorSwitch.addTarget(self, action: #selector(switchIdDidChange), for: .valueChanged)
        colorSwitch.setOn(false, animated: false)
        return colorSwitch
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(settingsTableView)
        view.backgroundColor = SetColors.currentColor.backgroundColor
        tableViewSettings()
        
        setColors.navigationControllerColorSettings(self)
        colorSwitch.isOn = UserDefaults.standard.bool(forKey: "LightTheme")
        touchIdSwitch.isOn = UserDefaults.standard.bool(forKey: "idIsOn")
        roundResultSwitch.isOn = UserDefaults.standard.bool(forKey: "Round")
        
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = UserDefaults.standard.bool(forKey: "LightTheme") ? .black : .default
        setColors.navigationControllerColorSettings(self)
        settingsTableView.backgroundColor = SetColors.currentColor.backgroundColor
    }
    
    
    
    //MARK: - Actions
    @objc func switchStateDidChange(_ sender: UISwitch){
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
    
    
    @objc func switchIdDidChange(_ sender: UISwitch) {
        MainScreen.faceTouchId = true
        UserDefaults.standard.set(sender.isOn, forKey: "idIsOn")
        
    }
    
    @objc func switchRoundDidChange(_ sender: UISwitch) {
        MainScreen.roundResult = true
        UserDefaults.standard.set(sender.isOn, forKey: "Round")
    }
}
