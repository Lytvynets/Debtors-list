//
//  Model.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 18.03.2022.
//

import Foundation
import RealmSwift

class Debtors: Object {
    @objc dynamic var name = ""
    @objc dynamic var lastName = ""
    @objc dynamic var sum = 0
    @objc dynamic var currency = ""
     
    convenience init(name: String, lastName: String, sum: Int, currency: String) {
        self.init()
        self.name = name
        self.lastName = lastName
        self.sum = sum
        self.currency = currency
    }
}
