//
//  MainTableView.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 05.12.2022.
//

import UIKit

//extension MainScreen: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return sortedArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! DebtorCell
//        customizeСells.settingsDebtorsCell(cell, .green)
//        let array = sortedArray[indexPath.row]
//        dataCells.debtorInfo(cell, indexPath, array)
//        customizeСells.fontSettingsCell(cell, view: view)
//        customizeСells.colorSumLabel(array, cell)
//        return cell
//    }
//
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return view.frame.height / 12
//    }
//}



class MainTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var customizeСells = CustomizeСells()
    var sortedArray = [Debtor]()
    var dataCells = DataCells()
    let screenSize: CGRect = UIScreen.main.bounds
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        dataSource = self
        delegate = self
        translatesAutoresizingMaskIntoConstraints = false
        register(DebtorCell.self, forCellReuseIdentifier: "TableViewCell")
        layer.cornerRadius = 15
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! DebtorCell
        customizeСells.settingsDebtorsCell(cell, .green)
        let array = sortedArray[indexPath.row]
        dataCells.debtorInfo(cell, indexPath, array)
        // customizeСells.fontSettingsCell(cell, view: view)
        customizeСells.fontSettingsCell(cell, screenSize: CGFloat(screenSize.height))
        customizeСells.colorSumLabel(array, cell)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenSize.height / 12  //40 //view.frame.height / 12
    }
}
