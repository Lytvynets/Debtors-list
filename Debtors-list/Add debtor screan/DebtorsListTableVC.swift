//
//  TableViewController.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 18.03.2022.
//

import RealmSwift
import Foundation
var allSumProfile = 0

class DebtorsListTableVC: UITableViewController {
    
    var dataManager = DataManager()
    var completionAllSum: ((Int) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorInset = .init(top: 0, left: 23, bottom: 0, right: 25)
        self.tableView.separatorColor = .lightGray
        self.tableView.tableFooterView = UIView()
        self.navigationItem.backBarButtonItem?.tintColor = .label
        let realm = try! Realm()
        dataManager.debtorsArray = realm.objects(Debtors.self)
        self.tableView.reloadData()
        self.completionAllSum?(allSumProfile)
        for i in dataManager.debtorsArray {
            let sum = i.sum
            allSumProfile += sum
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.debtorsArray?.count ?? 0 
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Keys.cellIdentifier.rawValue, for: indexPath) as! TableViewCell
        let debtors = dataManager.debtorsArray[indexPath.row]
        cell.set(debtorsArray: debtors)
        cell.numberLabel.text = ("\(indexPath.row + 1)")
        return cell
    }
    
    // MARK: - Work with Segue
    @IBAction func unwindSegue (_ segue: UIStoryboardSegue){
        guard segue.identifier == Keys.unwindSegueIdentifier.rawValue else { return }
        let segue = segue.source as! NewDebtorVC
        let newDebtor = segue.newDebtors
        let realm = try! Realm()
        try! realm.write{
            realm.add(newDebtor)
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Delete Cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == UITableViewCell.EditingStyle.delete else { return }
        let debtors = dataManager.debtorsArray[indexPath.row]
        dataManager.deleteFromRealm(debtor: debtors, tableView: tableView)
    }
}
