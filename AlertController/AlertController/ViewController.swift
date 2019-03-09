//
//  ViewController.swift
//  AlertController
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func actionAlert(_ sender: AnyObject) {
        
        let alertController = UIAlertController(title: "My Title", message: "This is an alert", preferredStyle:UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("you have pressed the Cancel button");
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("you have pressed OK button");
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:{ () -> Void in
            //your code here
        })
        
    }

    @IBAction func actionSheet(_ sender: AnyObject) {
        
        let alertController = UIAlertController(title: "My Title", message: "This is an alert", preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("you have pressed the Cancel button");
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("you have pressed OK button");
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:{ () -> Void in
            //your code here
        })
        
    }
    
    @IBAction func actionAlertWithForm(_ sender: AnyObject) {
        
        let alertController = UIAlertController(title: "My Title", message: "This is an alert", preferredStyle:UIAlertControllerStyle.alert)
            
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("you have pressed the Cancel button");
        }
        alertController.addAction(cancelAction)
            
        let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("you have pressed OK button");
            
            let userName = alertController.textFields![0].text
            let password = alertController.textFields![1].text
            
            self.doSomething(userName, password: password)
        }
        alertController.addAction(OKAction)
        
        alertController.addTextField(configurationHandler: {(textField : UITextField!) in
            textField.placeholder = "User Name"
            textField.isSecureTextEntry = false
        })
        
        alertController.addTextField(configurationHandler: {(textField : UITextField!) in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
        })
            
        self.present(alertController, animated: true, completion:{ () -> Void in
             //your code here
        })
    }
    
    @objc func doSomething(_ userName: String?, password: String?) {
        print("username: \(userName ?? "")  password: \(password ?? "")")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
