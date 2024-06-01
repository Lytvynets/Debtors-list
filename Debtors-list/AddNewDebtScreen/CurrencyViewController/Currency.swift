//
//  Currency.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 05.12.2022.
//

import Foundation
import UIKit
import RealmSwift

class Currency: UITableViewController {
    
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
    
    
    func loadCurrency(completion: @escaping () -> ()) {
        let realm = try! Realm()
        dataManager.debtorsArray = realm.objects(Debtor.self)
        
        for i in  dataManager.debtorsArray {
            switch i.currency {
            case "UAH":
                networkManager.getRequest("USD", "UAH") { data in
                    print("Currency rate UAH: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainViewController.uah = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                    completion()
                }
            case "EUR":
                networkManager.getRequest("USD", "EUR") { data in
                    print("Currency rate EUR: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainViewController.eur = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "CHF":
                networkManager.getRequest("USD", "CHF") { data in
                    print("Currency rate CHF: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainViewController.chf = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "GBP":
                networkManager.getRequest("USD", "GBP") { data in
                    print("Currency rate GBP: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainViewController.gbp = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "PLN":
                networkManager.getRequest("USD", "PLN") { data in
                    print("Currency rate PLN: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainViewController.pln = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "AUD":
                networkManager.getRequest("USD", "AUD") { data in
                    print("Currency rate AUD: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainViewController.aud = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "SEK":
                networkManager.getRequest("USD", "SEK") { data in
                    print("Currency rate SEK: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainViewController.sek = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "JPY":
                networkManager.getRequest("USD", "JPY") { data in
                    print("Currency rate JPY: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainViewController.jpy = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "KWD":
                networkManager.getRequest("USD", "KWD") { data in
                    print("Currency rate KWD: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainViewController.kwd = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            default:
                print("Def2")
            }
        }
    }
    
    
    func convertCurrency(_ debtSum: inout Double, _ debtorsSum: inout Double) {
        let realm = try! Realm()
        dataManager.debtorsArray = realm.objects(Debtor.self)
        
        for i in dataManager.debtorsArray {
            if i.givenDebt == false {
                switch i.currency {
                case "UAH":
                    debtSum += i.sum * (Double(MainViewController.uah) ?? 0.027)
                case "EUR":
                    debtSum += i.sum * (Double(MainViewController.eur) ?? 1.061)
                case "CHF":
                    debtSum += i.sum * (Double(MainViewController.chf) ?? 1.075)
                case "GBP":
                    debtSum += i.sum * (Double(MainViewController.gbp) ??  1.20)
                case "PLN":
                    debtSum += i.sum * (Double(MainViewController.pln) ?? 0.24)
                case "AUD":
                    debtSum += i.sum * (Double(MainViewController.aud) ?? 0.69)
                case "SEK":
                    debtSum += i.sum * (Double(MainViewController.sek) ?? 0.095)
                case "JPY":
                    debtSum += i.sum * (Double(MainViewController.jpy) ?? 0.0076)
                case "KWD":
                    debtSum += i.sum * (Double(MainViewController.kwd) ?? 3.25)
                default:
                    debtSum += i.sum
                }
                
            }else{
                
                switch i.currency {
                case "UAH":
                    debtorsSum += i.sum * (Double(MainViewController.uah) ?? 0.027)
                case "EUR":
                    debtorsSum += i.sum * (Double(MainViewController.eur) ?? 1.061)
                case "CHF":
                    debtorsSum += i.sum * (Double(MainViewController.chf) ?? 1.075)
                case "GBP":
                    debtorsSum += i.sum * (Double(MainViewController.gbp) ??  1.20)
                case "PLN":
                    debtorsSum += i.sum * (Double(MainViewController.pln) ?? 0.24)
                case "AUD":
                    debtorsSum += i.sum * (Double(MainViewController.aud) ?? 0.69)
                case "SEK":
                    debtorsSum += i.sum * (Double(MainViewController.sek) ?? 0.095)
                case "JPY":
                    debtorsSum += i.sum * (Double(MainViewController.jpy) ?? 0.0076)
                case "KWD":
                    debtorsSum += i.sum * (Double(MainViewController.kwd) ?? 3.25)
                default:
                    debtorsSum += i.sum
                }
            }
        }
    }
}
