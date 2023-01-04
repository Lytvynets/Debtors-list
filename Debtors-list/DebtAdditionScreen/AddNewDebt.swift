//
//  AddNewDebt.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 05.12.2022.
//

import Foundation
import UIKit

protocol CurrencyDelegate: AnyObject {
    func pickCurrency(_ currency: String)
}

class AddNewDebt: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, CurrencyDelegate {
    
    var sectionTitles = ["", "", "", ""]
    var sectionContent = [[""], [""], [""], [""]]
    var customizeСells = CustomizeСells()
    var youDebtCurrency = "USD"
    var yourNewDebt = YourDebtModel(name: "", lastName: "", sum: 0, currency: "", date: "")
    var newDebt = Debtors(name: "", lastName: "", sum: 0, currency: "", date: "")
    var dataManager = DataManager()
    var state = false
    var currency = Currency2()
    var setColors = SetColors()
    let cellSpacingHeight: CGFloat = 5
    
    
    init(state: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.state = state
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var nameTextField = TextFieldBuilder(textPlaceholder: "Name", fontSize: 15)
    lazy var secondNameTextField = TextFieldBuilder(textPlaceholder: "Second name", fontSize: 15)
    lazy var sumTextField = TextFieldBuilder(textPlaceholder: "Sum", fontSize: 15)
    lazy var currencyLabel = LabelBuilder(fontSize: view.frame.height * 0.02, startText: "USD", color: nil)
    
    
    let userInfoTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    //MARK: - View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(userInfoTableView)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addTapped))
        navigationItem.title = "Add debt"
        nameTextField.delegate = self
        secondNameTextField.delegate = self
        sumTextField.delegate = self
        sumTextField.keyboardType = .numberPad
        userInfoTableView.register(SettingsCell.self, forCellReuseIdentifier: "Cell")
        userInfoTableView.separatorStyle = .none
        userInfoTableView.dataSource = self
        userInfoTableView.delegate = self
        // currencyLabel.font = UIFont(name: "Avenir Book", size: view.frame.height * 0.02)
        
        NSLayoutConstraint.activate([
            userInfoTableView.topAnchor.constraint(equalTo: view.topAnchor),
            userInfoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            userInfoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            userInfoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        
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
    
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 15
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // view.backgroundColor = SetColors.currentColor.backgroundColor
        
        setColors.navigationControllerColorSettings(self)
        setColors.backButtonSettings(self)
        navigationController?.navigationBar.barStyle = UserDefaults.standard.bool(forKey: "LightTheme") ? .black : .default
        colorSettings()
        userInfoTableView.reloadData()
    }
    
    
    private func colorSettings() {
        userInfoTableView.backgroundColor = SetColors.currentColor.backgroundColor
        view.backgroundColor = SetColors.currentColor.backgroundColor
        nameTextField.backgroundColor = SetColors.currentColor.backgroundCustomViewColor
        secondNameTextField.backgroundColor = SetColors.currentColor.backgroundCustomViewColor
        nameTextField.textColor = SetColors.currentColor.labelsColor
        secondNameTextField.textColor = SetColors.currentColor.labelsColor
        sumTextField.textColor = SetColors.currentColor.labelsColor
        currencyLabel.textColor = SetColors.currentColor.labelsColor
    }
    
    
    //MARK: - Work with table view
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
    
    
    private func currencyLabelLayout(_ cell: UITableViewCell) {
        cell.addSubview(currencyLabel)
        NSLayoutConstraint.activate([
            currencyLabel.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            currencyLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -30)
        ])
    }
    
    private func sumTextFieldLayout(_ cell: UITableViewCell) {
        cell.addSubview(sumTextField)
        NSLayoutConstraint.activate([
            sumTextField.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            sumTextField.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 0),
            sumTextField.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: 0)
        ])
    }
    
    private  func nameLabelLayout(_ cell: UITableViewCell) {
        cell.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 0),
            nameTextField.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: 0)
        ])
    }
    
    
    private func secondNameLayout(_ cell: UITableViewCell) {
        cell.addSubview(secondNameTextField)
        NSLayoutConstraint.activate([
            secondNameTextField.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            secondNameTextField.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 0),
            secondNameTextField.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: 0)
        ])
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
    
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        nameTextField.text = String(nameTextField.text!.prefix(10))
        secondNameTextField.text = String(secondNameTextField.text!.prefix(10))
        sumTextField.text = String(sumTextField.text!.prefix(6))
    }
    
    // Hides the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    func pickCurrency(_ currency: String) {
        youDebtCurrency = currency
        currencyLabel.text = currency
    }
    
    
    //MARK: - Actions
    @objc func addTapped() {
        let name = nameTextField.text ?? ""
        let lastName = secondNameTextField.text ?? ""
        let sum = sumTextField.text ?? ""
        let yourDebtCurrency = youDebtCurrency
        
        let now = Date()
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        let dateTime = dateFormater.string(from: now)
        
        yourNewDebt = YourDebtModel(name: name, lastName: lastName, sum: Double(sum) ?? 0, currency: yourDebtCurrency, date: dateTime)
        newDebt = Debtors(name: name, lastName: lastName, sum: Double(sum) ?? 0, currency: yourDebtCurrency, date: dateTime)
        if state == false {
            navigationController?.popViewController(animated: true)
            dataManager.saveToRealm(debtor: newDebt)
        }else{
            navigationController?.popViewController(animated: true)
            dataManager.saveToRealm2(debtor: yourNewDebt)
        }
    }
}
