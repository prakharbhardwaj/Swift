//
//  ViewController.swift
//  iCloud
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var celdas: NSMutableArray = NSMutableArray()
    var container = FileManager.default.url(forUbiquityContainerIdentifier: nil)
    var metadataQuery : NSMetadataQuery!
    
    @IBOutlet weak var collectionView: UICollectionView!
  
    @IBAction func deletePhotos(_ sender: UIBarButtonItem) {
        
        removeImagesFromICloud()
    }
    
    @IBAction func choosePhotos(_ sender: UIBarButtonItem) {
        let action = UIAlertController (title: "Photos", message: "Select source", preferredStyle: UIAlertControllerStyle.actionSheet)
        action.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            print("Choose camera")
            self.getPhoto(true)
        }))
        action.addAction(UIAlertAction(title: "Galery", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            print("Choose galery")
            self.getPhoto(false)
        }))
        self.present(action, animated: true, completion: nil)
    }
    
    func getPhoto (_ camera: Bool){
        let picker = UIImagePickerController()
        picker.delegate = self
        if (camera){
            picker.sourceType = UIImagePickerControllerSourceType.camera
        }else{
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            print("Choose from galery 2")
        }
        picker.allowsEditing = false
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        let fullImage = (info as NSDictionary)[UIImagePickerControllerOriginalImage] as! UIImage
        print("Choose from galery 3")
        savePhotoICloud(fullImage)
    }

    func savePhotoICloud (_ image: UIImage){
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "dd_MM_yy_hh_mm_ss"
        let photoName = NSString (format: "PHOTO_%@", df.string(from: date))
        
        if (container != nil){
            let fileURLiCloud = container!.appendingPathComponent("Documents").appendingPathComponent(photoName as String)
            let photo = DocumentPhoto (fileURL: fileURLiCloud)
            photo.image = image
            photo.save(to: fileURLiCloud, for: UIDocumentSaveOperation.forCreating, completionHandler: { (success) -> Void
                in
                self.celdas.add(image)
                print("Choose from galery 4")
                self.collectionView.reloadData()
            })
        }
    }
    
    func removeImagesFromICloud (){
        if (container != nil){
            self.metadataQuery = NSMetadataQuery()
            self.metadataQuery.searchScopes = NSArray (object: NSMetadataQueryUbiquitousDocumentsScope) as [AnyObject]
            
            let predicate = NSPredicate(format: "%K like 'PHOTO*'", NSMetadataItemFSNameKey)
            self.metadataQuery.predicate = predicate
            
            NotificationCenter.default.addObserver(self, selector: #selector(ViewController.queryDeleted(_:)), name: NSNotification.Name.NSMetadataQueryDidFinishGathering,
                object: self.metadataQuery)
            
            self.metadataQuery.start()
        }
    }
    
    func loadImagesFromICloud (){
        if (container != nil){
            self.metadataQuery = NSMetadataQuery()
            self.metadataQuery.searchScopes = NSArray (object: NSMetadataQueryUbiquitousDocumentsScope) as [AnyObject]
            
            let predicate = NSPredicate(format: "%K like 'PHOTO*'", NSMetadataItemFSNameKey)
            self.metadataQuery.predicate = predicate
            
            NotificationCenter.default.addObserver(self, selector: #selector(ViewController.queryFinished(_:)), name: NSNotification.Name.NSMetadataQueryDidFinishGathering, object: self.metadataQuery)
            self.metadataQuery.start()
        }
    }
    
    func queryFinished(_ notification: Notification) {
        let mq = notification.object as! NSMetadataQuery
        mq.disableUpdates()
        mq.stop()
        celdas.removeAllObjects()
        for i in 0..<mq.resultCount {
            let result = mq.result(at: i) as! NSMetadataItem
           // var name = result.valueForAttribute(NSMetadataItemFSNameKey) as! NSString
            let url = result.value(forAttribute: NSMetadataItemURLKey) as! URL
            let document : DocumentPhoto! = DocumentPhoto(fileURL: url)
            
            document?.open(completionHandler: { (success) -> Void in
                if (success == true){
                    self.celdas.add(document.image)
                    print("addobject in queryfinished")
                    self.collectionView.reloadData()
                }
            }) }
    }
    
    func queryDeleted(_ notification: Notification) {
        let mq = notification.object as! NSMetadataQuery
        mq.disableUpdates()
        mq.stop()
        celdas.removeAllObjects()
        for i in 0..<mq.resultCount {
            let result = mq.result(at: i) as! NSMetadataItem
            let url = result.value(forAttribute: NSMetadataItemURLKey) as! URL
            let document : DocumentPhoto! = DocumentPhoto(fileURL: url)
            
            let fileManager = FileManager()
            do {
                try fileManager.removeItem(at: document.fileURL)
            } catch _ {
            }
            
            self.collectionView.reloadData()
            
            document?.open(completionHandler: { (success) -> Void in
                if (success == true){
                    self.collectionView.reloadData()
                }
            }) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadImagesFromICloud ()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier:NSString = "CollectionCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier as String, for: indexPath) 
        let imageView:UIImageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = celdas.object(at: (indexPath as NSIndexPath).row) as? UIImage
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return celdas.count
    }
    
}
