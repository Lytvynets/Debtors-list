//
//  MainTableView.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 05.12.2022.
//

import UIKit

extension MainScreen: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! DebtorCell
        customizeСells.settingsDebtorsCell(cell, .green)
        let array = sortedArray[indexPath.row]
        dataCells.debtorInfo(cell, indexPath, array)
        customizeСells.fontSettingsCell(cell, view: view)
        customizeСells.colorSumLabel(array, cell)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 12
    }
}
