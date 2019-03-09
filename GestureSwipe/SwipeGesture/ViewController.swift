//
//  ViewController.swift
//  SwipeGesture
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image2: UIImageView!
    
    override func viewDidLoad() {
        
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeGestureRight.direction = UISwipeGestureRecognizerDirection.right
        image2.addGestureRecognizer(swipeGestureRight)
        
        let swipeGestureDown = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeGestureDown.direction = UISwipeGestureRecognizerDirection.down
        image2.addGestureRecognizer(swipeGestureDown)
        
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.left
        image2.addGestureRecognizer(swipeGestureLeft)
        
        let swipeGestureUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeGestureUp.direction = UISwipeGestureRecognizerDirection.up
        image2.addGestureRecognizer(swipeGestureUp)
        
        super.viewDidLoad()
        
        image2.image = UIImage(named: "apple.png")
    }
    
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
    
    func changeImage(){
        if (image2.image == UIImage(named: "apple.png")){
            image2.image = UIImage(named: "image1.png")}
        else{
            image2.image = UIImage(named: "apple.png")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
