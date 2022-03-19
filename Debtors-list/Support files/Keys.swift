//
//  Keys.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 18.03.2022.
//

import Foundation

enum Keys: String {
    case image = "image"
    case nameLabelUserDefaultsIdentifier = "NameLabel"
    case profileUnwindSegueIdentifier = "UnwindSegueProfile"
    case yourDebtUnwindSegueIdentifier = "SecondSaveSegue"
    case unwindSegueIdentifier = "SaveSegue"
    case yourDebtCurrencyIdentifier = "YouCurrencySegue"
    case currencyIdentifier = "CurrencySegue"
    case cellIdentifier = "Cell"
    case yourDebtCellIdentifier = "SecondCell"
}

enum Currency: String {
    case USD = "USD"
    case UAH = "UAH"
    case EUR = "EUR"
    case RUB = "RUB"
    case CHF = "CHF"
    case GBP = "GBP"
    case BTC = "BTC"
}
