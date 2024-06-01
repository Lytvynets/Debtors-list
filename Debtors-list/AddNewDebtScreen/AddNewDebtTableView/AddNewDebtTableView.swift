//
//  AddNewDebtTableView.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 27.04.2024.
//

import Foundation
import UIKit

class AddNewDebtTableView: UITableView, UITableViewDelegate, UITableViewDataSource  {
    
    var sectionTitles = ["", "", "", ""]
    var sectionContent = [[""], [""], [""], [""]]
    var customizeСells = CustomizeСells()
    let cellSpacingHeight: CGFloat = 5
    let screenSize: CGRect = UIScreen.main.bounds
    var pickCurrencyDelegate: PickCurrencyDelegate?
    
    lazy var nameTextField = TextFieldBuilder(textPlaceholder: "Name", fontSize: 15)
    lazy var secondNameTextField = TextFieldBuilder(textPlaceholder: "Second name", fontSize: 15)
    lazy var sumTextField = TextFieldBuilder(textPlaceholder: "Sum", fontSize: 15)
    lazy var currencyLabel = LabelBuilder(fontSize: screenSize.height * 0.02, startText: "USD", color: nil)
    
    
    //MARK: - Init
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        dataSource = self
        delegate = self
        translatesAutoresizingMaskIntoConstraints = false
        register(SettingsCell.self, forCellReuseIdentifier: "Cell")
        separatorStyle = .none
        textFieldsSettings()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - TableView
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
        return screenSize.height / 15
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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.layer.cornerRadius = screenSize.height * 0.016
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
                cell.textLabel?.font = UIFont(name: "Avenir Book", size: screenSize.height * 0.02)
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
                pickCurrencyDelegate?.showCurrencyList()
            default:
                print("Error in Switch")
            }
        default: break
        }
    }
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        nameTextField.text = String(nameTextField.text!.prefix(15))
        secondNameTextField.text = String(secondNameTextField.text!.prefix(15))
        sumTextField.text = String(sumTextField.text!.prefix(10))
    }
    
    
    private func textFieldsSettings() {
        nameTextField.attributedPlaceholder = NSAttributedString(
            string: "Name", attributes: [NSAttributedString.Key.foregroundColor: SetColors.currentColor.placeholderTextColor]
        )
        
        secondNameTextField.attributedPlaceholder = NSAttributedString(
            string: "Second name", attributes: [NSAttributedString.Key.foregroundColor: SetColors.currentColor.placeholderTextColor]
        )
        
        sumTextField.attributedPlaceholder = NSAttributedString(
            string: "Sum", attributes: [NSAttributedString.Key.foregroundColor: SetColors.currentColor.placeholderTextColor]
        )
    }
    
    
    //MARK: - Layout
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
