//
//  DataCells.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 05.12.2022.
//

import Foundation
import UIKit

class DataCells {
    func debtorInfo(_ cell: DebtorCell, _ indexPath: IndexPath, _ debtors: Debtor) {
        cell.numberOfRowLabel.text = ("\(indexPath.row + 1) .")
        cell.firstNameLabel.text = debtors.name
        cell.secondNameLabel.text = "\(debtors.lastName)"
        cell.sumOfDebtLabel.text = "\(debtors.sum)"
        cell.currencyLabel.text = debtors.currency
        cell.dateLabel.text = debtors.date
        cell.selectionStyle = .none
    }
}
