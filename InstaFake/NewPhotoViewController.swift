//
//  NewPhotoViewController.swift
//  InstaFake
//
//  Created by my mac on 4/1/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class NewPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    
    @IBOutlet weak var chosenPicture: UIImageView!

    @IBOutlet weak var captionTextField: UITextField!
    
    
    @IBAction func onSubmit(_ sender: Any) {
        
        
        
        //Before we send the image to Parse lets refine it so it does not go over 
        // the 10mb limit
        
        let resizedImage = chosenPicture.image
        
        //Get the caption text
        let captionText = captionTextField.text
        
        Post.postUserImage(image: resizedImage, withCaption: captionText) { (success: Bool, error: Error?) in
            if (success){
                print("Successfully uploaded the image")
            }else{
                print("Error uploading the image")
            }
        }
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    @IBAction func onTapPicChooser(_ sender: UITapGestureRecognizer) {
        print("Recognized the tap!")
        //Create the image picker
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            print("Camera is available")
            //Get the image from the camera
            vc.sourceType = .camera
        }else{
            vc.sourceType = .photoLibrary
        
        }
       
        //Show the image picker
        self.present(vc, animated: true, completion: nil)
        
        
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        //Put the chosen image as the preview image
        chosenPicture.image = editedImage
        //Dismiss the image picker
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage{
        let resizedImage = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizedImage.contentMode = UIViewContentMode.scaleAspectFill
        resizedImage.image = image
        
        //Update the image on the view controller to the new size
        UIGraphicsBeginImageContext(resizedImage.frame.size)
        resizedImage.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
