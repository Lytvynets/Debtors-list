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
    var youDebtArray: Results<YourDebtModel>!
    var debtorsArray: Results<Debtors>!
    
    func saveYouDebtToRealm(debtor: YourDebtModel, tableView: UITableView){
        try! realm.write{
            realm.add(debtor)
            tableView.reloadData()
        }
    }
    
    
    func deleteYouDebtFromRealm(debtor: YourDebtModel, tableView: UITableView){
        try! realm.write{
            realm.delete(debtor)
            tableView.reloadData()
        }
    }
    
    
    func saveToRealm(debtor: Debtors, tableView: UITableView){
        try! realm.write{
            realm.add(debtor)
            tableView.reloadData()
        }
    }
    
    
    func deleteFromRealm(debtor: Debtors, tableView: UITableView){
        try! realm.write{
            realm.delete(debtor)
            tableView.reloadData()
        }
    }
}
