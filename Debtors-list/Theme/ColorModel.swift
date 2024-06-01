//
//  ColorModel.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 27.04.2024.
//

import Foundation
import UIKit

protocol ColorModel {
    var labelsColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var backgroundCellColor: UIColor { get }
    var backgroundCustomViewColor: UIColor { get }
    var buttonsColor: UIColor { get }
    var backgroundTabBar: UIColor { get }
    var textFieldBackgroundColor: UIColor { get }
    var infoViewColor: UIColor { get }
    var infoViewLabelColor: UIColor { get }
    var placeholderTextColor: UIColor { get }
}
