//
//  ViewController.swift
//  ChatPeerToPeer
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController,  MCSessionDelegate, MCBrowserViewControllerDelegate,UITextFieldDelegate {
    var browserVC:MCBrowserViewController!
    var advertiserAssistant: MCAdvertiserAssistant!
    var session: MCSession!
    var peerID: MCPeerID!
    
    @IBAction func button(_ sender: UIButton) {
        showBrowserVC()
    }
    
    @IBOutlet weak var textBox: UITextView!
    @IBOutlet weak var sendText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMultipeer()
    }
    
    func setUpMultipeer(){
        peerID = MCPeerID(displayName: UIDevice.current.name)
        session = MCSession(peer: peerID)
        session.delegate = self
        browserVC = MCBrowserViewController(serviceType: "chat", session: session)
        browserVC.delegate = self
        advertiserAssistant = MCAdvertiserAssistant(serviceType: "chat", discoveryInfo: nil, session: session)
        advertiserAssistant.start()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func sendMessage(){
        let message:String = self.sendText.text!
        self.sendText.text = ""
        let data :Data = message.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        var error:NSError?
        do {
            try self.session.send(data, toPeers:
                self.session.connectedPeers, with: MCSessionSendDataMode.unreliable)
        } catch let error1 as NSError {
            error = error1
        }
        NSLog("%@", error!)
        self.messageReception(message as NSString, peer: self.peerID)
    }
    
    func messageReception(_ message:NSString, peer:MCPeerID){
        var finalText:String
        if(peer == self.peerID){
            finalText = "\nYo: \(message)"
        }
        else{
            finalText = "\n\(peer.displayName): \(message)"
        }
        self.textBox.text =
            self.textBox.text + (finalText as String)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        self.sendMessage()
        return true
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState){
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID){
        let message = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        DispatchQueue.main.async(execute: {self.messageReception(message!, peer: peerID)})
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID:MCPeerID){
    }
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress){
    }
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?){
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController){
        self.dismissBrowserVC()
    }
    
    // Notifies delegate that the user taps the cancel button.
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController){
        self.dismissBrowserVC()
    }
    
    func showBrowserVC(){
        self.present(self.browserVC, animated: true, completion: nil)
    }
    
    func dismissBrowserVC(){
        self.browserVC.dismiss(animated: true, completion: nil) }
    
}
