//
//  SecondTableViewController.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 18.03.2022.
//

import UIKit
import RealmSwift
var youAllSumProfile = 0

class YourDebtListTableVC: UITableViewController {
    
    var completionYouAllSum: ((Int) -> ())?
    var dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorInset = .init(top: 0, left: 23, bottom: 0, right: 25)
        self.tableView.separatorColor = .lightGray
        self.tableView.tableFooterView = UIView()
        self.navigationItem.backBarButtonItem?.tintColor = .label
        let realm = try! Realm()
        dataManager.youDebtArray = realm.objects(YourDebtModel.self)
        self.tableView.reloadData()
        self.completionYouAllSum?(youAllSumProfile)
        for i in dataManager.youDebtArray{
            let sum = i.sum
            youAllSumProfile += sum
        }
    }
    
    //MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.youDebtArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Keys.yourDebtCellIdentifier.rawValue, for: indexPath) as! YouDebtTableViewCell
        let debtors = dataManager.youDebtArray[indexPath.row]
        cell.youOweNumberLabel.text = ("\(indexPath.row + 1)")
        cell.set(youDebtorArray: debtors)
        return cell
    }
    
    // MARK: - Work with Segue
    @IBAction func yourDebtUnwindSegue (_ segue: UIStoryboardSegue){
        guard segue.identifier == Keys.yourDebtUnwindSegueIdentifier.rawValue else { return }
        let segue = segue.source as! YourNewDebtVC
        let newDebtor = segue.yourNewDebt
        dataManager.saveYouDebtToRealm(debtor: newDebtor, tableView: tableView)
    }
    
    // MARK: - Delete Cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == UITableViewCell.EditingStyle.delete else { return }
        let debtors = dataManager.youDebtArray[indexPath.row] 
        dataManager.deleteYouDebtFromRealm(debtor: debtors, tableView: tableView)
    }
}
