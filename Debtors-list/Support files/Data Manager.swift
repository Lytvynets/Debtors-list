//
//  Data Manager.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 18.03.2022.
//

import Foundation
import RealmSwift

class DataManager {
    
    var realm = try! Realm()
    var debtorsArray: Results<Debtor>!
    
    
    func saveToRealm3(debtor: Debtor){
        try! realm.write{
            realm.add(debtor)
        }
    }
    
    
    func deleteFromRealm(debtor: Debtor, tableView: UITableView?){
        try! realm.write{
            realm.delete(debtor)
            tableView?.reloadData()
        }
    }
}
