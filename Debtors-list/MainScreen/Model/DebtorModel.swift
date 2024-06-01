//
//  DebtorModel.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 18.03.2022.
//

import Foundation
import RealmSwift

//MARK: - New version
class Debtor: Object {
    @objc dynamic var name: String?
    @objc dynamic var lastName: String?
    @objc dynamic var sum: Double = 0.0
    @objc dynamic var currency: String?
    @objc dynamic var date: String?
    @objc dynamic var givenDebt: Bool = true
}
