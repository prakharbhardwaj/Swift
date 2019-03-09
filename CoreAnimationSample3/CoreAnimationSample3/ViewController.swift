//
//  ViewController.swift
//  CoreAnimationSample3
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @objc var position = true
    
    @IBOutlet weak var image: UIImageView!
    @IBAction func animate(_ sender: UIButton) {
        
        if (position){  //SAMPLE2
            
            let animation:CABasicAnimation! = CABasicAnimation(keyPath:"position")
            animation.toValue = NSValue(cgPoint:CGPoint(x: 160, y: 200))
            
            //SAMPLE2
            animation.fillMode = kCAFillModeForwards
            animation.isRemovedOnCompletion = false
            let resizeAnimation:CABasicAnimation = CABasicAnimation(keyPath:"bounds.size")
            resizeAnimation.toValue = NSValue(cgSize:CGSize(width: 240, height: 60))
            
            //SAMPLE2
            resizeAnimation.fillMode = kCAFillModeForwards
            resizeAnimation.isRemovedOnCompletion = false
            
            
            //SAMPLE3
            UIView.animate(withDuration: 5.0, animations:{
                //PROPERTIES CHANGES TO ANIMATE
                self.image.alpha = 0.0
                //alpha to zero in 5 seconds
                }, completion: {(value: Bool) in
                    //when finished animation do this..
                    self.image.alpha = 1.0
                    self.image.layer.add(animation, forKey: "position")
                    self.image.layer.add(resizeAnimation, forKey: "bounds.size")
            })
            position = false
        }
        else{
            
            let animation:CABasicAnimation! = CABasicAnimation(keyPath:"position")
            animation.fromValue = NSValue(cgPoint:CGPoint(x: 160, y: 200))
            
            //SAMPLE2
            animation.fillMode = kCAFillModeForwards
            animation.isRemovedOnCompletion = false
            let resizeAnimation:CABasicAnimation = CABasicAnimation(keyPath:"bounds.size")
            resizeAnimation.fromValue = NSValue(cgSize:CGSize(width: 240, height: 60))
            
            //SAMPLE2
            resizeAnimation.fillMode = kCAFillModeForwards
            resizeAnimation.isRemovedOnCompletion = false
            image.layer.add(animation, forKey: "position")
            image.layer.add(resizeAnimation, forKey: "bounds.size")
            
            position = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
