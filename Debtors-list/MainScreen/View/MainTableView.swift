//
//  MainTableView.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 05.12.2022.
//

import UIKit
import RealmSwift

enum filterTableView {
    case showAll
    case showGiven
    case showTaken
}


class MainTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    let realm = try! Realm()
    var editDataDelegate: EditDataDelegate?
    var dataManager = DataManager()
    var customizeСells = CustomizeСells()
    var sortedArray = [Debtor]()
    let screenSize: CGRect = UIScreen.main.bounds
    var showEditDataDelegate: ShowEditDataDelegate?
    var filterTableView: filterTableView = .showAll
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        dataSource = self
        delegate = self
        translatesAutoresizingMaskIntoConstraints = false
        register(DebtorCell.self, forCellReuseIdentifier: "TableViewCell")
        separatorColor = .darkGray
        separatorStyle = .singleLine
        dataManager.debtorsArray = realm.objects(Debtor.self)
        addData()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedArray.count //dataManager.debtorsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! DebtorCell
        customizeСells.settingsDebtorsCell(cell, .green)
        let array = sortedArray[indexPath.row] //dataManager.debtorsArray[indexPath.row]
        cell.firstNameLabel.text = array.name
        cell.secondNameLabel.text = array.lastName
        cell.dateLabel.text = array.date
        cell.currencyLabel.text = array.currency
        cell.givenDebt = array.givenDebt
        
        if cell.givenDebt == true {
            cell.sumOfDebtLabel.text = "\(array.sum)"
            cell.sumOfDebtLabel.textColor = .green
        }else {
            cell.sumOfDebtLabel.text = "-\(array.sum)"
            cell.sumOfDebtLabel.textColor = .red
        }
        customizeСells.fontSettingsCell(cell, screenSize: CGFloat(screenSize.height))
        return cell
    }
    
    
    // Delete Cells
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == UITableViewCell.EditingStyle.delete else { return }
        // let debtors = dataManager.debtorsArray[indexPath.row]
        let debtors = sortedArray[indexPath.row]
        dataManager.deleteFromRealm(debtor: debtors, tableView: tableView)
        self.editDataDelegate?.reloadTableView()
    }
    
    
    // Edit cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let debtors = dataManager.debtorsArray[indexPath.row]
        let editDataScreen = EditDataViewController()
        editDataScreen.editDataDelegate = self
        let navCon = UINavigationController(rootViewController: editDataScreen)
        editDataScreen.currency = debtors.currency ?? ""
        editDataScreen.sumLabel.text = "\(debtors.sum) \(String(describing: debtors.currency ?? ""))"
        editDataScreen.sum = debtors.sum
        editDataScreen.name = debtors.name ?? ""
        editDataScreen.lastName = debtors.lastName ?? ""
        editDataScreen.indexOfItem = indexPath.row
        editDataScreen.typeOfDebr = debtors.givenDebt
        showEditDataDelegate?.showEditScreen(vc: navCon)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenSize.height / 12
    }
    
    
    func addData(){
        sortedArray.removeAll()
        switch filterTableView {
        case .showAll:
            for i in dataManager.debtorsArray {
                sortedArray.append(i)
                reloadData()
            }
            
        case .showGiven:
            for i in dataManager.debtorsArray {
                if i.givenDebt == true {
                    sortedArray.append(i)
                    reloadData()
                }
            }
            
        case .showTaken:
            for i in dataManager.debtorsArray {
                if i.givenDebt == false {
                    sortedArray.append(i)
                    reloadData()
                }
            }
        }
    }
}


extension MainTableView: EditDataDelegate {
    func reloadTableView() {
        editDataDelegate?.reloadTableView()
    }
}
