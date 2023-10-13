//
//  NotificationManager.swift
//  iOS_Login
//
//  Created by Roman on 13.10.2023.
//

import UserNotifications

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()

    private let notificationCenter = UNUserNotificationCenter.current()

    private override init() { }

    /// Запрашивает разрешение на отправку уведомлений пользователю.
    func requestNotificationAccess() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            guard granted else { return }
            self.notificationCenter.getNotificationSettings { (settings) in
                guard settings.authorizationStatus == .authorized else { return }
            }
        }
        notificationCenter.delegate = self
    }

    /// Отправляет уведомление с указанным заголовком.
    ///
    /// - Parameter title: Заголовок уведомления
    func sendNotification(withTitle title: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: "Notification", content: content, trigger: trigger)
        notificationCenter.add(request) { (error) in
//            print(error?.localizedDescription)
        }
    }

    /// Отображает уведомление внутри приложения.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .banner])
    }

    /// Обрабатывает действия пользователя при нажатии на уведомление.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
    }
}
