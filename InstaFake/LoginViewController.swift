//
//  LoginViewController.swift
//  InstaFake
//
//  Created by my mac on 3/31/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
        override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onSignIn(_ sender: Any) {
        
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            if (user != nil){
              print("You are logged in!!!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
            print("Trouble signing in!!!")
        }
      }
    }
   
    
    @IBAction func onSignUp(_ sender: Any) {
        //Create a new Parse user
        let newUser  = PFUser()
        //Extract the text from the username field
        //and the password field and set the username and password of the new user
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        //Sign up the new user in the background
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success{
            print("Yay, created a user!")
                 self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
            print(error?.localizedDescription)
                
            
            }
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
