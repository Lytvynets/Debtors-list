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
