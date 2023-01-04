//
//  Currency.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 05.12.2022.
//

import Foundation
import UIKit

class Currency2: UITableViewController {
    
    let currencyArray = ["UAH", "USD", "EUR", "CHF", "GBP"]
    var delegate: CurrencyDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = UserDefaults.standard.bool(forKey: "LightTheme") ? .black : .default
        tableView.backgroundColor = SetColors.currentColor.backgroundColor
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! SettingsCell
        let array = currencyArray[indexPath.row]
        cell.backgroundColor = SetColors.currentColor.backgroundCellColor
        cell.textLabel?.textColor = SetColors.currentColor.labelsColor
        cell.textLabel?.text = array
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = currencyArray[indexPath.row]
        delegate?.pickCurrency(currency)
        print(currency)
        dismiss(animated: true)
    }
    
    
    private func settingsTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "CurrencyCell")
    }
    
}
