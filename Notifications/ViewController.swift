//
//  ViewController.swift
//  Notifications
//
//  Created by Руслан Акберов on 19.11.2017.
//  Copyright © 2017 Ruslan Akberov. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Notification access granted")
            } else {
                print(error?.localizedDescription ?? "Error")
            }
        }
    }
    
    @IBAction func notifyButtonPressed(_ sender: UIButton) {
        sheduleNotification(inSeconds: 5) { success in
            if success {
                print("Success notification!")
            } else {
                print("Error in notifications!")
            }
        }
    }
    
    func sheduleNotification(inSeconds: TimeInterval, complition: @escaping (_ success: Bool) -> ()) {
        //Add an attachment
        guard let imageURL = Bundle.main.url(forResource: "johny", withExtension: "gif") else {
            complition(false)
            return
        }
        let attachment = try! UNNotificationAttachment(identifier: "myNotif", url: imageURL, options: .none)
        let notif = UNMutableNotificationContent()
        // Only for extension
        notif.categoryIdentifier = "myNotificationCategory"
        
        notif.title = "New Notification"
        notif.subtitle = "Good News!"
        notif.body = "Notification is recivied. That is awesome! Let's try to do something new."
        notif.sound = UNNotificationSound.default()
        notif.attachments = [attachment]
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        let request = UNNotificationRequest(identifier: "myNotif", content: notif, trigger: notifTrigger)
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                print(error.debugDescription)
                complition(false)
            } else {
                complition(true)
            }
        }
    }
    

}









