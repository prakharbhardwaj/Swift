//
//  KeyboardViewController.swift
//  SampleCustomKeyboard
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }
    
    
    @objc func centerButton(_: AnyObject) {
        let text = "🐶"
        let proxy = self.textDocumentProxy as UIKeyInput
        proxy.insertText(text)
    }
    @objc func pushButton(_: AnyObject) {
        let laugh = ":-))))))))"
        let proxy = self.textDocumentProxy as UIKeyInput
        proxy.insertText(laugh)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        let viewXib = UINib(nibName: "CustomKeyboard", bundle: nil)
        self.view = viewXib.instantiate(withOwner: self, options: nil)[0] as! UIView;
        for v in self.view.subviews {
            if v.isKind(of: UIButton.self) {
                let w = v as! UIButton
                if w.currentTitle == "Center" {
                    w.addTarget(self, action: #selector(KeyboardViewController.centerButton(_:)), for: .touchDown)
                } else {
                    w.addTarget(self, action: #selector(KeyboardViewController.pushButton(_:)), for: .touchDown)
                }
            }
        }
        NSLog("NSLog can't be seen in xcode console. See README")
        
    
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
    
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard?", comment: "Title for 'Next Keyboard' button"), for: UIControlState())
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
    
        self.nextKeyboardButton.addTarget(self, action: #selector(UIInputViewController.advanceToNextInputMode), for: .touchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)
    
        let nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0)
        let nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: UIControlState())
    }

}
