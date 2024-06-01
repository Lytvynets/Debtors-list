//
//  DebtorCell.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 05.12.2022.
//

import Foundation
import UIKit

class DebtorCell: UITableViewCell {
    
    let screenSize: CGRect = UIScreen.main.bounds
  //  var customizeShadows = CustomizeShadows()
    var givenDebt = true
    
    lazy var numberOfRowLabel = LabelBuilder(fontSize: 15, startText: "", color: nil)
    lazy var firstNameLabel = LabelBuilder(fontSize: 15, startText: "", color: nil)
    lazy var secondNameLabel = LabelBuilder(fontSize: 15, startText: "", color: nil)
    lazy var sumOfDebtLabel = LabelBuilder(fontSize: 15, startText: "0", color: nil)
    lazy var dateLabel = LabelBuilder(fontSize: 15, startText: "", color: nil)
    lazy var currencyLabel = LabelBuilder(fontSize: 15, startText: "USD", color: nil)
    
    //Stack views
    lazy var debtorsUserInfoStackView = StackViewBuilder(space: 0.5, type: .leading, axisType: .vertical, fillType: .fill)
    lazy var debtorsInfoStackView = StackViewBuilder(space: 0.5, type: .trailing, axisType: .vertical, fillType: .fill)
    lazy var debtorsSumInfoStackView = StackViewBuilder(space: 7, type: .leading, axisType: .horizontal, fillType: .fill)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(firstNameLabel)
        contentView.addSubview(secondNameLabel)
        contentView.addSubview(sumOfDebtLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(numberOfRowLabel)
        contentView.addSubview(currencyLabel)
        contentView.addSubview(debtorsUserInfoStackView)
        contentView.addSubview(debtorsSumInfoStackView)
        contentView.addSubview(debtorsInfoStackView)
        //Stack views
        debtorsUserInfoStackView.addArrangedSubview(firstNameLabel)
        debtorsUserInfoStackView.addArrangedSubview(secondNameLabel)
        debtorsSumInfoStackView.addArrangedSubview(sumOfDebtLabel)
        debtorsSumInfoStackView.addArrangedSubview(currencyLabel)
        debtorsInfoStackView.addArrangedSubview(debtorsSumInfoStackView)
        debtorsInfoStackView.addArrangedSubview(dateLabel)
        setConstraints()
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            numberOfRowLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            numberOfRowLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            debtorsUserInfoStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            debtorsUserInfoStackView.leadingAnchor.constraint(equalTo: numberOfRowLabel.trailingAnchor, constant: 10),
            debtorsInfoStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            debtorsInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25)
        ])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
