//
//  AddNewDebt.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 05.12.2022.
//

import Foundation
import UIKit

class AddNewDebtViewController: UIViewController, UITextFieldDelegate {
    
    var youDebtCurrency = "USD"
    var dataManager = DataManager()
    var state = false
    var given = true
    var currency = Currency()
    var setColors = SetColors()
    var editDataDelegate: EditDataDelegate?
    let userInfoTableView = AddNewDebtTableView()
    
    
    lazy var segmentedControll: UISegmentedControl = {
        let uiSegmentedControll = UISegmentedControl(items: ["Given", "Taken"])
        uiSegmentedControll.translatesAutoresizingMaskIntoConstraints = false
        uiSegmentedControll.addTarget(self, action: #selector(segmentedAction), for: .valueChanged)
        uiSegmentedControll.selectedSegmentIndex = 0
        return uiSegmentedControll
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
        view.addSubview(segmentedControll)
        view.addSubview(userInfoTableView)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addTapped))
        navigationItem.title = "Add debt"
        userInfoTableView.nameTextField.delegate = self
        userInfoTableView.secondNameTextField.delegate = self
        userInfoTableView.sumTextField.delegate = self
        userInfoTableView.sumTextField.keyboardType = .numberPad
        userInfoTableView.register(SettingsCell.self, forCellReuseIdentifier: "Cell")
        userInfoTableView.separatorStyle = .none
        userInfoTableView.pickCurrencyDelegate = self
        navigationItem.rightBarButtonItem?.isEnabled = false
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
    
    
    private func tableViewLayout() {
        NSLayoutConstraint.activate([
            segmentedControll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            segmentedControll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            segmentedControll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            userInfoTableView.topAnchor.constraint(equalTo: segmentedControll.bottomAnchor, constant: 10),
            userInfoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            userInfoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            userInfoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
    
    
    private func colorSettings() {
        userInfoTableView.backgroundColor = SetColors.currentColor.backgroundColor
        view.backgroundColor = SetColors.currentColor.backgroundColor
        userInfoTableView.nameTextField.backgroundColor = SetColors.currentColor.backgroundCustomViewColor
        userInfoTableView.secondNameTextField.backgroundColor = SetColors.currentColor.backgroundCustomViewColor
        userInfoTableView.nameTextField.textColor = SetColors.currentColor.labelsColor
        userInfoTableView.secondNameTextField.textColor = SetColors.currentColor.labelsColor
        userInfoTableView.sumTextField.textColor = SetColors.currentColor.labelsColor
        userInfoTableView.currencyLabel.textColor = SetColors.currentColor.labelsColor
    }
    
    
    //MARK: - Actions
    @objc func addTapped() {
        let name = userInfoTableView.nameTextField.text ?? ""
        let lastName = userInfoTableView.secondNameTextField.text ?? ""
        let sum = userInfoTableView.sumTextField.text ?? ""
        let currency = youDebtCurrency
        let now = Date()
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        let dateTime = dateFormater.string(from: now)
        
        let debtor = DebtorBuilder()
            .setName(name)
            .setLastName(lastName)
            .setSum(Double(sum) ?? 0.0)
            .setCurrency(currency)
            .setDate(dateTime)
            .setTypeOfDebt(given)
            .buildDebtor()
        
        dataManager.saveToRealm3(debtor: debtor)
        DispatchQueue.main.async {
            self.editDataDelegate?.reloadTableView()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @objc private func segmentedAction() {
        switch segmentedControll.selectedSegmentIndex {
        case 0:
            given = true
        case 1:
            given = false
        default:
            given = true
        }
    }
}
