//
//  AppDelegate.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//

import Foundation
import UIKit
import UserNotifications

import Firebase
import FirebaseMessaging
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
    
    var app: DAIHYORDER?
    
    
    func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
       
        app = DAIHYORDER()
        FirebaseApp.configure()
        registerForFirebaseNotification(application: application)
        return true
    }
    
    // define FCM
    func registerForFirebaseNotification(application: UIApplication) {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            // For iOS 9 and earlier
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
    }
     
    
}





// MARK: ===================== register push notification ===============================================
extension AppDelegate:  UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
       print("Device Token: \(deviceToken.map { String(format: "%02.2hhx", $0) }.joined())")

       // Pass device token to FCM
       Messaging.messaging().apnsToken = deviceToken
    }


    // Handle notifications received while app is in background or terminated
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo)
        completionHandler(.newData)
     }
    
    // Handle tap on notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse,withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        // Default: no action
        completionHandler()
    }
    
    // Foreground notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        // Default: show banner + sound + badge
        completionHandler([.banner, .sound, .badge])
    }
    
}


extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
       print("Firebase registration token: \(String(describing: fcmToken))")
       let dataDict: [String: String] = ["token": fcmToken ?? ""]
       NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
       // TODO: If necessary send token to application server.
    }
    
}


