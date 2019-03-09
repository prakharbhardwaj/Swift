//
//  ViewController.swift
//  CoreImageCIDetector
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var filePath: NSString = ""
    var image = CIImage()
    
    override func viewDidLoad() {
        filePath = Bundle.main.path(forResource: "emotions", ofType: "jpg")! as NSString
        let fileNameAndPath = URL(fileURLWithPath: filePath as String)
        image = CIImage(contentsOf:fileNameAndPath)!
        let context = CIContext(options: nil)
        let options = NSDictionary(object: CIDetectorAccuracyHigh, forKey: CIDetectorAccuracy as NSCopying)
        let detector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: options as? [String : AnyObject] )
        let features: NSArray = detector!.features(in: image, options: [CIDetectorSmile:true,CIDetectorEyeBlink:true]) as NSArray
        let imageView = UIImageView(image: UIImage(named: "emotions.jpg"))
        self.view.addSubview(imageView)
        
        //auxiliar view to invert.
        let vistAux = UIView(frame: imageView.frame)
        for faceFeature in features {
            
            //Detection
            let smile = (faceFeature as AnyObject).hasSmile
            let rightEyeBlinking = (faceFeature as AnyObject).rightEyeClosed
            let leftEyeBlinking = (faceFeature as AnyObject).leftEyeClosed
            
            //Face location
            let faceRect = (faceFeature as AnyObject).bounds
            let faceView = UIView(frame: faceRect!)
            faceView.layer.borderWidth = 2
            faceView.layer.borderColor = UIColor.red.cgColor
            let faceWidth:CGFloat = faceRect!.size.width
            let faceHeight:CGFloat = faceRect!.size.height
            vistAux.addSubview(faceView)
            
            //Smile location
            if (smile==true) {
                let smileView = UIView(frame: CGRect(x: (faceFeature as AnyObject).mouthPosition.x-faceWidth*0.18, y: (faceFeature as AnyObject).mouthPosition.y-faceHeight*0.1, width: faceWidth*0.4, height: faceHeight*0.2))
                smileView.layer.cornerRadius = faceWidth*0.1
                smileView.layer.borderWidth = 2
                smileView.layer.borderColor = UIColor.green.cgColor
                smileView.layer.backgroundColor = UIColor.green.cgColor
                smileView.layer.opacity = 0.5
                vistAux.addSubview(smileView)
            }
            
            //Right eye location
            let rightEyeView = UIView(frame: CGRect(x: (faceFeature as AnyObject).rightEyePosition.x-faceWidth*0.2, y: (faceFeature as AnyObject).rightEyePosition.y-faceWidth*0.2, width: faceWidth*0.4, height: faceWidth*0.4))
            rightEyeView.layer.cornerRadius = faceWidth*0.2
            rightEyeView.layer.borderWidth = 2
            rightEyeView.layer.borderColor = UIColor.red.cgColor
            if (rightEyeBlinking==true){
                rightEyeView.layer.backgroundColor = UIColor.yellow.cgColor
            }else{
                rightEyeView.layer.backgroundColor = UIColor.red.cgColor
            }
            rightEyeView.layer.opacity = 0.5
            vistAux.addSubview(rightEyeView)
            
            //Left eye location
            let leftEyeView = UIView(frame: CGRect(x: (faceFeature as AnyObject).leftEyePosition.x-faceWidth*0.2, y: (faceFeature as AnyObject).leftEyePosition.y-faceWidth*0.2, width: faceWidth*0.4, height: faceWidth*0.4))
            leftEyeView.layer.cornerRadius = faceWidth*0.2
            leftEyeView.layer.borderWidth = 2
            leftEyeView.layer.borderColor = UIColor.blue.cgColor
            if (leftEyeBlinking==true){
                leftEyeView.layer.backgroundColor = UIColor.yellow.cgColor
            }else{
                leftEyeView.layer.backgroundColor = UIColor.blue.cgColor
            }
            leftEyeView.layer.opacity = 0.5
            vistAux.addSubview(leftEyeView)
        }
        
        self.view.addSubview(vistAux)
        
        //Invert coords
        vistAux.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
