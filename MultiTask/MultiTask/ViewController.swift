//
//  ViewController.swift
//  MultiTask
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var myNotification: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateInterface(_:)), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    func updateInterface (_ notification: Notification){
        myNotification.text = "Back to background with notification"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
