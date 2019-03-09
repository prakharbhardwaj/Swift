//
//  FirstViewController.swift
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit
import Accounts
import Social
import Foundation

class FirstViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var labelUserName: UITextField!
    @IBOutlet weak var labelFollowers: UILabel!
    @IBOutlet weak var labelFollowing: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    
    @IBAction func update(_ sender: UIButton) {
        if(labelUserName.text != ""){
            checkUser()
        } else { print("Enter a name!") }
    }
    
    @IBAction func sendTweet(_ sender: UIButton) {
        let twitterController = SLComposeViewController(forServiceType:SLServiceTypeTwitter)
        let imageToTweet = UIImage(named:"image1.png")
        twitterController?.setInitialText("Test from Xcode")
        twitterController?.add(imageToTweet)
        let completionHandler:SLComposeViewControllerCompletionHandler = {
            (result) in twitterController?.dismiss(animated: true, completion: nil)
            switch(result) {
                case SLComposeViewControllerResult.cancelled:
                    print("Canceled")
                case SLComposeViewControllerResult.done:
                    print("User tweeted")
            }
        }
        twitterController?.completionHandler = completionHandler
        self.present(twitterController!, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelUserName.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
        // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    func checkUser(){
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccounts(with: accountType, options: nil, completion: { (granted, error) in
                if (granted == true) {
                    var accounts = accountStore.accounts(with: accountType)
                    if ((accounts?.count)!>0) {
                        let twitterAccount = accounts?[0] as! ACAccount
                        let twitterInfoRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, url: URL(string: "https://api.twitter.com/1.1/users/show.json"), parameters: NSDictionary(object: self.labelUserName.text!, forKey: "screen_name" as NSCopying) as! [AnyHashable: Any])
                        twitterInfoRequest?.account = twitterAccount
                        twitterInfoRequest?.perform(handler: {(responseData,urlResponse,error) in DispatchQueue.main.async(execute: {() in
                            //check access
                            if (urlResponse?.statusCode == 429) {
                                print("Rate limit reached")
                                    return
                            }
                            //check error
                            if (error != nil) {
                                print("Error \(error?.localizedDescription)")
                            }
                            if(responseData != nil){
                                //if dta received TO DO
                
                                let TWData = (try! JSONSerialization.jsonObject(with: responseData!, options: JSONSerialization.ReadingOptions.mutableLeaves)) as! NSDictionary
                                //getting data
                                let followers = (TWData.object(forKey: "followers_count")! as AnyObject).int32Value!
                                let following = (TWData.object(forKey: "friends_count")! as AnyObject).int32Value!
                                let description = TWData.object(forKey: "description") as! NSString
                                self.labelFollowers.text = "\(followers)"
                                self.labelFollowing.text = "\(following)"
                                self.textViewDescription.text = description as String
                
                                var profileImageStringURL = TWData.object(forKey: "profile_image_url_https") as! NSString
                                profileImageStringURL = profileImageStringURL.replacingOccurrences(of: "_normal", with: "") as NSString
                                let url = URL(string: profileImageStringURL as String)
                                let data = try? Data(contentsOf: url!)
                                self.imageViewPhoto.image = UIImage(data: data!)
                            } })
                }) }
    } else {
            print("No access granted")
    }
    }) }

}
