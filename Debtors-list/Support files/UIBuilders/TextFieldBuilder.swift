//
//  TextFieldBuilder.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 27.04.2024.
//

import Foundation
import UIKit

class TextFieldBuilder: UITextField {
    
    var textPlaceholder: String = ""
    var fontSize: CGFloat = 0
    
    init(textPlaceholder: String, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textPlaceholder = textPlaceholder
        self.fontSize = fontSize
        placeholder = textPlaceholder
        borderStyle = .none
        textAlignment = .center
        textColor = .black
        font = UIFont.systemFont(ofSize: fontSize)
        keyboardType = UIKeyboardType.default
        returnKeyType = UIReturnKeyType.done
        translatesAutoresizingMaskIntoConstraints = false
        clearButtonMode = UITextField.ViewMode.whileEditing
        contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
