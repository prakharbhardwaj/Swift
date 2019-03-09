//
//  ViewController.swift
//  NSURLSession
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var temperatureCelsius: UITextField!
    @IBOutlet weak var temperatureCelsiusMax: UITextField!
    @IBOutlet weak var temperatureCelsiusMin: UITextField!
    @IBOutlet weak var temperatureKelvin: UITextField!
    @IBOutlet weak var temperatureKelvinMax: UITextField!
    @IBOutlet weak var temperatureKelvinMin: UITextField!
    @IBOutlet weak var humidity: UITextField!
    @IBOutlet weak var wind: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sessionConfig: URLSessionConfiguration = URLSessionConfiguration.default
        sessionConfig.allowsCellularAccess = false
        //only accept JSON answer
        sessionConfig.httpAdditionalHeaders = ["Accept":"application/json"]
        //timeouts and connections allowed
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 60.0
        sessionConfig.httpMaximumConnectionsPerHost = 1
        //create session, assign configuration
        let session = URLSession(configuration: sessionConfig)
      
      
      
        session.dataTask(with: URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Barcelona,es&appid=ac02dc102cc17b974cd84206048d97d8")!, completionHandler: {(data, response, error) in
            let dic:NSDictionary = ((try? JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions(rawValue: 0))) as? NSDictionary)! as NSDictionary
            
            if dic.count == 0 {
                return
            }
            
            print(dic)
            
            let city: String = (dic["name"] as! String)
            let kelvin: Double! = ((dic["main"] as! NSDictionary) ["temp"]) as! Double
            let kelvin_min: Double! = (dic["main"] as! NSDictionary) ["temp_min"] as! Double
            let kelvin_max: Double! = (dic["main"] as! NSDictionary) ["temp_max"] as! Double
            let celsius = kelvin as Double - 274.15 as Double
            let celsius_min = kelvin_min as Double - 274.15 as Double
            let celsius_max = kelvin_max as Double - 274.15 as Double
            let humidity: AnyObject = (dic ["main"] as! NSDictionary) ["humidity"] as AnyObject
            let wind: Double! = (dic ["wind"] as! NSDictionary) ["speed"] as! Double
          
            //original thread
            DispatchQueue.main.async(execute: { () in
                self.city.text = "\(city)"
                self.temperatureCelsius.text = "\(celsius)"
                self.temperatureCelsiusMax.text = "\(celsius_max)"
                self.temperatureCelsiusMin.text = "\(celsius_min)"
                self.temperatureKelvin.text = "\(kelvin!)"
                self.temperatureKelvinMax.text = "\(kelvin_max!)"
                self.temperatureKelvinMin.text = "\(kelvin_min!)"
                self.humidity.text = "\(humidity)"
                self.wind.text = "\(wind!)"
            })
        }).resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
