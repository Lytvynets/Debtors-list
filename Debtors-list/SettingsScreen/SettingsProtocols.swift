//
//  Protocols.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 30.03.2024.
//

import Foundation
import UIKit

protocol SettingsTableViewDelegate {
    func switchTheme(sender: UISwitch)
    func switchIdDidChange(sender: UISwitch)
    func switchRoundDidChange(sender: UISwitch)
    func showNotificationsSettings()
    func showAds()
}
