//
//  ViewController.swift
//  CoreImage sample
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {
    
    //SLIDER TO FIRST AND SECOND FILTER
    //when you do slider value change
    //then push in filter button  "sepia" or "vignette" to apply it
    @objc var sliderValue: Float = 0.0
    
    @IBOutlet weak var myImage: UIImageView!
    
    @IBAction func sepia(_ sender: UIButton) {
        applyfilter(1);
    }
    
    @IBAction func vignette(_ sender: UIButton) {
        applyfilter(2);
    }
    
    @IBAction func invert(_ sender: UIButton) {
        applyfilter(3);
    }
    
    @IBAction func photo(_ sender: UIButton) {
        applyfilter(4);
    }
    
    @IBAction func perspective(_ sender: UIButton) {
        applyfilter(5);
    }
    
    @IBAction func gaussian(_ sender: UIButton) {
        applyfilter(6);
    }
    
    @IBAction func slider(_ sender: UISlider) {
        sliderValue = sender.value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func applyfilter(_ numberFilter: Int) {
        
        let filePath : String = Bundle.main.path(forResource: "image", ofType: "jpg")!
        let fileUrl : URL = URL (fileURLWithPath: filePath as String)
        let inputImage : CIImage = CIImage (contentsOf: fileUrl)!
        
        switch numberFilter {
        case 1:
            let filter = CIFilter(name: "CISepiaTone")
            //var filter : CIFilter = CIFilter (name: "CISepiaTone")
            filter!.setValue(inputImage, forKey: kCIInputImageKey)
            filter!.setValue(sliderValue, forKey: "InputIntensity")
            let outputImage : CIImage = filter!.value(forKey: kCIOutputImageKey) as! CIImage
            let img : UIImage = UIImage (ciImage: outputImage)
            myImage.image = img
        case 2:
            let filter : CIFilter = CIFilter (name: "CIVignette")!
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            filter.setValue(sliderValue, forKey: "InputRadius")
            filter.setValue(sliderValue, forKey: "InputIntensity")
            let outputImage : CIImage = filter.value(forKey: kCIOutputImageKey) as! CIImage
            let img : UIImage = UIImage (ciImage: outputImage)
            myImage.image = img
        case 3:
            let filter : CIFilter = CIFilter (name: "CIColorInvert")!
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            let outputImage : CIImage = filter.value(forKey: kCIOutputImageKey) as! CIImage
            let img : UIImage = UIImage (ciImage: outputImage)
            myImage.image = img
        case 4:
            let filter : CIFilter = CIFilter (name: "CIPhotoEffectMono")!
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            let outputImage : CIImage = filter.value(forKey: kCIOutputImageKey) as! CIImage
            let img : UIImage = UIImage (ciImage: outputImage)
            myImage.image = img
        case 5:
            let filter : CIFilter = CIFilter (name: "CIPerspectiveTransform")!
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            let outputImage : CIImage = filter.value(forKey: kCIOutputImageKey) as! CIImage
            let img : UIImage = UIImage (ciImage: outputImage)
            myImage.image = img
        case 6:
            let filter : CIFilter = CIFilter (name: "CIGaussianBlur")!
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            let outputImage : CIImage = filter.value(forKey: kCIOutputImageKey) as! CIImage
            let img : UIImage = UIImage (ciImage: outputImage)
            myImage.image = img
        default:
            print("test")
        }
    }

}
