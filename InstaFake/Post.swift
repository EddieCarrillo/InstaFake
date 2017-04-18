//
//  Post.swift
//  InstaFake
//
//  Created by my mac on 4/1/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import UIKit
import Parse


class Post: NSObject {
    
    
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?){
        //Create Parse object PFObject which represents a Post
        let post = PFObject(className: "Post")
        
        //Add the relevant fields to the Post object
        post["media"] = getPFFileFromImage(image: image)
        post["author"] = PFUser.current()
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        
        //Save the object (following function will save the object in Parse asynchonously)
        post.saveInBackground(block: completion)
    
    }
    
    /*This function converts a UIImage to a PFFile*/
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile?{
        //Check to see if the image is not nil
        if let image = image{
        // Get the image and check to see that is not nil
            if let imageData = UIImagePNGRepresentation(image){
                return PFFile(name: "image.png", data: imageData)
            }
        }
        
        return nil
    }
    
    
}
