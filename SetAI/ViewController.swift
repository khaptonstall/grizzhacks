//
//  ViewController.swift
//  SetAI
//
//  Created by Kyle Haptonstall on 3/19/16.
//  Copyright © 2016 Kyle Haptonstall. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    let clarifaiClient = ClarifaiClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        clarifaiClient.getToken(){ accessToken in
            print(accessToken)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

