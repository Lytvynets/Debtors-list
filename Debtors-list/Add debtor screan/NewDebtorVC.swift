//
//  File.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 18.03.2022.
//

import UIKit
import RealmSwift

class NewDebtorVC: UITableViewController, UITextFieldDelegate {
    
    var currency = ""
    var newDebtors = Debtors(name: "", lastName: "", sum: 0, currency: "")
    
    //MARK: - Outlets for add to the list
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var sumTextField: UITextField!
    @IBOutlet weak var currencyStaticLabel: UIButton!
    @IBOutlet weak var currencyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        lastNameTextField.delegate = self
        sumTextField.delegate = self
       
    }
    
    // Hides the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //MARK: - Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Transfer of data about the choice of currency
        if segue.identifier == Keys.currencyIdentifier.rawValue {
            if let currencyVC = segue.destination as? CurrencySettingsVC {
                currencyVC.completion = {[weak self] text in
                    guard let self = self else { return }
                    self.currencyLabel.text = text
                    self.currency = text
                }
            }
        }
        
        guard segue.identifier == Keys.unwindSegueIdentifier.rawValue else { return }
        let name = nameTextField.text ?? ""
        let secondName = lastNameTextField.text ?? ""
        let sum = sumTextField.text ?? ""
        let currency = currency
        self.newDebtors = Debtors(name: name, lastName: secondName, sum: Int(sum) ?? 0, currency: currency)
    }
}
