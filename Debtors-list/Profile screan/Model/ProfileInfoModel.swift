//
//  Profile settings.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 18.03.2022.
//

import Foundation
import RealmSwift

class ProfileInfoModel: Object {
    @objc dynamic var profileName: String?
    @objc dynamic var profileLastName: String?
    @objc dynamic var imageData: Data?
    
    convenience init(imageData: Data) {
        self.init()
        self.imageData = imageData
    }
    
    convenience  init(name: String) {
        self.init()
        self.profileName = name
    }
     
    convenience  init(lastName: String) {
        self.init()
        self.profileLastName = lastName
    }
}
