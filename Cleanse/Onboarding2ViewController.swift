//
//  Onboarding2ViewController.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 4/20/20.
//  Copyright © 2020 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FirebaseCore
import Firebase
import FirebaseMessaging

var onboardinggenre = String()

class Onboarding2ViewController: UIViewController {

    func logGenrePicked(referrer : String) {
          AppEvents.logEvent(AppEvents.Name(rawValue: "picked genre"), parameters: ["genre" : onboardinggenre])
      }
    
    @IBAction func tapFour(_ sender: Any) {
        
        
        onboardinggenre = "Exercise"
 
        logGenrePicked(referrer: onboardinggenre)
        
        ref?.child("Users").child(uid).updateChildValues(["Onboarding" : onboardinggenre])

        
        
        self.performSegue(withIdentifier: "2to3", sender: self)
        

    }
    
    @IBAction func tapThree(_ sender: Any) {
       onboardinggenre = "Depression"
        
        logGenrePicked(referrer: onboardinggenre)
        
        ref?.child("Users").child(uid).updateChildValues(["Onboarding" : onboardinggenre])
        
      
        self.performSegue(withIdentifier: "2to3", sender: self)
    }
    @IBAction func tapTwo(_ sender: Any) {
        
        onboardinggenre = "Love"

        logGenrePicked(referrer: onboardinggenre)
        
        ref?.child("Users").child(uid).updateChildValues(["Onboarding" : onboardinggenre])
        
         

        self.performSegue(withIdentifier: "2to3", sender: self)
    }
    @IBAction func tapOne(_ sender: Any) {
        
        onboardinggenre = "Money"
        
        logGenrePicked(referrer: onboardinggenre)
        
        ref?.child("Users").child(uid).updateChildValues(["Onboarding" : onboardinggenre])
        

        self.performSegue(withIdentifier: "2to3", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()

        onboarding = true
        logScreenView(referrer: "onboarding2")

        // Do any additional setup after loading the view.
    }
    
    func logScreenView(referrer : String) {
                                  AppEvents.logEvent(AppEvents.Name(rawValue: "Onboarding2"), parameters: ["genre" : "genre"])
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
