//
//  OpenCVCameraViewController.swift
//  SetAI
//
//  Created by Timothy Miko on 3/19/16.
//  Copyright © 2016 Kyle Haptonstall. All rights reserved.
//

import UIKit

class OpenCVCameraViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    var camera: CvVideoCamera?
    let openCvWrapper = OpenCVWrapper()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.camera = CvVideoCamera(parentView: self.image)
        self.camera!.delegate = self.openCvWrapper
        self.camera!.defaultAVCaptureDevicePosition = .Back
        self.camera!.defaultAVCaptureSessionPreset = AVCaptureSessionPreset640x480
        self.camera!.defaultAVCaptureVideoOrientation = .Portrait
        self.camera!.defaultFPS = 30
    }
    
    override func viewWillAppear(animated: Bool) {
        if let cam = self.camera {
            cam.start()
        }
    }
}
