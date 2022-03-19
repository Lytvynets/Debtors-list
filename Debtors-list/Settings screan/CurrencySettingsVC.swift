//
//  CurrencySettingsViewController.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 18.03.2022.
//

import UIKit

class CurrencySettingsVC: UITableViewController {
  
    var completion: ((String) -> ())?
  
    // Currency
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var uahLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var rubLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var btcLabel: UILabel!
    
    @IBOutlet weak var usdButton: UIButton!
    @IBOutlet weak var uahButton: UIButton!
    @IBOutlet weak var eurButton: UIButton!
    @IBOutlet weak var rubButton: UIButton!
    @IBOutlet weak var chfButton: UIButton!
    @IBOutlet weak var gbpButton: UIButton!
    @IBOutlet weak var btcButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
    
    
    //MARK: - Currency selection buttons
    @IBAction func usdButton(_ sender: UIButton) {
        completion?(Currency.USD.rawValue)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func uahButton(_ sender: UIButton) {
        completion?(Currency.UAH.rawValue)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func eurButton(_ sender: UIButton) {
        completion?(Currency.EUR.rawValue)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rubButton(_ sender: UIButton) {
        completion?(Currency.RUB.rawValue)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chfButton(_ sender: UIButton) {
        completion?(Currency.CHF.rawValue)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func gbpButton(_ sender: UIButton) {
        completion?(Currency.GBP.rawValue)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btcButton(_ sender: UIButton) {
        completion?(Currency.BTC.rawValue)
        self.dismiss(animated: true, completion: nil)
    }
}
