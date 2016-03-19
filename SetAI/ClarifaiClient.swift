//
//  ClarifaiClient.swift
//  SetAI
//
//  Created by Kyle Haptonstall on 3/19/16.
//  Copyright © 2016 Kyle Haptonstall. All rights reserved.
//

import Foundation
import Alamofire

class ClarifaiClient {
    
    func getToken(completion: (accessToken:String) -> ()){
        let params:[String: AnyObject] = [
            "grant_type": "client_credentials",
            "client_id": "sB5HiQv3_ib2eZgBHgvrGzjjRLN1SYkVBKDVFCOv",
            "client_secret": "MqMmzUiZotZwLPxgwXtH4SYAXO6XdbGnRpDHQTO2",
        ]
        let urlPath = "https://api.clarifai.com/v1/token/"
        
        
        let request = Alamofire.request(.POST, urlPath, parameters: params, encoding: .URL, headers: nil)
        request.responseJSON { (response) -> Void in
            print(response.result)
            var result  = response.result.value as! Dictionary<String, AnyObject>
            //var resultJSON = JSON(data: reponse.data)
            let accessToken = result["access_token"] as! String
            // return accessToken
            completion(accessToken: accessToken)
        }
        
    }
    

}