//
//  SignUpViewController.swift
//  IngPoll
//
//  Created by Tom Malary on 1/21/15.
//  Copyright (c) 2015 ProFreX. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var profileImage: UIImageView!
    
    @IBAction func signUpButtonPressed(sender: AnyObject) {
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var user = PFUser.currentUser()
        
        //Get the fb profile info and save to parse
        var FBSession = PFFacebookUtils.session()
        
        var accessToken = FBSession.accessTokenData.accessToken
        
        var url = NSURL(string: "https://graph.facebook.com/me/picture?type=large&return_ssl_resources=1&access_token="+accessToken)
        
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
            response, data, error in
            
            let image = UIImage(data: data)
            
            self.profileImage.image = image
            
            user["profileImage"] = data
            
            user.save()
            
            FBRequestConnection.startForMeWithCompletionHandler({
                connection, result, error in
                
                println(result)
                
                user["first_name"] = result["first_name"]
                user["last_name"] = result["last_name"]
                user["name"] = result["name"]
                user["email"] = result["email"]
                user.save()
                
            })
            
        })

        // Do any additional setup after loading the view.
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
