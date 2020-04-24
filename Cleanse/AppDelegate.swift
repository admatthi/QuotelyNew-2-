//
//  AppDelegate.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 10/26/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import Kingfisher
import FirebaseDatabase
import FirebaseStorage
import Purchases
import FBSDKCoreKit
import AppsFlyerLib
import FirebaseMessaging

var entereddiscount = String()

var actualdiscount = String()

var monthdate = String()

var dayweek = String()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AppsFlyerTrackerDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    let gcmMessageIDKey = "gcm.message_id"
    
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        print("success")
    }
    
    func onConversionDataFail(_ error: Error) {
        print("\(error)")
        
    }
    
    @objc func sendLaunch(app:Any) {
        AppsFlyerTracker.shared().trackAppLaunch()
    }
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        AppEvents.activateApp()
        
        AppsFlyerTracker.shared().appsFlyerDevKey = "GSfLvX3FDxH58hR3yDZzZe"
        AppsFlyerTracker.shared().appleAppID = "1486018778"
        AppsFlyerTracker.shared().delegate = self
        AppsFlyerTracker.shared().isDebug = true
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(sendLaunch),
                                               // For Swift version < 4.2 replace name argument with the commented out code
            name: UIApplication.didBecomeActiveNotification, //.UIApplicationDidBecomeActive for Swift < 4.2
            object: nil)
        
        
        
        Purchases.debugLogsEnabled = true
        Purchases.configure(withAPIKey: "paCLaBYrGELMfdxuMQqbROxMfgDbcGGn", appUserID: nil)
        
        refer = "On Open"
        
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarBuyer : UITabBarController = mainStoryboardIpad.instantiateViewController(withIdentifier: "HomeTab") as! UITabBarController
        
        uid = UIDevice.current.identifierForVendor?.uuidString ?? "x"
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        var result = dateFormatter.string(from: date)
        
        dateformat = result
        
        monthdate = dateformat
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        result = dateFormatter.string(from: date)
        var weekday = (Date().dayOfWeek()!)
        
        
        dayweek = String(weekday)
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        
        if launchedBefore {
            
     
            
        } else {
            
          let storyboard = UIStoryboard(name: "Main", bundle: nil)

               let initialViewController = storyboard.instantiateViewController(withIdentifier: "Onboarding1")
               
               self.window = UIWindow(frame: UIScreen.main.bounds)
               self.window?.rootViewController = initialViewController
               
               self.window?.makeKeyAndVisible()
                        
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            
        }
        
        queryforpaywall()
        

        
        Messaging.messaging().delegate = self

  

        return true
    }
    
    // [START receive_message]
      func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
          // If you are receiving a notification message while your app is in the background,
          // this callback will not be fired till the user taps on the notification launching the application.
          // TODO: Handle data of notification
          
          // With swizzling disabled you must let Messaging know about the message, for Analytics
          // Messaging.messaging().appDidReceiveMessage(userInfo)
          
          // Print message ID.
          if let messageID = userInfo[gcmMessageIDKey] {
              print("Message ID: \(messageID)")
          }
          
          // Print full message.
          print(userInfo)
      }
      
      func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                       fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
          // If you are receiving a notification message while your app is in the background,
          // this callback will not be fired till the user taps on the notification launching the application.
          // TODO: Handle data of notification
          
          // With swizzling disabled you must let Messaging know about the message, for Analytics
          // Messaging.messaging().appDidReceiveMessage(userInfo)
          
          // Print message ID.
          if let messageID = userInfo[gcmMessageIDKey] {
              print("Message ID: \(messageID)")
          }
          
          // Print full message.
          print(userInfo)
          
          completionHandler(UIBackgroundFetchResult.newData)
      }
      // [END receive_message]
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken:Data) {
        print("did register device token")
    }
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
      print("Firebase registration token: \(fcmToken)")

      let dataDict:[String: String] = ["token": fcmToken]
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        
      if let currentUserUID = UIDevice.current.identifierForVendor?.uuidString {
         let ref = Database.database().reference().child("Users").child(currentUserUID).child("pushToken")
         ref.setValue(fcmToken)
         Database.database().reference().child("pushTokens").updateChildValues([currentUserUID: fcmToken])
      }
        
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func queryforpaywall() {
        
        ref?.child("Users").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            if let slimey = value?["Slimey"] as? String {
                
                slimeybool = true
                
            } else {
                
                slimeybool = false
                
            }
            
            if let discountcode = value?["DiscountCode"] as? String {
                
                actualdiscount = discountcode
                
            } else {
                
                
            }
        })
        
    }
    
    
    
    // MARK: UISceneSession Lifecycle
    
    
    
    
}






