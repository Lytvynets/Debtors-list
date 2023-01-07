//
//  Currency.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 05.12.2022.
//

import Foundation
import UIKit
import RealmSwift

class Currency2: UITableViewController {
    
    let currencyArray = ["UAH", "USD", "EUR", "CHF", "GBP", "PLN", "AUD", "SEK", "JPY", "KWD"]
    let currencyDictionary = ["Ukrainian hryvnia" , "United states dollar", "Euro", "Swiss franc", "British pound", "Polish zloty", "Australian dollar", "Swedish krona", "Japanese yen", "Kuwaiti dinar"]
    var delegate: CurrencyDelegate?
    var dataManager = DataManager()
    var networkManager = NetworkManager()
    
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
        let discription = currencyDictionary[indexPath.row]
        cell.backgroundColor = SetColors.currentColor.backgroundCellColor
        cell.textLabel?.textColor = SetColors.currentColor.labelsColor
        cell.textLabel?.text = array + " " + "( \(discription) )"
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
    
    
    func convertCurrency(_ debtSum: inout Double, _ debtorsSum: inout Double) {
       
        let realm = try! Realm()
        dataManager.debtorsArray = realm.objects(Debtors.self)
        dataManager.youDebtArray = realm.objects(YourDebtModel.self)
        
        for i in dataManager.youDebtArray {
            switch i.currency {
            case "UAH":
                debtSum += i.sum * (Double(MainScreen.uah) ?? 0.027)
            case "EUR":
                debtSum += i.sum * (Double(MainScreen.eur) ?? 1.061)
            case "CHF":
                debtSum += i.sum * (Double(MainScreen.chf) ?? 1.075)
            case "GBP":
                debtSum += i.sum * (Double(MainScreen.gbp) ??  1.20)
            case "PLN":
                debtSum += i.sum * (Double(MainScreen.pln) ?? 0.24)
            case "AUD":
                debtSum += i.sum * (Double(MainScreen.aud) ?? 0.69)
            case "SEK":
                debtSum += i.sum * (Double(MainScreen.sek) ?? 0.095)
            case "JPY":
                debtSum += i.sum * (Double(MainScreen.jpy) ?? 0.0076)
            case "KWD":
                debtSum += i.sum * (Double(MainScreen.kwd) ?? 3.25)
            default:
                debtSum += i.sum
            }
        }
        
        
        for i in  dataManager.debtorsArray {
            switch i.currency {
            case "UAH":
                debtorsSum += i.sum * (Double(MainScreen.uah) ?? 0.027)
            case "EUR":
                debtorsSum += i.sum * (Double(MainScreen.eur) ?? 1.061)
            case "CHF":
                debtorsSum += i.sum * (Double(MainScreen.chf) ?? 1.075)
            case "GBP":
                debtorsSum += i.sum * (Double(MainScreen.gbp) ??  1.20)
            case "PLN":
                debtorsSum += i.sum * (Double(MainScreen.pln) ?? 0.24)
            case "AUD":
                debtorsSum += i.sum * (Double(MainScreen.aud) ?? 0.69)
            case "SEK":
                debtorsSum += i.sum * (Double(MainScreen.sek) ?? 0.095)
            case "JPY":
                debtorsSum += i.sum * (Double(MainScreen.jpy) ?? 0.0076)
            case "KWD":
                debtorsSum += i.sum * (Double(MainScreen.kwd) ?? 3.25)
            default:
                debtorsSum += i.sum
            }
        }
    }
}
