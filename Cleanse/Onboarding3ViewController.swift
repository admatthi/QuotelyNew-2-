//
//  Onboarding3ViewController.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 4/21/20.
//  Copyright © 2020 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
import FirebaseMessaging
import UserNotifications
import FBSDKCoreKit

class Onboarding3ViewController: UIViewController, UNUserNotificationCenterDelegate {

   func logNotificationsSettings(referrer : String) {
                                  AppEvents.logEvent(AppEvents.Name(rawValue: "notifications enabled"), parameters: ["test" : "test"])
                              }
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let center = UNUserNotificationCenter.current()
                 center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                         if granted {
                             DispatchQueue.main.async(execute: {
                                 UIApplication.shared.registerForRemoteNotifications()
                              self.logNotificationsSettings(referrer: "true")

                                self.performSegue(withIdentifier: "OnboardingToPaywall", sender: self)
                             })
                         } else {
                               DispatchQueue.main.async(execute: {
                                                      UIApplication.shared.registerForRemoteNotifications()
                                                   self.logNotificationsSettings(referrer: "false")

                                                     self.performSegue(withIdentifier: "OnboardingToPaywall", sender: self)
                                                  })

                    }
                     }
            
            UNUserNotificationCenter.current().getNotificationSettings(){ (settings) in

                     switch settings.soundSetting{
                     case .enabled:

                         self.logNotificationsSettings(referrer: "true")

                     case .disabled:

                         self.logNotificationsSettings(referrer: "false")

                     case .notSupported:
                         
                        self.logNotificationsSettings(referrer: "error")

                         print("something vital went wrong here")
                     }
                 }
            
            
            referrer = "Onboarding"

            logScreenView(referrer: "onboarding3")

            // Do any additional setup after loading the view.
        }
        
        func logScreenView(referrer : String) {
                                        AppEvents.logEvent(AppEvents.Name(rawValue: "Onboarding3"), parameters: ["" : ""])
                                    }
        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */

    }
