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
    
    var accessToken:String?
    
    
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
            self.accessToken = accessToken
            completion(accessToken: accessToken)
        }
        
    }
    
    func getTagsForImage(image: UIImage /*, completion: (tags:String...) -> () */){
        
        
        let urlPath = "https://api.clarifai.com/v1/tag"
        
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
            let fileURL = documentsURL.URLByAppendingPathComponent("\(NSDate()).png")
            if let pngImageData = UIImagePNGRepresentation(image) {
                pngImageData.writeToURL(fileURL, atomically: false)
              
                
                let headers: [String: String] = [
                    "Authorization" : "Bearer \(self.accessToken!)",
                ]
                
                print(self.accessToken)
                let params: [String: AnyObject] = [
                    "encoded_data" : "\(fileURL)"
                ]
                
                
                let request = Alamofire.request(.POST, urlPath, parameters: params, encoding: .URL, headers: headers)
                
                
                request.responseJSON { (response) -> Void in
                    print(response)
                    print(response.result)
                    var result  = response.result.value as! Dictionary<String, AnyObject>
                    //var resultJSON = JSON(data: reponse.data)
                    
                   // completion(tags: "Completed")
                }
                
        }
        
      

    }
    
    func addTagsForImage(image : UIImage, tags: String...){
        
    }
    
    func removeTagsForImage(image: UIImage, tags: String...){
        
    }
    

}