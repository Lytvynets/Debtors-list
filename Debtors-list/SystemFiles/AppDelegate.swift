//
//  AppDelegate.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 17.03.2022.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var dataManager = DataManager()
    let notifications = Notifications()
    var networkManager = NetworkManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if UserDefaults.standard.object(forKey: "LightTheme") != nil {
            SetColors.currentColor = UserDefaults.standard.bool(forKey: "LightTheme") ? DarkTheme() : LightTheme()
        }
        if UserDefaults.standard.object(forKey: "idIsOn") != nil {
            MainScreen.faceTouchId = UserDefaults.standard.bool(forKey: "idIsOn") ? true : false
        }
        
        if UserDefaults.standard.object(forKey: "Round") != nil {
            MainScreen.roundResult = UserDefaults.standard.bool(forKey: "Round") ? true : false
        }
        
        if UserDefaults.standard.object(forKey: "Hours") != nil {
            Notifications.hours = UserDefaults.standard.integer(forKey: "Hours")
        }
        
        if UserDefaults.standard.object(forKey: "Minutes") != nil {
            Notifications.minutes = UserDefaults.standard.integer(forKey: "Minutes")
        }
        
        if UserDefaults.standard.object(forKey: "WeekDay") != nil {
            Notifications.weekDay = UserDefaults.standard.integer(forKey: "WeekDay")
        }
        
        requestNotification()
        notifications.notificationsCenter.delegate = notifications
        testApp()
        return true
    }
    
    
    func requestNotification(){
        notifications.notificationsCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard granted else { return }
            
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        notifications.notificationsCenter.getNotificationSettings { settings in
            // print("\(settings)")
        }
    }
    
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
    
    
    
    func testApp() {
        let realm = try! Realm()
        dataManager.debtorsArray = realm.objects(Debtors.self)
        dataManager.youDebtArray = realm.objects(YourDebtModel.self)
        
        
        for i in dataManager.youDebtArray {
            switch i.currency {
            case "UAH":
                networkManager.getRequest("USD", "UAH") { data in
                    print("Currency rate UAH: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainScreen.uah = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "EUR":
                networkManager.getRequest("USD", "EUR") { data in
                    print("Currency rate EUR: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainScreen.eur = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "CHF":
                networkManager.getRequest("USD", "CHF") { data in
                    print("Currency rate CHF: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainScreen.chf = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "GBP":
                networkManager.getRequest("USD", "GBP") { data in
                    print("Currency rate GBP: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainScreen.gbp = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "PLN":
                networkManager.getRequest("USD", "PLN") { data in
                    print("Currency rate PLN: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainScreen.pln = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "AUD":
                networkManager.getRequest("USD", "AUD") { data in
                    print("Currency rate AUD: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainScreen.aud = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "SEK":
                networkManager.getRequest("USD", "SEK") { data in
                    print("Currency rate SEK: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainScreen.sek = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "JPY":
                networkManager.getRequest("USD", "JPY") { data in
                    print("Currency rate JPY: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainScreen.jpy = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "KWD":
                networkManager.getRequest("USD", "KWD") { data in
                    print("Currency rate KWD: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainScreen.kwd = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            default:
                print("Def")
            }
        }
        
        
        for i in  dataManager.debtorsArray {
            switch i.currency {
            case "UAH":
                networkManager.getRequest("USD", "UAH") { data in
                    print("Currency rate UAH: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainScreen.uah = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "EUR":
                networkManager.getRequest("USD", "EUR") { data in
                    print("Currency rate EUR: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainScreen.eur = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "CHF":
                networkManager.getRequest("USD", "CHF") { data in
                    print("Currency rate CHF: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainScreen.chf = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "GBP":
                networkManager.getRequest("USD", "GBP") { data in
                    print("Currency rate GBP: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainScreen.gbp = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "PLN":
                networkManager.getRequest("USD", "PLN") { data in
                    print("Currency rate PLN: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainScreen.pln = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "AUD":
                networkManager.getRequest("USD", "AUD") { data in
                    print("Currency rate AUD: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainScreen.aud = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "SEK":
                networkManager.getRequest("USD", "SEK") { data in
                    print("Currency rate SEK: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainScreen.sek = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "JPY":
                networkManager.getRequest("USD", "JPY") { data in
                    print("Currency rate JPY: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainScreen.jpy = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            case "KWD":
                networkManager.getRequest("USD", "KWD") { data in
                    print("Currency rate KWD: \(data.realtimeCurrencyExchangeRate.the5ExchangeRate)")
                    MainScreen.kwd = data.realtimeCurrencyExchangeRate.the5ExchangeRate
                }
            default:
                print("Def2")
            }
        }
    }
}
