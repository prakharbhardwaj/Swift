//
//  ViewController.swift
//  SocialFramework
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit
import Social
import Accounts

class ViewController: UIViewController {
    
    @IBAction func facebook(_ sender: UIButton) {
        
        let url: URL = URL(string: "http://www.google.es")!
        
        let fbController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        fbController?.setInitialText("")
        fbController?.add(url)
        
        let completionHandler = {(result:SLComposeViewControllerResult) -> () in
            fbController?.dismiss(animated: true, completion:nil)
            switch(result){
            case SLComposeViewControllerResult.cancelled:
                print("User canceled", terminator: "")
            case SLComposeViewControllerResult.done:
                print("User posted", terminator: "")
            }
        }
        
        fbController?.completionHandler = completionHandler
        self.present(fbController!, animated: true, completion:nil)
    }
    
    @IBAction func twitter(_ sender: UIButton) {
        
        let image: UIImage = UIImage(named: "image2.png")!
        
        let twitterController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        twitterController?.setInitialText("")
        twitterController?.add(image)
        
        let completionHandler = {(result:SLComposeViewControllerResult) -> () in
            twitterController?.dismiss(animated: true, completion: nil)
            switch(result){
            case SLComposeViewControllerResult.cancelled:
                print("User canceled", terminator: "")
            case SLComposeViewControllerResult.done:
                print("User tweeted", terminator: "")
            }
        }
        twitterController?.completionHandler = completionHandler
        self.present(twitterController!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
