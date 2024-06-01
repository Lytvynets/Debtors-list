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
        // GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        if UserDefaults.standard.object(forKey: "LightTheme") != nil {
            SetColors.currentColor = UserDefaults.standard.bool(forKey: "LightTheme") ? DarkTheme() : LightTheme()
        }
        if UserDefaults.standard.object(forKey: "idIsOn") != nil {
            MainViewController.faceTouchId = UserDefaults.standard.bool(forKey: "idIsOn") ? true : false
        }
        
        if UserDefaults.standard.object(forKey: "Round") != nil {
            MainViewController.roundResult = UserDefaults.standard.bool(forKey: "Round") ? true : false
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
}
