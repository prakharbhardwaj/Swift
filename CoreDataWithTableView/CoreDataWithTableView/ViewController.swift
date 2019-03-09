//
//  ViewController.swift
//  CoreDataWithTableView
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var results: NSArray! = NSArray()
    var appDel: AppDelegate!
    var context: NSManagedObjectContext!
    var request: NSFetchRequest<NSManagedObject>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDel = UIApplication.shared.delegate as! AppDelegate
        context = appDel.managedObjectContext
        
        //Code to add a movie
        let movie = NSEntityDescription.insertNewObject(forEntityName: "Movie", into:  context) 
        movie.setValue("El Hobbit: Un viaje inesperado", forKey: "title")
        movie.setValue("2013", forKey: "year")
        movie.setValue("Peter Jackson", forKey: "director")
        movie.setValue("hobbit.jpg", forKey: "image")
        
        do {
        try context.save()
        }
        catch {
            print("Error!")
        }
  
        loadTable()
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTable(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        request.returnsObjectsAsFaults = false
        results = try! context.fetch(request) as NSArray
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell") as! MyTableViewCell
        let aux = results[(indexPath as NSIndexPath).row] as! NSManagedObject
        cell.title.text = aux.value(forKey: "title") as? String
        cell.director.text = aux.value(forKey: "director") as? String
        cell.year.text = aux.value(forKey: "year") as? String
        cell.myImage.image = UIImage(named:aux.value(forKey: "image") as! String)
        
        return cell
    }
  
}
