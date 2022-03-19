//
//  YouNewDebtorViewController.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 18.03.2022.
//

import UIKit
import RealmSwift

class YourNewDebtVC: UITableViewController, UITextFieldDelegate {
    
    var youDebtCurrency = ""
    var yourNewDebt = YourDebtModel(name: "", lastName: "", sum: 0, currency: "")
    
    //MARK: - Outlets for add to the list
    @IBOutlet weak var youDebtorNameTextField: UITextField!
    @IBOutlet weak var youDebtorLastNameTextField: UITextField!
    @IBOutlet weak var youDebtSumTextField: UITextField!
    @IBOutlet weak var youCurrencyStaticLabel: UIButton!
    @IBOutlet weak var youDebtCurrencyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        youDebtorNameTextField.delegate = self
        youDebtorLastNameTextField.delegate = self
        youDebtSumTextField.delegate = self
    }
    
    //Hides the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //MARK: - Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Transfer of data about the choice of currency
        if segue.identifier ==  Keys.yourDebtCurrencyIdentifier.rawValue {
            if let currencyVC = segue.destination as? CurrencySettingsVC {
                currencyVC.completion = {[weak self] text in
                    guard let self = self else { return }
                    self.youDebtCurrencyLabel.text = text
                    self.youDebtCurrency = text
                }
            }
        }
        
        guard segue.identifier == Keys.yourDebtUnwindSegueIdentifier.rawValue else { return }
        let name = youDebtorNameTextField.text ?? ""
        let lastName = youDebtorLastNameTextField.text ?? ""
        let sum = youDebtSumTextField.text ?? ""
        let yourDebtCurrency = youDebtCurrency
        self.yourNewDebt = YourDebtModel(name: name, lastName: lastName, sum: Int(sum) ?? 0, currency: yourDebtCurrency)
    }
}
