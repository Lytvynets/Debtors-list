//
//  AddNewDebtLayout.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 05.01.2023.
//

import UIKit

extension AddNewDebt {
    func tableViewLayout() {
       NSLayoutConstraint.activate([
           userInfoTableView.topAnchor.constraint(equalTo: view.topAnchor),
           userInfoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
           userInfoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
           userInfoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
       ])
   }
    
    func currencyLabelLayout(_ cell: UITableViewCell) {
        cell.addSubview(currencyLabel)
        NSLayoutConstraint.activate([
            currencyLabel.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            currencyLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -30)
        ])
    }
    
    
    func sumTextFieldLayout(_ cell: UITableViewCell) {
        cell.addSubview(sumTextField)
        NSLayoutConstraint.activate([
            sumTextField.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            sumTextField.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 0),
            sumTextField.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: 0)
        ])
    }
    
    
    func nameLabelLayout(_ cell: UITableViewCell) {
        cell.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 0),
            nameTextField.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: 0)
        ])
    }
    
    
    func secondNameLayout(_ cell: UITableViewCell) {
        cell.addSubview(secondNameTextField)
        NSLayoutConstraint.activate([
            secondNameTextField.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            secondNameTextField.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 0),
            secondNameTextField.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: 0)
        ])
    }
}
