//
//  SettingsTableView.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 04.01.2023.
//
//
import UIKit


class SettingsTableView: UITableView, UITableViewDelegate, UITableViewDataSource  {
    
    let screenSize: CGRect = UIScreen.main.bounds
    let cellSpacingHeight: CGFloat = 5
    var customizeСells = CustomizeСells()
    var rewardedAdManager = RewardedAdManager()
    var settingsTableViewDelegate: SettingsTableViewDelegate?
    let privacyPolicyUrl = "https://www.termsfeed.com/live/5a26bfcc-4d37-48ac-8beb-58532329e612"
    let otherAppsUrl = "https://apps.apple.com/us/developer/vladyslav-lytvynets/id1660079103"
    var sectionTitles = ["   ", "   ", "   ", "  "]
    var sectionContent = [["Notification"],
                          ["Touch ID/Face ID", "Round the result", "Dark theme"],
                          ["Privacy policy", "Other apps"],
                          ["Watch Ads to support the project"]]
    
    
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
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        tableViewSettings()
        colorSwitch.isOn = UserDefaults.standard.bool(forKey: "LightTheme")
        touchIdSwitch.isOn = UserDefaults.standard.bool(forKey: "idIsOn")
        roundResultSwitch.isOn = UserDefaults.standard.bool(forKey: "Round")
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return sectionContent[0].count
        case 1:
            return sectionContent[1].count
        case 2:
            return sectionContent[2].count
        case 3:
            return sectionContent[3].count
        default:
            return sectionContent[0].count
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = sectionContent[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        customizeСells.cellsColor(cell)
        cell.layer.cornerRadius = 15
        
        switch (indexPath as NSIndexPath).section {
        case 0:
            switch (indexPath as NSIndexPath).row {
            case 0:
                cell.textLabel?.font = UIFont(name: "Avenir Book", size: screenSize.height * 0.02)
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
                let image = UIImage(systemName: "chevron.right")
                let accessory  = UIImageView(frame:CGRect(x:0, y:0, width:(12), height:(12)))
                accessory.image = image
                accessory.tintColor = .gray
                cell.accessoryView = accessory
            default:
                print("default 1")
            }
            
        case 1:
            switch (indexPath as NSIndexPath).row {
            case 2:
                cell.addSubview(colorSwitch)
                cell.textLabel?.font = UIFont(name: "Avenir Book", size: screenSize.height * 0.02)
                cell.clipsToBounds = true
                cell.accessoryType = .none
                cell.accessoryView = .none
                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                cellsLayout(cell, uiSwitch: colorSwitch)
            case 1:
                cell.addSubview(roundResultSwitch)
                cell.textLabel?.font = UIFont(name: "Avenir Book", size: screenSize.height * 0.02)
                cell.layer.cornerRadius = 0
                cell.accessoryType = .none
                cell.accessoryView = .none
                cellsLayout(cell, uiSwitch: roundResultSwitch)
            case 0:
                cell.addSubview(touchIdSwitch)
                cell.textLabel?.font = UIFont(name: "Avenir Book", size: screenSize.height * 0.02)
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                cell.accessoryType = .none
                cell.accessoryView = .none
                cellsLayout(cell, uiSwitch: touchIdSwitch)
            default:
                print("default 2")
            }
            
        case 2:
            switch (indexPath as NSIndexPath).row {
            case 0:
                cell.textLabel?.font = UIFont(name: "Avenir Book", size: screenSize.height * 0.02)
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                let image = UIImage(systemName: "chevron.right")
                let accessory  = UIImageView(frame:CGRect(x:0, y:0, width:(12), height:(12)))
                accessory.image = image
                accessory.tintColor = .gray
                cell.accessoryView = accessory
            case 1:
                cell.textLabel?.font = UIFont(name: "Avenir Book", size: screenSize.height * 0.02)
                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                let image = UIImage(systemName: "chevron.right")
                let accessory  = UIImageView(frame:CGRect(x:0, y:0, width:(12), height:(12)))
                accessory.image = image
                accessory.tintColor = .gray
                cell.accessoryView = accessory
            default:
                print("default 3")
            }
        case 3:
            switch (indexPath as NSIndexPath).row {
            case 0:
                cell.textLabel?.font = UIFont(name: "Avenir Book", size: screenSize.height * 0.02)
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
                cell.accessoryType = .none
                cell.accessoryView = .none
                
            default:
                print("default 3")
            }
        default: break
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath as NSIndexPath).section {
        case 0:
            switch (indexPath as NSIndexPath).row {
            case 0:
                settingsTableViewDelegate?.showNotificationsSettings()
            default:
                print("Error in Switch")
            }
        case 2:
            switch (indexPath as NSIndexPath).row {
            case 0:
                if let url = URL(string: privacyPolicyUrl) {
                    UIApplication.shared.open(url, options: [:])
                }
            case 1:
                if let url = URL(string: otherAppsUrl) {
                    UIApplication.shared.open(url, options: [:])
                }
            default: break
            }
        case 3:
            switch (indexPath as NSIndexPath).row {
            case 0:
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
                settingsTableViewDelegate?.showAds()
            default: break
            }
        default:
            print("Default")
        }
    }
    
    
    func tableViewSettings() {
        register(SettingsCell.self, forCellReuseIdentifier: "Cell")
        delegate = self
        dataSource = self
        tableFooterView = UIView(frame: CGRect.zero)
        cellLayoutMarginsFollowReadableWidth = true
        separatorStyle = .none
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func cellsLayout(_ cell: UITableViewCell, uiSwitch: UISwitch) {
        NSLayoutConstraint.activate([
            uiSwitch.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            uiSwitch.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -15)
        ])
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenSize.height / 15
    }
    
    
    //MARK: - Actions
    @objc func switchStateDidChange(_ sender: UISwitch){
        settingsTableViewDelegate?.switchTheme(sender: sender)
    }
    
    
    @objc func switchIdDidChange(_ sender: UISwitch) {
        settingsTableViewDelegate?.switchIdDidChange(sender: sender)
    }
    
    
    @objc func switchRoundDidChange(_ sender: UISwitch) {
        settingsTableViewDelegate?.switchRoundDidChange(sender: sender)
    }
}
