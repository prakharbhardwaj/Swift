//
//  ViewController.swift
//  SQLite
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var statement: OpaquePointer = nil
    var data: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTabla()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadTabla() {
        let db_path = Bundle.main.path(forResource: "FilmCollection", ofType: "sqlite")
        print(Bundle.main)
        var db: OpaquePointer = nil
        let status = sqlite3_open(db_path!, &db)
        if(status == SQLITE_OK){
            //bbdd open
            print("open")
        }
        else{
            //bbdd error
            print("open error")
        }
        
        let query_stmt = "select * from film"
        
        if(sqlite3_prepare_v2(db, query_stmt, -1, &statement, nil) == SQLITE_OK){
            data.removeAllObjects()
            while(sqlite3_step(statement) == SQLITE_ROW){
                let Dictionary = NSMutableDictionary()
                
                let director = sqlite3_column_text(statement, 1)
                let buf_director = String(cString: UnsafePointer<CChar>(director!))
                let image = sqlite3_column_text(statement, 2)
                let buf_image = String(cString: UnsafePointer<CChar>(image!))
                let title = sqlite3_column_text(statement, 3)
                let buf_title = String(cString: UnsafePointer<CChar>(title!))
                let year = sqlite3_column_text(statement, 4)
                let buf_year = String(cString: UnsafePointer<CChar>(year!))
                
                Dictionary.setObject(buf_director, forKey:"director" as NSCopying)
                Dictionary.setObject(buf_image, forKey: "image" as NSCopying)
                Dictionary.setObject(buf_title, forKey: "title" as NSCopying)
                Dictionary.setObject(buf_year, forKey: "year" as NSCopying)
                
                data.add(Dictionary)
                //process data
            }
            sqlite3_finalize(statement)
        }
        else{
            print("ERROR")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell") as! MyTableViewCell
        let aux: AnyObject = data[(indexPath as NSIndexPath).row] as AnyObject
        let table_director = aux["director"]
        cell.director.text = table_director as? String
        //var aux1: AnyObject = data[indexPath.row]
        let table_image = aux["image"]
        cell.myImage.image = UIImage(named:table_image as! String)
        let aux3: AnyObject = data[(indexPath as NSIndexPath).row] as AnyObject
        let table_title = aux["title"]
        cell.title.text = table_title as? String
        
        //var aux4: AnyObject = data[indexPath.row]
        let table_year = aux3["year"]
        cell.year.text = table_year as? String

        return cell
    }
   
}
