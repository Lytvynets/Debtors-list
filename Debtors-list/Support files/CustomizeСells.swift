//
//  CustomizeСells.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 05.12.2022.
//

import Foundation
import UIKit

class CustomizeСells {
    func settingsDebtorsCell(_ cell: DebtorCell, _ sumColor: UIColor) {
        cell.backgroundColor = SetColors.currentColor.backgroundCellColor
        cell.firstNameLabel.textColor = SetColors.currentColor.labelsColor
        cell.secondNameLabel.textColor = .gray
        cell.numberOfRowLabel.textColor = SetColors.currentColor.labelsColor
        cell.layer.borderColor = SetColors.currentColor.backgroundColor.cgColor
        cell.currencyLabel.textColor = SetColors.currentColor.labelsColor
        cell.sumOfDebtLabel.textColor = sumColor
        cell.dateLabel.textColor = .gray
        cell.selectionStyle = .none
    }
    
    
    func cellsColor(_ cell: UITableViewCell) {
        cell.selectionStyle = .none
        UIView.animate(withDuration: 0.8) {
            cell.backgroundColor = SetColors.currentColor.backgroundCustomViewColor
            cell.textLabel?.textColor = SetColors.currentColor.labelsColor
        }
    }
    
    
    func fontSettingsCell(_ cell: DebtorCell, screenSize: CGFloat ) {
        let numberOfRowLabelFontSize = fontSizeForText(cell.numberOfRowLabel.text ?? "",
                                                       maxFontSize: screenSize * 0.025,
                                                       minFontSize: screenSize * 0.023)
        cell.numberOfRowLabel.font = UIFont(name: "Noteworthy Light",
                                            size: numberOfRowLabelFontSize)
        
        let firstNameFontSize = fontSizeForText(cell.firstNameLabel.text ?? "",
                                                maxFontSize: screenSize * 0.020,
                                                minFontSize: screenSize * 0.018)
        cell.firstNameLabel.font = UIFont(name: "Noteworthy Bold",
                                          size: firstNameFontSize)
        
        let sumOfDebtLabelFontSize = fontSizeForText(cell.sumOfDebtLabel.text ?? "",
                                                     maxFontSize: screenSize * 0.020,
                                                     minFontSize: screenSize * 0.018)
        cell.sumOfDebtLabel.font = UIFont(name: "Noteworthy Bold",
                                          size: sumOfDebtLabelFontSize)
        
        let secondNameLabelFontSize = fontSizeForText(cell.secondNameLabel.text ?? "",
                                                      maxFontSize: screenSize * 0.020,
                                                      minFontSize: screenSize * 0.018)
        cell.secondNameLabel.font = UIFont(name: "Noteworthy Bold",
                                           size: secondNameLabelFontSize)
        
        cell.currencyLabel.font = UIFont(name: "Noteworthy Bold", size: screenSize * 0.020)
        cell.dateLabel.font = UIFont(name: "Noteworthy Light", size: screenSize * 0.018)
    }
    
    
    func fontSizeForText(_ text: String, maxFontSize: CGFloat, minFontSize: CGFloat ) -> CGFloat {
        let maxLength: CGFloat = 10
        let minLength: CGFloat = 3
        let length = CGFloat(text.count)
        let scaleFactor = (maxLength - length) / (maxLength - minLength)
        let maxFontSize: CGFloat = maxFontSize
        let minFontSize: CGFloat = minFontSize
        let fontSize = minFontSize + scaleFactor * (maxFontSize - minFontSize)
        return fontSize
    }
}
