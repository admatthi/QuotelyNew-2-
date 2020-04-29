//
//  NoNotificationsViewController.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 4/28/20.
//  Copyright © 2020 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit

class NoNotificationsViewController: UIViewController {

    @IBAction func tapContinue(_ sender: Any) {
        
    if let bundleIdentifier = Bundle.main.bundleIdentifier, let appSettings = URL(string: UIApplication.openSettingsURLString + bundleIdentifier) {
            if UIApplication.shared.canOpenURL(appSettings) {
                UIApplication.shared.open(appSettings)
            }
        }
        
        self.performSegue(withIdentifier: "OnboardingToPaywall2", sender: self)

      
    }
    @IBAction func tapNo(_ sender: Any) {
        
          self.performSegue(withIdentifier: "OnboardingToPaywall2", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
