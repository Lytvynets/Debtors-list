//
//  EditDataScreen.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 16.03.2024.
//

import Foundation
import UIKit
import RealmSwift

protocol EditDataDelegate {
    func reloadTableView()
}

class EdidDataScreen: UIViewController, UITextFieldDelegate {
    
    var sum = 0.0
    var name = ""
    var currency = ""
    var indexOfItem = 0
    var newSum = 0.0
    
    var dataManager = DataManager()
    var setColors = SetColors()
    var newDebt = Debtors(name: "", lastName: "", sum: 0, currency: "", date: "")
    var editDataDelegate: EditDataDelegate?
    
    lazy var plusMinusLabel = LabelBuilder(fontSize: 25, startText: "+", color: SetColors.currentColor.labelsColor)
    lazy var sumLabel = LabelBuilder(fontSize: 25, startText: "000", color: SetColors.currentColor.labelsColor)
    lazy var sumTextField = TextFieldBuilder(textPlaceholder: "Sum", fontSize: 25)
    
    lazy var segmentedControll: UISegmentedControl = {
        let uiSegmentedControll = UISegmentedControl(items: ["Plus", "Minus"])
        uiSegmentedControll.translatesAutoresizingMaskIntoConstraints = false
        uiSegmentedControll.addTarget(self, action: #selector(segmentedAction), for: .valueChanged)
        uiSegmentedControll.selectedSegmentIndex = 0
        return uiSegmentedControll
    }()
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = SetColors.currentColor.backgroundCustomViewColor
        view.addSubview(sumTextField)
        view.addSubview(sumLabel)
        view.addSubview(segmentedControll)
        view.addSubview(plusMinusLabel)
        
        sumTextField.delegate = self
        sumTextField.keyboardType = .numberPad
        sumTextField.textColor = SetColors.currentColor.labelsColor
        sumTextField.tintColor = SetColors.currentColor.labelsColor
        sumTextField.backgroundColor = SetColors.currentColor.backgroundCustomViewColor
        sumTextField.layer.cornerRadius = 15
        
        navigationItem.title = name
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addTapped))
        setColors.navigationControllerColorSettings(self)
        setConstraints()
        
        let realm = try! Realm()
        dataManager.debtorsArray = realm.objects(Debtors.self)
        
    }
    
    
    //MARK: - Layout
    private func setConstraints() {
        NSLayoutConstraint.activate([
            segmentedControll.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            segmentedControll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sumLabel.centerYAnchor.constraint(equalTo: sumTextField.centerYAnchor),
            sumLabel.topAnchor.constraint(equalTo: segmentedControll.bottomAnchor, constant: 15),
            sumLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            plusMinusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            plusMinusLabel.centerYAnchor.constraint(equalTo: sumTextField.centerYAnchor),
            sumTextField.topAnchor.constraint(equalTo: segmentedControll.bottomAnchor, constant: 15),
            sumTextField.leadingAnchor.constraint(equalTo: plusMinusLabel.trailingAnchor, constant: 16),
            sumTextField.heightAnchor.constraint(equalToConstant: 45),
            sumTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
        ])
    }
    
    
    //MARK: - UITextFieldDelegate
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let newSum = Double(textField.text ?? "") {
            if plusMinusLabel.text == "+" {
                let result = sum + newSum
                self.newSum = result
                sumLabel.text = "\(result) \(currency)"
            }else{
                let result = sum - newSum
                self.newSum = result
                sumLabel.text = "\(result) \(currency)"
            }
        }else{
            sumLabel.text = "\(sum) \(currency)"
        }
    }
    
    
    //MARK: - Actions
    @objc func addTapped() {
        let name = name
        let lastName = ""
        let sum = Double("\(String(describing: sumLabel.text))")
        let yourDebtCurrency = currency
        
        let now = Date()
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        let dateTime = dateFormater.string(from: now)
        
        let debtors = self.dataManager.debtorsArray[self.indexOfItem]
        self.dataManager.deleteFromRealm(debtor: debtors, tableView: nil)
        
        DispatchQueue.main.async {
            self.newDebt = Debtors(name: name, lastName: lastName, sum: self.newSum, currency: yourDebtCurrency, date: dateTime)
            self.dataManager.saveToRealm(debtor: self.newDebt)
            self.editDataDelegate?.reloadTableView()
        }
        
        dismiss(animated: true)
    }
    
    
    @objc private func segmentedAction() {
        switch segmentedControll.selectedSegmentIndex {
        case 0:
            plusMinusLabel.text = "+"
            guard let test = Double(sumTextField.text ?? "") else { return }
            let result = sum + test
            self.newSum = result
            sumLabel.text = "\(result) \(currency)"
        case 1:
            plusMinusLabel.text = "-"
            guard let test = Double(sumTextField.text ?? "") else { return }
            let result = sum - test
            self.newSum = result
            sumLabel.text = "\(result) \(currency)"
        default:
            plusMinusLabel.text = "+"
        }
    }
}
