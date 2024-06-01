//
//  Notifications.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 01.01.2023.
//

import Foundation
import UserNotifications
import RealmSwift

class Notifications: NSObject, UNUserNotificationCenterDelegate {
    
    var currency = Currency()
    let notificationsCenter = UNUserNotificationCenter.current()
    var notificationCenter = NotificationCenter.default
    var badge: NSNumber = 0
    var dataManager = DataManager()
    var debt = ""
    var debtors = ""
    
    
    static var hours = 0 {
        didSet {
            UserDefaults.standard.set(hours, forKey: "Hours")
        }
    }
    
    
    static var minutes = 0 {
        didSet {
            UserDefaults.standard.set(minutes, forKey: "Minutes")
        }
    }
    
    
    static var weekDay = 0 {
        didSet {
            UserDefaults.standard.set(weekDay, forKey: "WeekDay")
        }
    }
    
    
    func getNotification(type: String) {
        
        var debtSum: Double = 0.0
        var debtorsSum: Double = 0.0
        
        currency.convertCurrency(&debtSum, &debtorsSum)
        if MainViewController.roundResult == false {
            self.debt = "-\((NSString(format:"%.2f", debtSum)))$"
            self.debtors = "\((NSString(format:"%.2f", debtorsSum)))$"
        } else {
            self.debt = "-\(Int(debtSum))$"
            self.debtors = "\(Int(debtorsSum))$"
        }
        
        
        let content = UNMutableNotificationContent()
        content.title = "You debts"
        content.body = "Given: \(debtors) \nTaken: \(debt)"
        content.sound = .default
        content.badge = 1
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.weekday = Notifications.weekDay
        dateComponents.hour = Notifications.hours
        dateComponents.minute = Notifications.minutes
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: true)
        
        let id = "Local Notification"
        let request = UNNotificationRequest(identifier: id,
                                            content: content,
                                            trigger: trigger)
        
        notificationsCenter.add(request) { error in
            if error != nil {
                print("Error")
            }
        }
    }
}
