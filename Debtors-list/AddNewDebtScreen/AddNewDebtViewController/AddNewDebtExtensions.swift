//
//  AddNewDebtExtensions.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 27.04.2024.
//

import Foundation

extension AddNewDebtViewController: PickCurrencyDelegate {
    func showCurrencyList() {
        let vc = Currency()
        vc.delegate = self
        present(vc, animated: true)
    }
}


extension AddNewDebtViewController: CurrencyDelegate {
    func pickCurrency(_ currency: String) {
        youDebtCurrency = currency
        userInfoTableView.currencyLabel.text = currency
    }
}
