//
//  ViewController.swift
//  GestureDoubleTab
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
	
	override func viewDidLoad() {
		let tapGesture = UITapGestureRecognizer(target: self, action:
			#selector(ViewController.handleTap(_:)))
		tapGesture.numberOfTapsRequired = 2;
		image.addGestureRecognizer(tapGesture)
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func handleTap(_ sender : UIGestureRecognizer) {
        if (sender.view?.contentMode == UIViewContentMode.scaleAspectFit){
            sender.view?.contentMode = UIViewContentMode.center
        }else{
            sender.view?.contentMode = UIViewContentMode.scaleAspectFit
        }
	}
}
