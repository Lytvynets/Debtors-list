//
//  Model.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 18.03.2022.
//

import Foundation
import RealmSwift

class Debtors: Object, Debtor {
    
    @objc dynamic var name = ""
    @objc dynamic var lastName = ""
    @objc dynamic var sum = 0.0
    @objc dynamic var currency = ""
    @objc dynamic var date = ""
    
    convenience init(name: String, lastName: String, sum: Double, currency: String, date: String) {
        self.init()
        self.name = name
        self.lastName = lastName
        self.sum = sum
        self.currency = currency
        self.date = date
    }
}
