//
//  MainScreen.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 05.12.2022.
//

import UIKit
import RealmSwift
import LocalAuthentication
import UserNotifications

class MainViewController: UIViewController {
    
    var commonView = CommonView()
    var viewModel = MainViewModel()
    var dataManager = DataManager()
    var setColors = SetColors()
    let notifications = Notifications()
    var networkManager = NetworkManager()
    var currency = Currency()
    
    //Settings state
    static var faceTouchId = false
    static var roundResult = false
    static var mainCurrency = ""
    
    // тут треба зберігати останні значення в user defaults
    static var uah = ""
    static var eur = ""
    static var chf = ""
    static var gbp = ""
    static var pln = ""
    static var aud = ""
    static var sek = ""
    static var jpy = ""
    static var kwd = ""
    
    
    //MARK: - View controller lifecycle
    override func loadView() {
        view = commonView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.authenticate(viewController: self,
                               blurView: commonView.blurView,
                               navigationController: self.navigationController!)
        
        notifications.getNotification(type: "Local Notification")
        setupView()
        //loadCurrency()
        currency.loadCurrency {
            self.getDebtorsInfo()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setColors.navigationControllerColorSettings(self)
        commonView.mainTableView.reloadData()
        commonView.colorSettings()
        navigationController?.navigationBar.barStyle = UserDefaults.standard.bool(forKey: "LightTheme") ? .black : .default
    }
    
    
    private func setupView() {
        commonView.commonViewDelegate = self
        commonView.mainTableView.showEditDataDelegate = self
        commonView.mainTableView.editDataDelegate = self
        viewModel.addToLastOperationsArray()
        // commonView.mainTableView.sortedArray = viewModel.array
        viewModel.sumLabelsInfo { yourDebt, debtor in
            self.commonView.infoView.youDebtLabel.text = yourDebt
            self.commonView.infoView.debtLabel.text = debtor
        }
        commonView.mainTableView.reloadData()
    }
    
    
    private func getDebtorsInfo() {
        DispatchQueue.main.async {
            self.viewModel.sumLabelsInfo { yourDebt, debtor in
                self.commonView.infoView.youDebtLabel.text = yourDebt
                self.commonView.infoView.debtLabel.text = debtor
            }
        }
    }
}
