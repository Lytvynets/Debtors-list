//
//  NewDebtTableView.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 05.01.2023.
//

import UIKit

extension AddNewDebt: UITableViewDelegate, UITableViewDataSource {
    
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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 15
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
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        nameTextField.text = String(nameTextField.text!.prefix(10))
        secondNameTextField.text = String(secondNameTextField.text!.prefix(10))
        sumTextField.text = String(sumTextField.text!.prefix(6))
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.layer.cornerRadius = view.frame.height * 0.016
        customizeСells.cellsColor(cell)
        
        switch (indexPath as NSIndexPath).section {
        case 0:
            switch (indexPath as NSIndexPath).row {
            case 0:
                nameLabelLayout(cell)
            default:
                print("1")
            }
        case 1:
            switch (indexPath as NSIndexPath).row {
            case 0:
                secondNameLayout(cell)
            default:
                print("2")
            }
        case 2:
            switch (indexPath as NSIndexPath).row {
            case 0:
                sumTextFieldLayout(cell)
            default:
                print("3")
            }
        case 3:
            switch (indexPath as NSIndexPath).row {
            case 0:
                cell.textLabel?.text = "Currency"
                cell.textLabel?.font = UIFont(name: "Avenir Book", size: view.frame.height * 0.02)
                currencyLabelLayout(cell)
            default:
                print("4")
            }
        default: break
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath as NSIndexPath).section {
        case 3:
            switch (indexPath as NSIndexPath).row {
            case 0:
                let vc = Currency2()
                vc.delegate = self
                present(vc, animated: true)
            default:
                print("Error in Switch")
            }
        default: break
        }
    }
}
