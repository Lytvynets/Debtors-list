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

class AddNewDebt: UIViewController, UITextFieldDelegate, CurrencyDelegate {
    
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
    
    lazy var nameTextField = TextFieldBuilder(textPlaceholder: "Name", fontSize: 15)
    lazy var secondNameTextField = TextFieldBuilder(textPlaceholder: "Second name", fontSize: 15)
    lazy var sumTextField = TextFieldBuilder(textPlaceholder: "Sum", fontSize: 15)
    lazy var currencyLabel = LabelBuilder(fontSize: view.frame.height * 0.02, startText: "USD", color: nil)
    
    
    let userInfoTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    init(state: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.state = state
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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
       
        navigationItem.rightBarButtonItem?.isEnabled = false
        nameTextField.attributedPlaceholder = NSAttributedString(
            string: "Name", attributes: [NSAttributedString.Key.foregroundColor: SetColors.currentColor.placeholderTextColor]
        )
        secondNameTextField.attributedPlaceholder = NSAttributedString(
            string: "Second name", attributes: [NSAttributedString.Key.foregroundColor: SetColors.currentColor.placeholderTextColor]
        )
        sumTextField.attributedPlaceholder = NSAttributedString(
            string: "Sum", attributes: [NSAttributedString.Key.foregroundColor: SetColors.currentColor.placeholderTextColor]
        )
        tableViewLayout()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    
    // Hides the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        return ((navigationItem.rightBarButtonItem?.isEnabled = !text.isEmpty ? true : false) != nil)
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
