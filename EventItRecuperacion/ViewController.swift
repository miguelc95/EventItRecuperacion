//
//  ViewController.swift
//  Event it
//
//  Created by Luis Felipe Salazar on 10/10/15.
//  Copyright © 2015 Luis Felipe Salazar. All rights reserved.
//
//f2bfadfa33bd94905e53db831e2f9104
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var nombre = ""
    var apellido = ""
    var correo = ""
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if (FBSDKAccessToken.currentAccessToken() == nil){
            print("Error de inicio de sesion")
        }
        else{
            print("Sesion iniciada")
        }
        
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            // self.performSegueWithIdentifier("FBSignUpSegue", sender: self)
            print("sesion iniciada")
        }
        
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["id,public_profile", "email", "user_friends"]
        
        loginButton.center.y = self.view.center.y + 200
        loginButton.center.x=self.view.center.x
        loginButton.delegate = self
        self.view.addSubview(loginButton)
        (FBSDKProfile.enableUpdatesOnAccessTokenChange(true))
        
        if let token = FBSDKAccessToken.currentAccessToken() {
            fetchProfile()
        }
        
        
        
        
        /*  var fbSession = PFFacebookUtils.session()
         var accessToken = fbSession.accessTokenData.accessToken
         let url = NSURL(string: "https://graph.facebook.com/me/picture?type=large&return_ssl_resources=1&access_token="+accessToken)
         let urlRequest = NSURLRequest(URL: url!)
         
         NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
         
         // Display the image
         let image = UIImage(data: data)
         self.imgProfile.image = image
         
         }
         */
        
        
    }
    
    
    
    func fetchProfile(){
        print("Fetch profile")
        let parameters = ["fields":"id,email,first_name,last_name,picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler{(connection,result, error)->Void in
            if  error != nil{
                print(error)
                return
            }
            var userID = result["id"] as! NSString
            var facebookProfileUrl = "https://graph.facebook.com/\(userID)/picture?type=large"
            if let id = result["id"] as? String{
                print(id)
            }
            
            
            if let email = result["email"] as? String{
                self.url = facebookProfileUrl
                print(email)
                self.correo=email
                self.nombre = (result["first_name"] as? String)!
                self.apellido = (result["last_name"] as? String)!
                
                // print(result["picture.type(large)"] as? String)
                
                self.performSegueWithIdentifier("FBSignUpSegue", sender: self)
            }
        }
    }
    
    
    
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("Sesion terminada")
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.Portrait]
    }
    
    override func prepareForSegue(segue : UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="FBSignUpSegue" {
            
            let secondVC : NewProfileViewController = segue.destinationViewController as! NewProfileViewController
            
            secondVC.nombre=nombre
            secondVC.apellido=apellido
            secondVC.Correo=correo
            secondVC.urlfoto=url
            
        }
    }
    
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        fetchProfile()
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
        }
    }
    
}

