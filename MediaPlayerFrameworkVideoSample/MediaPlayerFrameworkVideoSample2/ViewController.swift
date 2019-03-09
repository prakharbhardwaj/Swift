//
//  ViewController.swift
//  MediaPlayerFrameworkVideoSample2
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            let destination = segue.destination as! AVPlayerViewController
            let bundle = Bundle.main
            //our video is 02.mov
            let moviePath = bundle.path(forResource: "02", ofType: "mov")
            let url = URL(fileURLWithPath: moviePath!)
            destination.player = AVPlayer(url: url)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
