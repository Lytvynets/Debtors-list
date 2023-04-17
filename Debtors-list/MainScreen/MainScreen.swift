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

class MainScreen: UIViewController {
    
    var networkManager = NetworkManager()
    var currency = Currency2()
    var customizeСells = CustomizeСells()
    var dataCells = DataCells()
    var dataManager = DataManager()
    var array = [Debtor]()
    var sortedArray = [Debtor]()
    var setColors = SetColors()
    let notifications = Notifications()
    
    
    //Settings state
    static var faceTouchId = false
    static var roundResult = false
    static var mainCurrency = ""
    
    static var uah = ""
    static var eur = ""
    static var chf = ""
    static var gbp = ""
    static var pln = ""
    static var aud = ""
    static var sek = ""
    static var jpy = ""
    static var kwd = ""
    
    lazy var debtLabel = LabelBuilder(fontSize: 25, startText: "0$", color: .green)
    lazy var youDebtLabel = LabelBuilder(fontSize: 25, startText: "0$", color: .red)
    lazy var markDebtLabel = LabelBuilder(fontSize: 15, startText: "Given", color: nil)
    lazy var markYouDebtLabel = LabelBuilder(fontSize: 15, startText: "Taken", color: nil)
    lazy var debtStackView = StackViewBuilder(space: 3, type: .center, axisType: .vertical, fillType: .fill)
    lazy var youDebtStackView = StackViewBuilder(space: 3, type: .center, axisType: .vertical, fillType: .fill)
    
    
    let mainTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    lazy var infoView: UIView = {
        let infoView = UIView()
        infoView.layer.cornerRadius = 20
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    
    //MARK: - View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupRealm()
        tableViewSettings()
        setConstraints()
        fontSettings()
        setupStackView()
        authenticate()
        notifications.getNotification(type: "Local Notification")
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        array.removeAll()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setColors.navigationControllerColorSettings(self)
        navigationController?.navigationBar.barStyle = UserDefaults.standard.bool(forKey: "LightTheme") ? .black : .default
        addToLastOperationsArray()
        sortedArrayByDate()
        sumLabelsInfo()
        colorSettings()
        mainTableView.reloadData()
    }
    
    
    private func sumLabelsInfo() {
        var debtSum: Double = 0.0
        var debtorsSum: Double = 0.0
        self.currency.convertCurrency(&debtSum, &debtorsSum)
        if MainScreen.roundResult == false {
            self.youDebtLabel.text = "-\((NSString(format:"%.2f", debtSum)))$"
            self.debtLabel.text = "\((NSString(format:"%.2f", debtorsSum)))$"
        } else {
            self.youDebtLabel.text = "-\(Int(debtSum))$"
            self.debtLabel.text = "\(Int(debtorsSum))$"
        }
    }
    
    
    private func sortedArrayByDate() {
        let sortArray = array.sorted { firstArray, secondArray in
            firstArray.date > secondArray.date
        }
        sortedArray = sortArray
    }
    
    
    private func setupRealm() {
        let realm = try! Realm()
        dataManager.debtorsArray = realm.objects(Debtors.self)
        dataManager.youDebtArray = realm.objects(YourDebtModel.self)
    }
    
    
    private func addToLastOperationsArray() {
        for i in dataManager.debtorsArray {
            array.append(i)
        }
        for i in  dataManager.youDebtArray {
            array.append(i)
        }
    }
    
    
    private func tableViewSettings() {
        mainTableView.register(DebtorCell.self, forCellReuseIdentifier: "TableViewCell")
        mainTableView.layer.cornerRadius = 15
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    
    
    lazy var blurView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    func authenticate() {
        guard MainScreen.faceTouchId else { return }
        self.blurView.alpha = 1
        self.navigationItem.title = ""
        navigationController?.tabBarController?.tabBar.alpha = 0
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Identify yourself!"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) {
                [weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        print("Blocked")
                        return
                    }
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.5) {
                            self?.blurView.alpha = 0
                            self?.navigationController?.tabBarController?.tabBar.alpha = 1
                            self?.navigationItem.title = "Last operations"
                        }
                    }
                }
            }
        } else {
            self.blurView.alpha = 1
            let ac = UIAlertController(title: "Authentication failed",
                                       message: "You could not be verified; please try again.",
                                       preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK",
                                       style: .default))
            self.present(ac, animated: true)
        }
    }
}
