//
//  CustomizeShadows.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 21.12.2022.
//

import Foundation
import UIKit

class CustomizeShadows {
    func makeShadowForOne<T: UIView>(object: T, borderWidth: CGFloat?, borderColor: CGColor?, shadowColor: CGColor, shadowRadius: CGFloat, Opacity: Float) {
        object.layer.borderWidth = borderWidth ?? 0
        object.layer.borderColor = borderColor
        object.layer.masksToBounds = true
        object.layer.shadowColor = shadowColor
        object.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        object.layer.shadowRadius = shadowRadius
        object.layer.shadowOpacity = Opacity
        object.layer.masksToBounds = false
    }
    
    
    func makeShadowForAll<T: UIView>(object: [T], borderWidth: CGFloat?, borderColor: CGColor?, shadowColor: CGColor, shadowRadius: CGFloat, Opacity: Float) {
        for i in object {
            i.layer.borderWidth = borderWidth ?? 0
            i.layer.borderColor = borderColor
            i.layer.masksToBounds = true
            i.layer.shadowColor = shadowColor
            i.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            i.layer.shadowRadius = shadowRadius
            i.layer.shadowOpacity = Opacity
            i.layer.masksToBounds = false
        }
    }
}
