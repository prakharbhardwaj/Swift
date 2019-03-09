//
//  NewClass.swift
//  Segues
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class NewClass: UIStoryboardSegue {
    
    override func perform(){
        
        let source : UIViewController = self.source 
        let destination : UIViewController = self.destination 
        
        UIGraphicsBeginImageContext(source.view.bounds.size)
        source.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let sourceImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        destination.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let destinationImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        let sourceImageView : UIImageView = UIImageView (image: sourceImage)
        let destinationImageView : UIImageView = UIImageView (image: destinationImage)
        source.view.addSubview(sourceImageView)
        source.view.addSubview(destinationImageView)
        destinationImageView.transform = CGAffineTransform(translationX: destinationImageView.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 1.0, animations: { () in
            sourceImageView.transform = CGAffineTransform(translationX: -sourceImageView.frame.size.width, y: 0)
            destinationImageView.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: { (finished) in
                source.present(destination, animated: true, completion: nil)
        }) }
    
}
