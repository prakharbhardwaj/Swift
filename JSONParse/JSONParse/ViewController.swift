//
//  ViewController.swift
//  JSONParse
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

struct AppDetails: Codable {
    struct Feed: Codable {
        struct Entry: Codable {
            struct ImImage: Codable {
                let label: String
            }
            struct Summary: Codable {
                let label: String
            }
            struct Title: Codable {
                let label: String
            }
            let imimage: [ImImage]
            let summary: Summary
            let title: Title
            
            enum CodingKeys: String, CodingKey {
                case imimage = "im:image"
                case summary
                case title
            }
        }
        let entry: [Entry]
    }
    let feed: Feed
}

class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var tittle: UILabel!
    @IBOutlet weak var myDescription: UITextView!
    
    var dataJSON = NSMutableData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stringURL:NSString = "https://itunes.apple.com/es/rss/topfreeapplications/limit=10/json"
        //building NSURL
        let url = URL(string: stringURL as String)
        //building NSURLRequest
        let request = URLRequest(url: url!)
        //connection
        
        let connection: NSURLConnection? = NSURLConnection(request: request, delegate: self)
        
        if (connection != nil){
            print("Connecting...")
            dataJSON = NSMutableData()
        }
        else{
            print("Connection failed")
        }
        
//        let stringURL:NSString = "https://itunes.apple.com/es/rss/topfreeapplications/limit=10/json"
//        //building NSURL
//        let url = NSURL(string: stringURL as String)
//        
//        let request = NSMutableURLRequest(URL: url!)
//        let session = NSURLSession.sharedSession()
//        
//        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//            print("Response: \(response)")})
//        
//        task.resume()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func connection(_ connection: NSURLConnection!, didFailWithError error: NSError!){
        print("Error: \(error)")
    }
    
    func connection(_ connection: NSURLConnection!, didReceiveResponse response: URLResponse!){
        print("Received response: \(response)")
        //restore data
        dataJSON.length = 0
    }
    
    func connection(_ connection: NSURLConnection!, didReceiveData data:Data!){
        self.dataJSON.append(data)
    }
    
    func connectionDidFinishLoading(_ connection: NSURLConnection!){
        
        do {
            let appDetails = try JSONDecoder().decode(AppDetails.self, from: dataJSON as Data)
            
            // get title and description
            tittle.text = appDetails.feed.entry[0].title.label
            myDescription.text = appDetails.feed.entry[0].summary.label
            
            // get image
            let imgLabel = appDetails.feed.entry[0].imimage[2].label
            guard let imgUrl = URL(string: imgLabel),
                let imgData = try? Data(contentsOf: imgUrl),
                let img = UIImage(data: imgData) else {
                throw NSError()
            }
            image.image = img
            
        } catch {
            // failure
            print("Fetch failed: \((error as NSError).localizedDescription)")
        }
    }
}
