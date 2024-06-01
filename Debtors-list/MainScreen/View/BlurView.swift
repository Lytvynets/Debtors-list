//
//  BlurView.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 27.03.2024.
//

import Foundation
import UIKit

class BlurView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
