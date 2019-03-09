//
//  ViewController.swift
//  Animations-Gestures
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var penguinView: UIImageView!
    
    @objc var frames: NSArray?
    var dieCenter: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let image1 = UIImage(named:"penguin_walk01")!
        let image2 = UIImage(named:"penguin_walk02")!
        let image3 = UIImage(named:"penguin_walk03")!
        let image4 = UIImage(named:"penguin_walk04")!
        
        let frames: [UIImage] = [image1, image2, image3, image4]
        
        penguinView.animationDuration = 0.15;
        penguinView.animationRepeatCount = 2;
        penguinView.animationImages = frames;
        
        //walk right
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.walkRight(_:)))
        swipeGestureRight.direction = UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(swipeGestureRight)
        
        //walk left
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.walkLeft(_:)))
        swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.left
        view.addGestureRecognizer(swipeGestureLeft)
        
        //jump
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.jump(_:)))
        view.addGestureRecognizer(tap)
        
        //longPress
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPress(_:)))
        view.addGestureRecognizer(longPress)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

@objc func walkLeft(_ send: UIGestureRecognizer) {
    print("walk left");
    //CHECK IF OUT OF SCREEN
    if (penguinView.center.x < 0.0) {
        penguinView.center = CGPoint(x: view.frame.size.width, y: penguinView.center.y);
    }
    
    //FLIP AROUND FOR WALKING LEFT
    self.penguinView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0);
    
    //START WALK ANIMATION
    penguinView.startAnimating()
    
    //MOVE THE IMAGE VIEW TO LEFT
    UIView.animate(withDuration: 0.6, animations: { () -> Void in
        self.penguinView.center = CGPoint(x: self.penguinView.center.x - 30, y: self.penguinView.center.y);
    })
}

@objc func walkRight(_ send: UIGestureRecognizer) {
    print("walk right");
    if (self.penguinView.center.x > self.view.frame.size.width) {
        self.penguinView.center = CGPoint(x: 0, y: self.penguinView.center.y);
    }
            
    self.penguinView.transform = CGAffineTransform.identity;
    penguinView.startAnimating()
    UIView.animate(withDuration: 0.6, animations: { () -> Void in
        self.penguinView.center = CGPoint(x: self.penguinView.center.x + 30, y: self.penguinView.center.y)
    })
}

@objc func jump(_ send: UIGestureRecognizer) {
    penguinView.startAnimating()
    
    UIView.animate(withDuration: 0.25, animations: { () -> Void in
        self.penguinView.center = CGPoint(x: self.penguinView.center.x, y: self.penguinView.center.y - 50)
    }, completion: { (finished: Bool) -> Void in
        self.jumpBack()
    })
}
    
@objc func jumpBack() {
    UIView.animate(withDuration: 0.25, animations: { () -> Void in
    self.penguinView.center = CGPoint(x: self.penguinView.center.x, y: self.penguinView.center.y + 50)
    })
}

@objc func longPress(_ send: UIGestureRecognizer) {
    if(send.state == .began) {
        UIView.animate(withDuration: 0.33, animations: { () -> Void in
            self.dieCenter = self.penguinView.center
            self.penguinView.center = CGPoint(x: self.penguinView.center.x, y: self.view.frame.size.height)
        }, completion: { (finished: Bool) -> Void in
            self.longPressBack()
        })
    }
}

@objc func longPressBack() {
    UIView.animate(withDuration: 0.25, animations: { () -> Void in
        self.penguinView.center = self.dieCenter!
    })
}

}
