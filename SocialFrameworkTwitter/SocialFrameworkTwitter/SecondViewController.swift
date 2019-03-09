//
//  SecondViewController.swift
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit
import Accounts
import Social
import Foundation

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var table: UITableView!
    
    var refreshControl:UIRefreshControl!
    var tweetsArray = NSArray()
    var imageDictionary:NSMutableDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTimeLine), for: UIControlEvents.valueChanged)
        self.refreshTimeLine()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.refreshTimeLine()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func refreshTimeLine(){
            if(SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter)){
                let accountStore = ACAccountStore()
                let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
                accountStore.requestAccessToAccounts(with: accountType, options: nil, completion: {(granted,error) in
                    if (granted==true) {
                        let arrayOfAccounts = accountStore.accounts(with: accountType)
                        let tempAccount = arrayOfAccounts?.last as! ACAccount
                        let tweetURL = URL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
                        let tweetRequest = SLRequest(forServiceType:SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, url: tweetURL, parameters: nil)
                        tweetRequest?.account = tempAccount
                        tweetRequest?.perform(handler: {(responseData,urlResponse,error) in
                            if(error == nil){
                
                                let responseJSON: NSArray?
                
                                do {
                                    responseJSON = try JSONSerialization.jsonObject(with: responseData!, options: JSONSerialization.ReadingOptions.allowFragments) as? NSArray
                    
                                    self.tweetsArray = responseJSON!
                                    self.imageDictionary = NSMutableDictionary()
                                    DispatchQueue.main.async(execute: {self.table.reloadData()})
                    
                                } catch _ {
                                    print("JSON ERROR ")
                                }

                            } else{ print("/*access Error*/") }
                        })
                    } })
            } else { print("/*Error: you need Twitter account*/") }
                refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweetsArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timelineCell") as! TimelineCell
        let currentTweet = self.tweetsArray.object(at: indexPath.row) as! NSDictionary
        let currentUser = currentTweet["user"] as! NSDictionary
        cell.userNameLabel!.text = currentUser["name"] as? String
        cell.tweetlabel!.text = currentTweet["text"] as! String
        let userName = cell.userNameLabel.text
        if  ((self.imageDictionary[userName!]) != nil) {
            cell.userImageView.image = (self.imageDictionary[userName!] as! UIImage)
        } else {
            DispatchQueue.global().async(execute: {
                let imageURL = URL(string: currentUser.object(forKey: "profile_image_url") as! String)
                let imageData = try? Data(contentsOf: imageURL!)
                self.imageDictionary.setObject(UIImage(data: imageData!)!, forKey: userName! as NSCopying)
                DispatchQueue.main.async {
                    cell.userImageView.image = (self.imageDictionary[cell.userNameLabel.text!] as! UIImage)
                }
            })
        }

    return cell
    }

}
