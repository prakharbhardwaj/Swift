//
//  BasicViewController.swift
//  XML
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//


// This is the most straight forward implementation of an XML parser in a table view.
// To see slightly more complex implementation, go to the Storyboard and drag
// the big "initial view" arrow to the AdvancedViewController.

import UIKit

class Song {
    var title : String = ""
}

class BasicViewController: UITableViewController, XMLParserDelegate {
    
    var songs : [Song] = []
    var song : Song = Song()
    var currentElementString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Access Top 10 Songs on iTunes XML
        let url = URL(string: "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topsongs/limit=10/xml")
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            // Check for errors
            guard error == nil else {
                print(error ?? "Error!")
                return
            }
            // Check for data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            let parser = XMLParser(data: responseData)
            parser.delegate = self
            //parser.shouldResolveExternalEntities = true
            parser.parse()
            
            for song in self.songs {
                print(song.title)
            }
            
            // Properly updates table view when session is complete
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        })
        
        task.resume()
    }
    
    // MARK: - XML Parser methods
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        
        if elementName == "entry" {
            // Found new song. Create object of Song class.
            song = Song()
            return
        }
        
        currentElementString = ""
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        /* Add newly parsed characters to current element string. It is necessary to append the new characters on the existing string because of how the parser deals with special characters.
         If this line simply read:
         "currentElementString = string"
         the resulting song title might be:
         "T STOP THE FEELING - Justin Timberlake"
         as the parser would separete "CAN'" as its own item, and discard it.
         By building the string through appending and emptying it with each new element, the resulting title comes out properly:
         "CAN'T STOP THE FEELING - Justin Timberlake"
         */
        currentElementString += string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        
        if elementName == "entry" {
            // Add song to array
            songs += [song]
        }
        
        if elementName == "title" {
            // Assign fully parsed song title to current song
            song.title = currentElementString
        }
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("songs.count is \(songs.count)")
        return songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as UITableViewCell
        let song = songs[indexPath.row]
        cell.textLabel!.text = song.title
        
        return cell
    }
    
    
}
