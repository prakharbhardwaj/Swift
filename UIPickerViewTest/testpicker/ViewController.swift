//
//  ViewController.swift
//  testpicker
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    var pickerView = UIPickerView()
    let toolBar = UIToolbar()
    var myView = UIView()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        textField.delegate = self
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 300))
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        pickerView.showsSelectionIndicator = true
        pickerView.isUserInteractionEnabled = true
        
        toolBar.frame = CGRect(x: 0, y: 200, width: view.frame.width, height: 30)
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        myView = UIView(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 400))
        self.view.addSubview(myView)
        myView.addSubview(pickerView)
        myView.addSubview(toolBar)
        
        myView.isHidden = true
    
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        
        let ownerBookingVoidViewController = OwnerBookingVoidViewController(nibName: "OwnerBookingVoidViewController", bundle: nil)
        self.present(ownerBookingVoidViewController, animated: true, completion: nil)
    }
    
    
    func donePicker() {
        textField.text = "cancel"
        myView.isHidden = true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        myView.isHidden = false
        
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: - Picker view delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium)
        label.text = "cancel"
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return   5
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = "cancel"
        return
    }


}

