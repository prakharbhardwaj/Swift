//
//  SecondViewController.swift
//  NSFileManager
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var nameDirectory: UITextField!

    @IBAction func createFile(_ sender: UIButton) {
        let content = text.text.data(using: String.Encoding.utf8, allowLossyConversion: true)
        if(fileManager.createFile(atPath: documentsPath.appendingPathComponent("\(name.text).txt"), contents: content, attributes: nil)){
            print("created")
        }
    }
    
    @IBAction func createDirectory(_ sender: UIButton) {
        let newDirectory:NSString = documentsPath.appendingPathComponent(nameDirectory.text!) as NSString
        let fileManager = FileManager.default
        
        _ = try? fileManager.createDirectory( atPath: newDirectory as String,
            withIntermediateDirectories: true,
            attributes: nil )
        
//        if(fileManager.createDirectoryAtPath(newDirectory as String, withIntermediateDirectories: true, attributes: nil)){
//            print("created")
//        }
    }
    
    var fileManager = FileManager.default
    var documentsPath = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as NSString)

    override func viewDidLoad() {
        super.viewDidLoad()
        name.delegate = self
        nameDirectory.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
