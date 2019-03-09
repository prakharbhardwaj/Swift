//
//  ThirdViewController.swift
//  NSFileManager
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    var fileManager = FileManager.default
    var documentsPath = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as String)

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var txtBox: UITextView!
    
    @IBAction func open(_ sender: UIButton) {
    
        if(fileManager.fileExists(atPath: (documentsPath as NSString).appendingPathComponent("\(name.text).txt"))){
            let contenido = NSString(data: fileManager.contents(atPath: (documentsPath as NSString).appendingPathComponent("\(name.text).txt"))!, encoding: String.Encoding.utf8.rawValue)
            txtBox.text = contenido as! String
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
