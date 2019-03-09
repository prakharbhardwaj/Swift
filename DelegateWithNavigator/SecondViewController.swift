//
//  SegundoViewController.swift
//  DelegateWithNavigator
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

protocol myDelegate {
    func writeDateInLabel(_ date:NSString)
}

class SecondViewController: UIViewController {
    
    var data: NSString = ""
    var delegate: myDelegate?
    
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBAction func secondButton(_ sender: AnyObject) {
        self.delegate?.writeDateInLabel("I got it!")
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        secondLabel.text = data as String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
