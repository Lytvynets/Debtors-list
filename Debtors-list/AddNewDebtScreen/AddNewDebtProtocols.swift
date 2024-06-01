//
//  AddNewDebtProtocols.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 27.04.2024.
//

import Foundation

protocol CurrencyDelegate: AnyObject {
    func pickCurrency(_ currency: String)
}

protocol PickCurrencyDelegate {
    func showCurrencyList()
}
