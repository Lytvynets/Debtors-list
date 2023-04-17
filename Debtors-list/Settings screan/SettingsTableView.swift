//
//  SettingsTableView.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 04.01.2023.
//
//
import UIKit

extension Settings2: UITableViewDelegate, UITableViewDataSource {
    
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
                cell.textLabel?.font = UIFont(name: "Avenir Book", size: view.frame.height * 0.02)
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
                cell.textLabel?.font = UIFont(name: "Avenir Book", size: view.frame.height * 0.02)
                cell.clipsToBounds = true
                cell.accessoryType = .none
                cell.accessoryView = .none
                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                cellsLayout(cell, uiSwitch: colorSwitch)
            case 1:
                cell.addSubview(roundResultSwitch)
                cell.textLabel?.font = UIFont(name: "Avenir Book", size: view.frame.height * 0.02)
                cell.layer.cornerRadius = 0
                cell.accessoryType = .none
                cell.accessoryView = .none
                cellsLayout(cell, uiSwitch: roundResultSwitch)
            case 0:
                cell.addSubview(touchIdSwitch)
                cell.textLabel?.font = UIFont(name: "Avenir Book", size: view.frame.height * 0.02)
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
                cell.textLabel?.font = UIFont(name: "Avenir Book", size: view.frame.height * 0.02)
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                let image = UIImage(systemName: "chevron.right")
                let accessory  = UIImageView(frame:CGRect(x:0, y:0, width:(12), height:(12)))
                accessory.image = image
                accessory.tintColor = .gray
                cell.accessoryView = accessory
            case 1:
                cell.textLabel?.font = UIFont(name: "Avenir Book", size: view.frame.height * 0.02)
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
                cell.textLabel?.font = UIFont(name: "Avenir Book", size: view.frame.height * 0.02)
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
                let vc = NotificationsSettings()
                navigationController?.pushViewController(vc, animated: true)
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
                rewardedAdManager.showRewardedAd(viewController: self)
                print("Watch Ads")
                
            default: break
            }
        default:
            print("Default")
        }
    }
    
    
    func tableViewSettings() {
        settingsTableView.register(SettingsCell.self, forCellReuseIdentifier: "Cell")
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.tableFooterView = UIView(frame: CGRect.zero)
        settingsTableView.cellLayoutMarginsFollowReadableWidth = true
        settingsTableView.separatorStyle = .none
    }
    
    
    func cellsLayout(_ cell: UITableViewCell, uiSwitch: UISwitch) {
        NSLayoutConstraint.activate([
            uiSwitch.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            uiSwitch.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -15)
        ])
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 15
    }
}
