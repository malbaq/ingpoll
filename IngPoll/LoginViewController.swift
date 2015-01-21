//
//  LoginViewController.swift
//  IngPoll
//
//  Created by Tom Malary on 1/21/15.
//  Copyright (c) 2015 ProFreX. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var signInCancelledLabel: UILabel!
    
    //the var below suddenly appeared at #120 at 07:40
    var fbLoginView: FBLoginView = FBLoginView(readPermissions: ["email", "public_profile"])

    @IBAction func signIn(sender: AnyObject) {
        
        var permissions = ["public_profile", "email"]
        
        self.signInCancelledLabel.alpha = 0
        
        PFFacebookUtils.logInWithPermissions(permissions, {
            (user: PFUser!, error: NSError!) -> Void in
            if user == nil {
                self.signInCancelledLabel.alpha = 1
                NSLog("Uh oh. The user cancelled the Facebook login.")
            } else if user.isNew {
                NSLog("User signed up and logged in through Facebook!")
            } else {
                NSLog("User logged in through Facebook!")
            }
        })

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if PFUser.currentUser() != nil {
        
            println("logged in")
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
