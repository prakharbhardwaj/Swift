//
//  ViewController.swift
//  CoreDataSample2
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @objc var results: NSArray = [] // better code writing
    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var table: UITableView!
    @IBAction func save(_ sender: UIButton) {
        
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let cell = NSEntityDescription.insertNewObject(forEntityName: "Form", into:  context) 
        cell.setValue(name.text, forKey: "name")
        cell.setValue(surname.text, forKey: "surname")
        
        // Save the context.
        // I'm using a do try catch here
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //print("Unresolved error \(error), \(error.userInfo)")
        }
  
        self.loadTable()
        self.table.reloadData()
        
        
        // make sure the textfields are empty after we click the save button
        name.text = ""
        surname.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTable() //start load
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = UITableViewCell(style:UITableViewCellStyle.subtitle, reuseIdentifier: nil)
        let aux = results[indexPath.row] as! NSManagedObject
        cell.textLabel!.text = aux.value(forKey: "name") as? String
        cell.detailTextLabel!.text = aux.value(forKey: "surname") as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?  {
        return "Name Contacts"
    }
    
    @objc func loadTable(){
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Form")
        request.returnsObjectsAsFaults = false
        
        //I'm using a do try catch here.
        
        do{
            
         results = try context.fetch(request) as NSArray
        }catch{
            
            //catch error here
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
