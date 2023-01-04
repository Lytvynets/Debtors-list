//
//  DebtorsList.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 05.12.2022.
//

import UIKit
import RealmSwift

class DebtorsList: UITableViewController {
    
    var customizeСells = CustomizeСells()
    var dataCells = DataCells()
    var dataManager = DataManager()
    var completionAllSum: ((Int) -> ())?
    var setColors = SetColors()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = SetColors.currentColor.backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DebtorCell.self, forCellReuseIdentifier: "DebtorsCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        let realm = try! Realm()
        dataManager.debtorsArray = realm.objects(Debtors.self)
        self.tableView.reloadData()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = UserDefaults.standard.bool(forKey: "LightTheme") ? .black : .default
        tableView.backgroundColor = SetColors.currentColor.backgroundColor
        setColors.navigationControllerColorSettings(self)
        setColors.backButtonSettings(self)
        tableView.reloadData()
    }
    
    
    //MARK: Work with table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.debtorsArray?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DebtorsCell", for: indexPath) as! DebtorCell
        let debtors = dataManager.debtorsArray[indexPath.row]
        dataCells.debtorInfo(cell, indexPath, debtors)
        customizeСells.settingsDebtorsCell(cell, .green)
        customizeСells.fontSettingsCell(cell, view: view)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 12
    }
    
    
    // Delete Cells
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == UITableViewCell.EditingStyle.delete else { return }
        let debtors = dataManager.debtorsArray[indexPath.row]
        dataManager.deleteFromRealm(debtor: debtors, tableView: tableView)
    }
    
    
    //MARK: Action button
    @objc func addTapped() {
        let vc = AddNewDebt(state: false)
        navigationController?.pushViewController(vc, animated: true)
    }
}
