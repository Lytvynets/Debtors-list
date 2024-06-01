//
//  Extensions.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 08.12.2022.
//

import UIKit

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
