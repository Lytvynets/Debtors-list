//
//  DebtorsList.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 05.12.2022.
//

import UIKit
import RealmSwift

class DebtorsList: UITableViewController, EditDataDelegate {
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    
    var customizeСells = CustomizeСells()
    var dataCells = DataCells()
    var dataManager = DataManager()
    var completionAllSum: ((Int) -> ())?
    var setColors = SetColors()
    let screenSize: CGRect = UIScreen.main.bounds
    
    
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
        //customizeСells.fontSettingsCell(cell, view: view)
        customizeСells.fontSettingsCell(cell, screenSize: CGFloat(screenSize.height))
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
    
    
    // Edit cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let debtors = dataManager.debtorsArray[indexPath.row]
        let edidDataScreen = EdidDataScreen()
        edidDataScreen.editDataDelegate = self
        let navCon = UINavigationController(rootViewController: edidDataScreen)
        edidDataScreen.currency = debtors.currency
        edidDataScreen.sumLabel.text = "\(debtors.sum) \(debtors.currency)"
        edidDataScreen.sum = debtors.sum
        edidDataScreen.name = debtors.name
        edidDataScreen.indexOfItem = indexPath.row
        present(navCon, animated: true)
        print(" name: \(debtors.name) \n sum: \(debtors.sum) \n currency: \(debtors.currency)")
    }
    
    
    //MARK: Action button
    @objc func addTapped() {
        let vc = AddNewDebt(state: false)
        navigationController?.pushViewController(vc, animated: true)
    }
}
