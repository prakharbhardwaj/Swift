//
//  ViewController.swift
//  RotateGesture
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var netRotation:CGFloat = 0
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(ViewController.rotateGesture(_:)))
        image.addGestureRecognizer(rotateGesture)
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func rotateGesture(_ sender : UIRotationGestureRecognizer) {
        let rotation:CGFloat = sender.rotation
        let transform:CGAffineTransform  = CGAffineTransform(rotationAngle: rotation + netRotation)
        sender.view?.transform = transform
        if (sender.state == UIGestureRecognizerState.ended){
            netRotation += rotation;
        }
    }
    
}
