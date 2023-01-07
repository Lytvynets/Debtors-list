//
//  DebtList.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 05.12.2022.
//

import UIKit
import RealmSwift

class DebtList: UITableViewController {
    
    var customizeСells = CustomizeСells()
    var dataCell = DataCells()
    var completionYouAllSum: ((Int) -> ())?
    var dataManager = DataManager()
    var setColors = SetColors()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = SetColors.currentColor.backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DebtorCell.self, forCellReuseIdentifier: "DebtCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        let realm = try! Realm()
        dataManager.youDebtArray = realm.objects(YourDebtModel.self)
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
    
    
    //MARK: - Work with table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.youDebtArray?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DebtCell", for: indexPath) as! DebtorCell
        let debtors = dataManager.youDebtArray[indexPath.row]
        customizeСells.settingsDebtorsCell(cell, .red)
        dataCell.debtorInfo(cell, indexPath, debtors)
        customizeСells.fontSettingsCell(cell, view: view)
        customizeСells.colorSumLabel(debtors, cell)
        return cell
    }
    
    
    // Delete Cells
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == UITableViewCell.EditingStyle.delete else { return }
        let debtors = dataManager.youDebtArray[indexPath.row]
        dataManager.deleteYouDebtFromRealm(debtor: debtors, tableView: tableView)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 12
    }
    

    //MARK: - Action bitton
    @objc func addTapped() {
        let vc = AddNewDebt(state: true)
        navigationController?.pushViewController(vc, animated: true)
    }
}
