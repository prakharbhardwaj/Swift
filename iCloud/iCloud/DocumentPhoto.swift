//
//  DocumentPhoto.swift
//  iCloud
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class DocumentPhoto: UIDocument {
    var image : UIImage!
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        
        let data = Data(bytes: UnsafePointer<UInt8>((contents as AnyObject).bytes), count: contents.length)
        self.image = UIImage(data: data)
    }
    
    override func contents(forType typeName: String) throws -> Any {
        let outError: NSError! = NSError(domain: "Migrator", code: 0, userInfo: nil)
        
        if let value = UIImageJPEGRepresentation(self.image, 1.0) {
            return value
        }
        throw outError
    }
    
}
