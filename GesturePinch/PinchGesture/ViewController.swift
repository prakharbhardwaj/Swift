//
//  ViewController.swift
//  PinchGesture
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var lastScaleFactor:CGFloat = 1
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        let pinchGesture:UIPinchGestureRecognizer =
        UIPinchGestureRecognizer(target: self, action: #selector(ViewController.pinchGesture(_:)))
        image.addGestureRecognizer(pinchGesture)
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pinchGesture(_ sender : UIPinchGestureRecognizer) {
        let factor = sender.scale
        if (factor > 1) {
            //increase zoom
            sender.view?.transform = CGAffineTransform(
                scaleX: lastScaleFactor + (factor-1),
                y: lastScaleFactor + (factor-1));
        } else {
            //decrease zoom
            sender.view?.transform = CGAffineTransform(
                scaleX: lastScaleFactor * factor,
                y: lastScaleFactor * factor);
        }
        if (sender.state == UIGestureRecognizerState.ended){
            if (factor > 1) {
                lastScaleFactor += (factor-1);
            } else {
                lastScaleFactor *= factor;
            } }
    }
    
}
