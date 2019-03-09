//
//  AdvancedViewController.swift
//  XML
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit
import AVFoundation

class SuperSong : Song {
    var artist : String = ""
    var url : URL? = URL(string: "")
    var imageUrl : URL? = URL(string: "")
    var previewUrl : URL? = URL(string: "")

}

class SongCell : UITableViewCell {
    
    @IBOutlet var albumImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
}

class AdvancedViewController: UITableViewController, XMLParserDelegate {
    
    var songs : [SuperSong] = []
    var song : SuperSong = SuperSong()
    var currentElementString: String = ""
    var previousElementName: String = ""
    
    var avPlayer: AVPlayer!

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
            song = SuperSong()
            return
        }
        

        if elementName == "link" {
            // Found a link to a resource
            if let linkTitle = attributeDict["title"] {
                if linkTitle == "Preview" {
                    // Resource is a preview clip
                    if let href = attributeDict["href"] {
                        // Assign link to preview clip to our current song
                        song.previewUrl = URL(string: href)
                    }
                }
            }
        }
        
        // Found song title entry. Empty string to parse next element.
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
        
        if elementName == "im:name" && previousElementName == "title" {
            // Assign fully parsed song title to current song
            song.title = currentElementString
        }
        
        if elementName == "im:artist" {
            // Assign fully parsed song title to current song
            song.artist = currentElementString
        }
        
        if elementName == "id" {
            // Assign fully parsed iTunes URL to current song
            song.url = URL(string: currentElementString)
        }
        
        if elementName == "im:image" {
            // Assign fully parsed iTunes URL to current song
            song.imageUrl = URL(string: currentElementString)
        }
        
        // Add song to array
        if elementName == "entry" {
            songs += [song]
        }
        
        previousElementName = elementName

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as UITableViewCell as! SongCell

        let song = songs[indexPath.row]
        cell.titleLabel.text = song.title
        cell.artistLabel.text = song.artist
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: song.imageUrl!) {
                if let image = UIImage(data: imageData) {

                    DispatchQueue.main.async {
                        cell.albumImageView.image = image
                        
                    }
                }
            }
        
        }
        
        return cell
    }
    
    override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = songs[indexPath.row]
        self.avPlayer = AVPlayer(url: song.previewUrl!)
        self.avPlayer.play()
        
    }

}
