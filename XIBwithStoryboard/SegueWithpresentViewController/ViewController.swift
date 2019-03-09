//
//  ViewController.swift
//  SegueWithpresentViewController
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func buttonAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController:UIViewController = storyboard.instantiateViewController(withIdentifier: "NewViewController") 
        self.present(viewController, animated: true,
            completion: nil)
    }
    
    @IBAction func buttonAction2(_ sender: UIButton) {
        
        let newControlador = UIViewController (nibName: "NewClass", bundle: nil)
        self.present(newControlador, animated: true,
            completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
