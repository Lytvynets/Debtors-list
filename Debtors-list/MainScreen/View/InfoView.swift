//
//  InfoView.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 27.03.2024.
//

import Foundation
import UIKit

class InfoView: UIView {
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    lazy var debtLabel = LabelBuilder(fontSize: 25, startText: "0$", color: .green)
    lazy var youDebtLabel = LabelBuilder(fontSize: 25, startText: "0$", color: .red)
    lazy var markDebtLabel = LabelBuilder(fontSize: 15, startText: "Given", color: nil)
    lazy var markYouDebtLabel = LabelBuilder(fontSize: 15, startText: "Taken", color: nil)
    lazy var debtStackView = StackViewBuilder(space: 3, type: .center, axisType: .vertical, fillType: .fill)
    lazy var youDebtStackView = StackViewBuilder(space: 3, type: .center, axisType: .vertical, fillType: .fill)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 20
        addSubview(debtStackView)
        addSubview(youDebtStackView)
        addSubview(debtLabel)
        addSubview(youDebtLabel)
        addSubview(markDebtLabel)
        addSubview(markYouDebtLabel)
        setupStackView()
        setConstraints()
        colorSettings()
        fontSettings() 
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            debtStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            debtStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 65),
            youDebtStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            youDebtStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -65),
        ])
    }
    
    
    func setupStackView() {
        debtStackView.addArrangedSubview(debtLabel)
        debtStackView.addArrangedSubview(markDebtLabel)
        youDebtStackView.addArrangedSubview(youDebtLabel)
        youDebtStackView.addArrangedSubview(markYouDebtLabel)
    }
    
    
    func colorSettings() {
        markDebtLabel.textColor = SetColors.currentColor.infoViewLabelColor
        markYouDebtLabel.textColor = SetColors.currentColor.infoViewLabelColor
    }
    
    
    func fontSettings() {
        debtLabel.font = UIFont(name: "Futura Medium", size: screenSize.height * 0.019)
        youDebtLabel.font = UIFont(name: "Futura Medium", size: screenSize.height * 0.019)
        markDebtLabel.font = UIFont(name: "Avenir Book", size: screenSize.height * 0.016)
        markYouDebtLabel.font = UIFont(name: "Avenir Book", size: screenSize.height * 0.016)
    }
}
