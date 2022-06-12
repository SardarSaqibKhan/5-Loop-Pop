/*
 
 Created by TapTapStudio (Alice Vinnik).
 Copyright ©2020 TapTapStudio. All rights reserved.

 ▀▀█▀▀ ░█▀▀█ ▒█▀▀█ ▀▀█▀▀ ░█▀▀█ ▒█▀▀█
 ░▒█░░ ▒█▄▄█ ▒█▄▄█ ░▒█░░ ▒█▄▄█ ▒█▄▄█
 ░▒█░░ ▒█░▒█ ▒█░░░ ░▒█░░ ▒█░▒█ ▒█░░░

 ▒█▀▀▀█ ▀▀█▀▀ ▒█░▒█ ▒█▀▀▄ ▀█▀ ▒█▀▀▀█
 ░▀▀▀▄▄ ░▒█░░ ▒█░▒█ ▒█░▒█ ▒█░ ▒█░░▒█
 ▒█▄▄▄█ ░▒█░░ ░▀▄▄▀ ▒█▄▄▀ ▄█▄ ▒█▄▄▄█
 
 If you want reskin write me.
 Here you can see reskin examples 🌅: https://alicevinnik.wixsite.com/taptapstudio
 Subscribe to my instagram 📷: https://www.instagram.com/taptap_studio/
 Write to my mail 💌: taptap.main@gmail.com
 
*/

extension GameViewController {
    /** Call this for create notifications.*/
    func sendNotifications() {
        if UserDefaults.standard.bool(forKey: "NotificationOn") {
            if #available(iOS 10.0, *) {
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            }
            else {
                UIApplication.shared.cancelAllLocalNotifications()
            }
            
            /// Remember after 2 hours
            sendRandomNotification(fromArrayWithText: [NSLocalizedString("notification_2hours_Type1", comment: ""), NSLocalizedString("notification_2hours_Type2", comment: ""),
                                                       NSLocalizedString("notification_2hours_Type3", comment: ""), NSLocalizedString("notification_2hours_Type4", comment: "")],
                                   showAfterSeconds: 7200)
            /// Remember after 6 hours
            sendRandomNotification(fromArrayWithText: [NSLocalizedString("notification_6hours_Type1", comment: ""), NSLocalizedString("notification_6hours_Type2", comment: ""),
                                                       NSLocalizedString("notification_6hours_Type3", comment: ""), NSLocalizedString("notification_6hours_Type4", comment: "")],
                                   showAfterSeconds: 21600)
            /// Remember after 22 hours
            sendRandomNotification(fromArrayWithText: [NSLocalizedString("notification_22hours_Type1", comment: ""), NSLocalizedString("notification_22hours_Type2", comment: ""),
                                                       NSLocalizedString("notification_22hours_Type3", comment: "")],
                                   showAfterSeconds: 79200)
            /// Remember after 1 week
            sendNotification(withText: NSLocalizedString("notification_1week", comment: ""), showAfterSeconds: 604800)
        }
    }
    
    fileprivate func sendRandomNotification(fromArrayWithText arrayWithText: [String], showAfterSeconds timeToShow: Double) {
        let randomText = arrayWithText[Int(from: 0, to: arrayWithText.count - 1)]
        sendNotification(withText: randomText, showAfterSeconds: timeToShow)
    }
    
    fileprivate func sendNotification(withText text: String, showAfterSeconds timeToShow: Double) {
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.body = text
            content.categoryIdentifier = "alarm"
            content.userInfo = ["customData": "fizzbuzz"]
            content.sound = UNNotificationSound.default
            
            let nextTriggerDate = Calendar.current.date(byAdding: .second, value: Int(timeToShow), to: Date())!
            let dateComponent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: nextTriggerDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
            
            let request = UNNotificationRequest(identifier: "n" + String(timeToShow), content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        else {
            let notification = UILocalNotification()
            notification.fireDate = Date(timeIntervalSinceNow: timeToShow)
            notification.alertBody = text
            notification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.shared.scheduleLocalNotification(notification)
        }
    }
    
    /** Call this for change calling notification settings.*/
    @objc func changeNotificationState() {
        UserDefaults.standard.set(!UserDefaults.standard.bool(forKey: "NotificationOn"), forKey: "NotificationOn")
        
        if UserDefaults.standard.bool(forKey: "NotificationOn") { sendNotifications()}
        else {
            if #available(iOS 10.0, *) {
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            }
            else {
                UIApplication.shared.cancelAllLocalNotifications()
            }
        }
    }
}
