//
//  ViewController.swift
//  NSFileManager
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var files: NSMutableArray = []
    var fileManager:FileManager!
    var documentsPath: String!
    var filelist:NSArray!
    
    @IBOutlet weak var tabla: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        files = []
        fileManager = FileManager.default
        documentsPath = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as String)
        filelist = try! fileManager.contentsOfDirectory(atPath: documentsPath) as NSArray!
        
        print("documentspath:  \(documentsPath)")
        print(files.count)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        filelist = try! fileManager.contentsOfDirectory(atPath: documentsPath) as NSArray!
        files = []
        for file in filelist {
            files.add(file)
            print("file:  \(file)")
        }
        tabla.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier:NSString = "CollectionCell"
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier as String, for: indexPath) 

        cell.textLabel!.text = (files.object(at: (indexPath as NSIndexPath).row) as AnyObject).description
        
        var isDir: ObjCBool = ObjCBool(false)
        if(fileManager.fileExists(atPath: (documentsPath as NSString).appendingPathComponent(files[(indexPath as NSIndexPath).row] as! String), isDirectory: &isDir)){
            if(isDir).boolValue{
                cell.imageView!.image = UIImage(named: "dir.png")
            } else{
                cell.imageView!.image = UIImage(named: "file.png")
            }
        }
        return cell
    }
}
