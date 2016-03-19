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
       
        let headers: [String: String] = [
            "Authorization" : "Bearer \(self.accessToken!)",
        ]
        
        
        let imageData = UIImageJPEGRepresentation(image, 0.9) //(image)
        let x = imageData!.base64EncodedDataWithOptions(.Encoding64CharacterLineLength)
        
        Alamofire.upload(
            .POST,
            urlPath,
            headers: headers,
            multipartFormData: { multipartFormData in
                multipartFormData.appendBodyPart(data: x, name: "encoded_image")
            },
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON { response in
                        
                        
                        
                        var result  = (response.result.value as! Dictionary<String, AnyObject>)["results"] as! Array<AnyObject>
                        
                        let docID = (result[0] as! Dictionary<String, AnyObject>)["docid"]!
                        let results = (result[0] as! Dictionary<String, AnyObject>)["result"] as!  Dictionary<String,AnyObject>
                        
                        let tags = results["tag"] as! Dictionary<String, Array<AnyObject> >
                        
                        let classes = tags["classes"] as! Array<String>

                        print("docID", docID)
                        print("Classes", classes)
                        
                        
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                }
            }
        )
        
    }
    
    
    
    func addTagsForImage(image : UIImage, tags: String...){
        
        
        
    }
    
    func removeTagsForImage(image: UIImage, tags: String...){
        
    }
    
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    

}