//
//  ImagesOperation.swift
//  XMLAppStore
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit
import Foundation

protocol ImagesOperationDelegate{
    func imageOperation(imagesOperation:ImagesOperation, app:AppInfo)
}

class ImagesOperation: NSOperation, NSURLConnectionDelegate {
    
    var delegate: ImagesOperationDelegate?
    var app: AppInfo!
    var currentData:NSMutableData!
    
    override func main(){
        let connection = NSURLConnection(request: NSURLRequest(URL: NSURL(string: app.urlImage)!), delegate: self, startImmediately: false)
        connection!.scheduleInRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
        connection!.start()
        self.currentData = NSMutableData()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.currentData.appendData(data)
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError){
        self.currentData = nil
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!){
        let image: UIImage? = UIImage(data: self.currentData)
            if(image != nil){
                self.app.image = image
                self.delegate?.imageOperation(self, app: self.app)
            }
    }

}
