//
//  NotificationsSettings.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 02.01.2023.
//

import UIKit
import Foundation

class NotificationsSettings: UIViewController {
    
    var not = Notifications()
    var setColors = SetColors()
    var timeLabel = LabelBuilder(fontSize: 18, startText: "Time", color: SetColors.currentColor.labelsColor)
    
    lazy var mondayButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Mon.", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .gray
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(returnMonday), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func returnMonday() {
        Notifications.weekDay = 2
        changeColorButtons()
        not.getNotification(type: "Local notification")
    }
    
    lazy var tuesdayButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Tue.", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .gray
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(returnTuesday), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func returnTuesday() {
        Notifications.weekDay = 3
        changeColorButtons()
        not.getNotification(type: "Local notification")
    }
    
    
    lazy var wednesdayButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Wed.", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .gray
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(returnWednesday), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func returnWednesday() {
        Notifications.weekDay = 4
        changeColorButtons()
        not.getNotification(type: "Local notification")
    }
    
    lazy var thursdayButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Thu.", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .gray
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(returnThursday), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func returnThursday() {
        Notifications.weekDay = 5
        changeColorButtons()
        not.getNotification(type: "Local notification")
    }
    
    lazy var fridayButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Fri.", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .gray
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(returnFriday), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func returnFriday() {
        Notifications.weekDay = 6
        changeColorButtons()
        not.getNotification(type: "Local notification")
    }
    
    lazy var saturdayButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Sat.", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .gray
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(returnSaturday), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func returnSaturday() {
        Notifications.weekDay = 7
        changeColorButtons()
        not.getNotification(type: "Local notification")
    }
    
    lazy var sundayButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Sun.", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(returnSunday), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func returnSunday() {
        Notifications.weekDay = 1
        changeColorButtons()
        not.getNotification(type: "Local notification")
    }
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.timeZone = NSTimeZone.local
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "en_GB")
        datePicker.backgroundColor = UIColor.white
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return datePicker
    }()
    
    
    lazy var weekdayStackView = StackViewBuilder(space: 5, type: .center, axisType: .horizontal, fillType: .fillEqually)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = SetColors.currentColor.backgroundColor
        view.addSubview(weekdayStackView)
        view.addSubview(datePicker)
        view.addSubview(timeLabel)
        navigationItem.title = "Notifications"
        weekdayStackView.addArrangedSubview(mondayButton)
        weekdayStackView.addArrangedSubview(tuesdayButton)
        weekdayStackView.addArrangedSubview(wednesdayButton)
        weekdayStackView.addArrangedSubview(thursdayButton)
        weekdayStackView.addArrangedSubview(fridayButton)
        weekdayStackView.addArrangedSubview(saturdayButton)
        weekdayStackView.addArrangedSubview(sundayButton)
        weekdayLayout()
        setColors.navigationControllerColorSettings(self)
        setColors.backButtonSettings(self)
        datePicker.date = UserDefaults.standard.object(forKey: "saveDate") as? Date ?? Date.now
        
       
        changeColorButtons()
        
    }
    
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        let dateFormatterHours: DateFormatter = DateFormatter()
        let dateFormatterMinutes: DateFormatter = DateFormatter()
        dateFormatterHours.dateFormat = "HH"
        dateFormatterMinutes.dateFormat = "mm"
        
        let hoursSelect = dateFormatterHours.string(from: sender.date)
        let minutesSelect = dateFormatterMinutes.string(from: sender.date)
        
        Notifications.hours = Int(hoursSelect) ?? 0
        Notifications.minutes = Int(minutesSelect) ?? 0
        
        print("hours \(Notifications.hours)")
        print("minutes \(Notifications.minutes)")
        print("day \(Notifications.weekDay)")
        UserDefaults.standard.set(sender.date, forKey: "saveDate")
        not.getNotification(type: "Local notification")
    }
    
    
    func changeColorButtons() {
       if Notifications.weekDay == 1 {
           sundayButton.backgroundColor = .orange
        } else {
            sundayButton.backgroundColor = .gray
        }
        
        if Notifications.weekDay == 2 {
            mondayButton.backgroundColor = .orange
         } else {
             mondayButton.backgroundColor = .gray
         }
        
        if Notifications.weekDay == 3 {
            tuesdayButton.backgroundColor = .orange
         } else {
             tuesdayButton.backgroundColor = .gray
         }
        
        if Notifications.weekDay == 4 {
            wednesdayButton.backgroundColor = .orange
         } else {
             wednesdayButton.backgroundColor = .gray
         }
        
        if Notifications.weekDay == 5 {
            thursdayButton.backgroundColor = .orange
         } else {
             thursdayButton.backgroundColor = .gray
         }
        
        if Notifications.weekDay == 6 {
            fridayButton.backgroundColor = .orange
         } else {
             fridayButton.backgroundColor = .gray
         }
        
        if Notifications.weekDay == 7 {
            saturdayButton.backgroundColor = .orange
         } else {
             saturdayButton.backgroundColor = .gray
         }
    }
    
    func weekdayLayout() {
        NSLayoutConstraint.activate([
            weekdayStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            weekdayStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weekdayStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            weekdayStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            datePicker.topAnchor.constraint(equalTo: weekdayStackView.bottomAnchor, constant: 25),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            timeLabel.centerYAnchor.constraint(equalTo: datePicker.centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
        ])
    }
}
