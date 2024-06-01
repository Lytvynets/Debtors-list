//
//  MainViewModel.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 27.03.2024.
//

import Foundation
import RealmSwift
import LocalAuthentication

class MainViewModel {
    
    var array: [Debtor] = []
    var dataManager = DataManager()
    var currency = Currency()
    
    
    init() {
        setupRealm()
    }
    
    
    func removeAllData() {
        array.removeAll()
    }
    
    
    func sumLabelsInfo(completion: @escaping (_ yourDebt: String, _ debtor: String) -> ()) {
        var debtSum: Double = 0.0
        var debtorsSum: Double = 0.0
        self.currency.convertCurrency(&debtSum, &debtorsSum)
        if MainViewController.roundResult == false {
            completion("-\((NSString(format:"%.2f", debtSum)))$", "\((NSString(format:"%.2f", debtorsSum)))$")
        } else {
            completion("-\(Int(debtSum))$", "\(Int(debtorsSum))$")
        }
    }
    
    
    private func setupRealm() {
        let realm = try! Realm()
        dataManager.debtorsArray = realm.objects(Debtor.self)
    }
    
    
    func addToLastOperationsArray() {
        for i in dataManager.debtorsArray {
            array.append(i)
        }
    }
    
    
    func authenticate(viewController: UIViewController, blurView: UIView, navigationController: UINavigationController) {
        guard MainViewController.faceTouchId else { return }
        blurView.alpha = 1
        navigationController.navigationItem.title = ""
        navigationController.tabBarController?.tabBar.alpha = 0
        navigationController.navigationController?.tabBarController?.tabBar.alpha = 0
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Identify yourself!"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        print("Blocked")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.5) {
                            blurView.alpha = 0
                            navigationController.tabBarController?.tabBar.alpha = 1
                            navigationController.navigationItem.title = "Last operations"
                        }
                    }
                }
            }
        } else {
            blurView.alpha = 1
            let ac = UIAlertController(title: "Authentication failed",
                                       message: "You could not be verified; please try again.",
                                       preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK",
                                       style: .default))
            viewController.present(ac, animated: true)
        }
    }
}
