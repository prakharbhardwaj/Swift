//
//  ViewController.swift
//  XMLAppStore
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, NSURLConnectionDelegate, NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate, ImagesOperationDelegate {
    
    @IBOutlet weak var tabla: UITableView!
    var listData: NSMutableData!
    var currentString: NSMutableString!
    var shouldParse:Bool!
    var apps:NSMutableArray!
    var currentApp:AppInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var queue = NSOperationQueue()
        let urlRequest = NSURLRequest(URL: NSURL(string:"http://phobos.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=75/xml")!)
        
        NSURLConnection(request: urlRequest, delegate: self)
        currentString = NSMutableString(string: "")
        apps = NSMutableArray()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func connection(connection: NSURLConnection!, didReceiveResponse response: NSURLResponse!){
        listData = NSMutableData()
        print("Did receive Response")
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        listData.appendData(data)
        print("Did Receive Data")
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!){
        print("Did finish loading")
        let parser = NSXMLParser(data: listData)
        parser.delegate = self
        parser.parse()
        tabla.reloadData()
        let queue = NSOperationQueue()
        for it in apps{
            let imagesOperation = ImagesOperation()
            imagesOperation.app = it as! AppInfo
            imagesOperation.delegate = self
            queue.addOperation(imagesOperation)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        
        let elementsToParse = NSArray(objects: "id","im:name","im:image")
        
        if(elementName == "entry"){
            self.currentApp = AppInfo()
        }
        shouldParse = elementsToParse.containsObject(elementName)
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        if(self.currentApp != nil){
            //if(shouldParse || elementName == "entry"){
            let trimmedString = currentString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            currentString.setString("")
            if(elementName == "id"){
                self.currentApp.urlApp = trimmedString
                print("URL APP: \(trimmedString)")
            }
            else if(elementName == "im:name"){
                self.currentApp.name = trimmedString
                print("NAME: \(trimmedString)")
            }
            else if(elementName == "im:image"){
                self.currentApp.urlImage = trimmedString
                print("URL IMAGE: \(trimmedString)")
            }
            else if(elementName == "entry"){
                self.currentApp.index = apps.count
                apps.addObject(currentApp)
                currentApp = nil
            }
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        if((shouldParse) != nil){
            currentString.appendString(string)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tabla.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        let label: UILabel = cell.viewWithTag(101) as! UILabel
        let app = apps.objectAtIndex(indexPath.row) as! AppInfo
        label.text = app.name
        let imageView = cell.viewWithTag(100) as! UIImageView
        imageView.image = app.image
        
        return cell
    }
    
    func imageOperation(imagesOperation:ImagesOperation, app:AppInfo){
        var visibleCells = tabla.visibleCells
        let firstIndex = tabla.indexPathForCell(visibleCells[0] )?.row
        let lastIndex = tabla.indexPathForCell(visibleCells.last! as UITableViewCell)!.row
        if(app.index >= firstIndex && app.index <= lastIndex){
            let cell = tabla.cellForRowAtIndexPath(NSIndexPath(forRow: app.index, inSection: 0))
            let imageView = cell?.viewWithTag(100) as! UIImageView
            imageView.image = app.image
        }
    }
    
}
