//
//  NotificationsViewController.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 4/28/20.
//  Copyright © 2020 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {
    @IBOutlet weak var slider: UISlider!
    
    
    @IBAction func tapSlider(_ sender: Any) {
        
        reminderlabel.text =
            String(Int(slider.value))
    }
    @IBOutlet weak var reminderlabel: UILabel!
    
    @IBAction func tapContinue(_ sender: Any) {
        
        ref?.child(uid).updateChildValues(["ReminderCount" : Int(slider.value)])
        
        self.performSegue(withIdentifier: "OnboardingToPaywall", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        reminderlabel.text = String(Int(slider.value))
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
