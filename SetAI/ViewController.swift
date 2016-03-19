//
//  ViewController.swift
//  SetAI
//
//  Created by Kyle Haptonstall on 3/19/16.
//  Copyright © 2016 Kyle Haptonstall. All rights reserved.
//

import UIKit
import Alamofire

import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PickerControllerDelegate {
    
    @IBOutlet weak var containerView: UIView!
    var picker = UIImagePickerController()
    let clarifaiClient = ClarifaiClient()
    var card: Card = Card(color: .Red, fill: .Striped, count: 1, shape: .Oval)
    let cardPicker = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("cardPicker") as! PickerViewController
    
    override func viewDidLoad() {

        clarifaiClient.getToken(){ accessToken in
            print(accessToken)
        }
    }
    
    func finishedPickingCard(card: Card) {
        
        self.card = card
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.mediaTypes = [kUTTypeImage as String]
        }
        
        picker.delegate = self
        picker.allowsEditing = false
        picker.showsCameraControls = false
        
        self.addChildViewController(picker)
        containerView.addSubview(picker.view)
        containerView.layer.masksToBounds = true
        
    }

    @IBAction func pick(sender: AnyObject) {
        cardPicker.delegate = self
        presentViewController(cardPicker, animated: true, completion: nil)
    }
    
    @IBAction func scan(sender: AnyObject) {
        
        picker.takePicture()
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            
            
            clarifaiClient.getTagsForImage(image){ docID in
                print(docID)
                
                self.clarifaiClient.addTagsForImage(docID, tags:
                    self.card.color.rawValue,
                    self.card.shape.rawValue,
                    self.card.fill.rawValue,
                    "\(self.card.count)")
            }
            
            
        
        }
    }
}

