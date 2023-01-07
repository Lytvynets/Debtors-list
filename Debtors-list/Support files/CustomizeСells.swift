//
//  CustomizeСells.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 05.12.2022.
//

import Foundation
import UIKit

class CustomizeСells {
    func settingsDebtorsCell(_ cell: DebtorCell, _ sumColor: UIColor) {
        cell.backgroundColor = SetColors.currentColor.backgroundCellColor
        cell.firstNameLabel.textColor = SetColors.currentColor.labelsColor
        cell.secondNameLabel.textColor = .gray //SetColors.currentColor.labelsColor
        cell.numberOfRowLabel.textColor = SetColors.currentColor.labelsColor
        cell.layer.borderColor = SetColors.currentColor.backgroundColor.cgColor
        cell.currencyLabel.textColor = SetColors.currentColor.labelsColor
        cell.sumOfDebtLabel.textColor = sumColor
        cell.dateLabel.textColor = .gray
        cell.selectionStyle = .none
    }
    
    
    func cellsColor(_ cell: UITableViewCell) {
        cell.selectionStyle = .none
        UIView.animate(withDuration: 0.8) {
            cell.backgroundColor = SetColors.currentColor.backgroundCustomViewColor
            cell.textLabel?.textColor = SetColors.currentColor.labelsColor
        }
    }
    
    
    func colorSumLabel(_ array: Debtor, _ cell: DebtorCell) {
        if ((array as? YourDebtModel) != nil) {
            cell.sumOfDebtLabel.textColor = .red
            cell.sumOfDebtLabel.text = "-\(array.sum)"
        }else{
            cell.sumOfDebtLabel.textColor = .green
            cell.sumOfDebtLabel.text = "\(array.sum)"
        }
    }
    
    
    func fontSettingsCell(_ cell: DebtorCell, view: UIView ) {
        cell.numberOfRowLabel.font = UIFont(name: "Noteworthy Light", size: view.frame.height * 0.025)
        cell.firstNameLabel.font = UIFont(name: "Noteworthy Bold", size: view.frame.height * 0.020)
        cell.secondNameLabel.font = UIFont(name: "Noteworthy Light", size: view.frame.height * 0.020)
        cell.sumOfDebtLabel.font = UIFont(name: "Noteworthy Bold", size: view.frame.height * 0.020)
        cell.currencyLabel.font = UIFont(name: "Noteworthy Bold", size: view.frame.height * 0.020)
        cell.dateLabel.font = UIFont(name: "Noteworthy Light", size: view.frame.height * 0.018)
    }
}
