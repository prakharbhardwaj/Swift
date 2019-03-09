//
//  TableListViewcontroller.swift
//  BasicAgenda
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class TableListViewController: UITableViewController, NewContactDelegate {
    
    var contactArray = Array<Contact>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...50 {
            let contact = Contact()
            
            contact.name = "Name\(i)"
            contact.surname = "Surname\(i)"
            contact.phone = "Phone\(i)"
            contact.email = "Email\(i)"
            
            contactArray.append(contact)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        
        let contact = contactArray[(indexPath as NSIndexPath).row]
        cell.textLabel!.text = contact.name + " " + contact.surname
        cell.tag = (indexPath as NSIndexPath).row
        print("Cell number: \((indexPath as NSIndexPath).row)")
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailFromListado" {
            let detailViewController = segue.destination as! DetailViewController
            let cell = sender as! UITableViewCell
            detailViewController.contact = contactArray[cell.tag]
        } else if segue.identifier == "goToNewContactFromListado" {
            let navigationController = segue.destination as! UINavigationController
            let newContactViewController = navigationController.viewControllers[0] as! NewContactViewController
            newContactViewController.delegate = self
        }
    }
    
    // MARK: - Delegate
    
    func newContact(_ contact: Contact) {
        contactArray.append(contact)
        tableView.reloadData()
    }
    
}
