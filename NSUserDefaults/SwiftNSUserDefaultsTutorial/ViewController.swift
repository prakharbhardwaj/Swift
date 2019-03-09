//
//  ViewController.swift
//  SwiftNSUserDefaultsTutorial
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var preferenceSwitch: UISwitch!
    
    @IBAction func savePreferenceState(_ sender: AnyObject) {
        
        let defaults = UserDefaults.standard
        
        if preferenceSwitch.isOn {
            defaults.set(true, forKey: "SwitchState")
        } else {
            defaults.set(false, forKey: "SwitchState")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        if (defaults.object(forKey: "SwitchState") != nil) {
            preferenceSwitch.isOn = defaults.bool(forKey: "SwitchState")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
