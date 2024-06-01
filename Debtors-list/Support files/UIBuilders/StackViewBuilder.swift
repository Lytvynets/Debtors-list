//
//  StackViewBuilder.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 27.04.2024.
//

import Foundation
import UIKit

class StackViewBuilder: UIStackView {
    
    var space: CGFloat = 0
    var type: UIStackView.Alignment = .center
    var axisType: NSLayoutConstraint.Axis = .vertical
    var fillType: UIStackView.Distribution = .fill
    
    init(space: CGFloat, type: UIStackView.Alignment, axisType: NSLayoutConstraint.Axis, fillType: UIStackView.Distribution) {
        super.init(frame: .zero)
        self.space = space
        self.type = type
        self.axisType = axisType
        self.fillType = fillType
        spacing = space
        axis = axisType
        alignment = type
        distribution = fillType
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
