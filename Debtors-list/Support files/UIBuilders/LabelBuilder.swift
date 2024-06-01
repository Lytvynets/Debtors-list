//
//  LabelBuilder.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 09.12.2022.
//

import UIKit

class LabelBuilder: UILabel {
    
    var fontSize: CGFloat = 0
    var startText = ""
    var color: UIColor?
    
    init(fontSize: CGFloat, startText: String, color: UIColor?) {
        super.init(frame: .zero)
        self.fontSize = fontSize
        self.startText = startText
        text = startText
        textColor = color
        font = UIFont.systemFont(ofSize: fontSize)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
