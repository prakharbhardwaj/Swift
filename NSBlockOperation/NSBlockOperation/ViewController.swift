//
//  ViewController.swift
//  NSBlockOperation
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        
        let queue = OperationQueue()
        let operation1 : BlockOperation = BlockOperation (
            block: {
                self.getWebs()
                let operation2 : BlockOperation = BlockOperation(block: {
                    self.loadWebs()
                })
                queue.addOperation(operation2)
        })
        queue.addOperation(operation1)
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadWebs(){
		var urls = [URL(string:"http://www.google.es")!,
		            URL(string: "http://www.apple.com")!,
		            URL(string: "http://www.bing.com")!,
		            URL(string: "http://www.yahoo.com")!]
//        urls.addObjects(from: googlewebs as [AnyObject])
        for url in urls{
           /// NSData(contentsOfURL:iterator as! NSURL)
            print("Downloaded \(url)")
        }
    }
    
    var googlewebs = [URL]()
    
    func getWebs(){
        let languages = ["com","ad","ae","com.af",
                         "com.ag","com.ai","am","co.ao",
                         "com.ar","as","at"]
        var languageWebs = [URL]()
        for language in languages{
            let webString = "http://www.google.\(language)"
			languageWebs.append(URL(fileURLWithPath: webString))
        }
		
        googlewebs = languageWebs
    }
  
}
