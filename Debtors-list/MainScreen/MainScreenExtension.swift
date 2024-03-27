//
//  MainScreenLayout.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 08.12.2022.
//

import UIKit
// потрібно якось переробити
extension MainScreen {
    
    func setup() {
        view.addSubview(infoView)
        view.addSubview(mainTableView)
        view.addSubview(blurView)
        infoView.addSubview(debtStackView)
        infoView.addSubview(youDebtStackView)
        infoView.addSubview(debtLabel)
        infoView.addSubview(youDebtLabel)
        infoView.addSubview(markDebtLabel)
        infoView.addSubview(markYouDebtLabel)
        setupBlurView()
       
    }
    
    func setupBlurView() {
        blurView.alpha = 0
        blurView.applyBlurEffect()
        NSLayoutConstraint.activate([
            blurView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blurView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: view.frame.width),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: view.frame.height),
        ])
    }
    
    
    func fontSettings() {
        debtLabel.font = UIFont(name: "Futura Medium", size: view.frame.height * 0.025)
        youDebtLabel.font = UIFont(name: "Futura Medium", size: view.frame.height * 0.025)
        markDebtLabel.font = UIFont(name: "Avenir Book", size: view.frame.height * 0.02)
        markYouDebtLabel.font = UIFont(name: "Avenir Book", size: view.frame.height * 0.02)
    }
    
    
    func setupStackView() {
        debtStackView.addArrangedSubview(debtLabel)
        debtStackView.addArrangedSubview(markDebtLabel)
        youDebtStackView.addArrangedSubview(youDebtLabel)
        youDebtStackView.addArrangedSubview(markYouDebtLabel)
    }
    
    
    func colorSettings() {
        view.backgroundColor = SetColors.currentColor.backgroundColor
        infoView.backgroundColor = SetColors.currentColor.infoViewColor
        mainTableView.backgroundColor = SetColors.currentColor.backgroundColor
        markDebtLabel.textColor = SetColors.currentColor.infoViewLabelColor
        markYouDebtLabel.textColor = SetColors.currentColor.infoViewLabelColor
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            infoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/7.5),
            mainTableView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 5),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            debtStackView.centerYAnchor.constraint(equalTo: infoView.centerYAnchor),
            debtStackView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 65),
            youDebtStackView.centerYAnchor.constraint(equalTo: infoView.centerYAnchor),
            youDebtStackView.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -65),
        ])
    }
}


//MARK: - Blur effect
extension UIView {
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
}
