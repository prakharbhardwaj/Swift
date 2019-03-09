//
//  ViewController.swift
//  Gestures
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var netRotation:CGFloat = 0
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        
        //ROTATION
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(ViewController.rotateGesture(_:)))
        image.addGestureRecognizer(rotateGesture)
        
        //SWIPE
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeGestureRight.direction = UISwipeGestureRecognizerDirection.right
        image.addGestureRecognizer(swipeGestureRight)
        
        let swipeGestureDown = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeGestureDown.direction = UISwipeGestureRecognizerDirection.down
        image.addGestureRecognizer(swipeGestureDown)
        
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.left
        image.addGestureRecognizer(swipeGestureLeft)
        
        let swipeGestureUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeGestureUp.direction = UISwipeGestureRecognizerDirection.up
        image.addGestureRecognizer(swipeGestureUp)
        
        //LONG PRESS
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.action(_:)))
        longPressGesture.minimumPressDuration = 2.0;
        image.addGestureRecognizer(longPressGesture)
        
        image.image = UIImage(named: "image1.png")
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //ROTATION
    @IBAction func rotateGesture(_ sender : UIRotationGestureRecognizer) {
        let rotation:CGFloat = sender.rotation
        let transform:CGAffineTransform  =
        CGAffineTransform(rotationAngle: rotation + netRotation)
        sender.view?.transform = transform
        if (sender.state == UIGestureRecognizerState.ended){
            netRotation += rotation;
        }
    }
    
    //SWIPE
    @IBAction func respondToSwipeGesture(_ send: UIGestureRecognizer) {
        
        if let swipeGesture = send as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                changeImage()
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                changeImage()
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                changeImage()
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                changeImage()
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    //LONG PRESS
    @IBAction func action(_ gestureRecognizer:UIGestureRecognizer) {
        
        if (gestureRecognizer.state == UIGestureRecognizerState.began){
            let alertController = UIAlertController(title: "Alert", message: "Long Press gesture", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true) { }
        }
    }
    
    func changeImage(){
        if (image.image == UIImage(named: "image1.png")){
            image.image = UIImage(named: "image2.png")}
        else{
            image.image = UIImage(named: "image1.png")
        }
    }
 
}
