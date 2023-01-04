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
    
    let notificationsCenter = UNUserNotificationCenter.current()
    var notificationCenter = NotificationCenter.default
    var dataManager = DataManager()
    
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
    
    
    var debt = ""
    var debtors = ""
    
    
    func getNotification(type: String) {
        let realm = try! Realm()
        dataManager.debtorsArray = realm.objects(Debtors.self)
        dataManager.youDebtArray = realm.objects(YourDebtModel.self)
        var debtSum: Double = 0.0
        var debtorsSum: Double = 0.0
        
        convertCurrency(&debtSum, &debtorsSum)
        if MainScreen.roundResult == false {
            self.debt = "-\((NSString(format:"%.2f", debtSum))) $"
            self.debtors = "\((NSString(format:"%.2f", debtorsSum))) $"
        } else {
            self.debt = "-\(Int(debtSum)) $"
            self.debtors = "\(Int(debtorsSum)) $"
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
                                            content: content, trigger: trigger)
        
        notificationsCenter.add(request) { error in
            if error != nil {
                print("Error")
            }
        }
    }
    
    
    private func convertCurrency(_ debtSum: inout Double, _ debtorsSum: inout Double) {
        for i in dataManager.youDebtArray {
            switch i.currency {
            case "UAH":
                debtSum += i.sum / 36.92
            case "EUR":
                debtSum += i.sum * 1.05
            case "CHF":
                debtSum += i.sum * 1.06
            case "GBP":
                debtSum += i.sum * 1.22
            default:
                debtSum += i.sum
            }
        }
        
        for i in  dataManager.debtorsArray {
            switch i.currency {
            case "UAH":
                debtorsSum += i.sum / 36.92
            case "EUR":
                debtorsSum += i.sum * 1.05
            case "CHF":
                debtorsSum += i.sum * 1.06
            case "GBP":
                debtorsSum += i.sum * 1.22
            default:
                debtorsSum += i.sum
            }
        }
    }
}
