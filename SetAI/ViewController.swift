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

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var containerView: UIView!
    var picker = UIImagePickerController()
    let clarifaiClient = ClarifaiClient()
    
    override func viewDidLoad() {

        clarifaiClient.getToken(){ accessToken in
            print(accessToken)
        }
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

    
    @IBAction func scan(sender: AnyObject) {
        
        picker.takePicture()
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            self.clarifaiClient.getTagsForImage(image)
            /*
            self.clarifaiClient.getTagsForImage(image) { tags in
               // print(tags)
            } */
            //print("Got image!")
        }
    }
}

