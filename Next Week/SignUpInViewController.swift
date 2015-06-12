//
//  SignUpInViewController.swift
//  Next Week
//
//  Created by Andras Toth on 12/06/15.
//  Copyright (c) 2015 Andras Toth. All rights reserved.
//

import UIKit
import Parse

class SignUpInViewController: UIViewController {

    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBAction func SignUp() {
        var userName = usernameInput.text.lowercaseString
        var userPassword = passwordInput.text
        
        // Create new user
        var user = PFUser()
        user.username = userName
        user.password = userPassword
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if error == nil {
                dispatch_async(dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("signIn", sender: self)
                }
            } else {
                println(error!.userInfo!["error"])
            }
        }
    }
    
    @IBAction func SignIn() {
        var userName = usernameInput.text.lowercaseString
        var userPassword = passwordInput.text
        
        if userName != "" && userPassword != "" {
            PFUser.logInWithUsernameInBackground(userName, password: userPassword) {
                (user: PFUser?, error: NSError?) -> Void in
                if error == nil && user != nil {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.performSegueWithIdentifier("signIn", sender: self)
                    }
                } else {
                    println(error!.userInfo!["error"])
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
