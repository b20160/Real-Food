//
//  User.swift
//  Real Food
//
//  Created by Jonathan Green on 3/14/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import Foundation
import UIKit
import Parse
import SwiftEventBus

class User {
    
    func signUp(userName:String,passWord:String,email:String,image:UIImage){
        
        let imageData = NSData(data: UIImageJPEGRepresentation(image, 0.4)!)
        let file = PFFile(data: imageData)
        
        let user = PFUser()
        user.username = userName
        user.password = passWord
        user.email = email
        user["ProfileImage"] = file
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
                
                print(errorString)
                
                SwiftEventBus.post("signUp", sender: succeeded)
                
            } else {
                
                // Hooray! Let them use the app now.
                
                SwiftEventBus.post("signUp", sender: succeeded)
                
                print("User Created")
            }
        }
    }
    
    func login(userName:String,PassWord:String){
        
        PFUser.logInWithUsernameInBackground(userName, password:PassWord) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                
                SwiftEventBus.post("login", sender: true)
                // Do stuff after successful login.
                
            } else {
                
                SwiftEventBus.post("login", sender: false)
                // The login failed. Check error to see why.
            }
        }
    }
    
    func logout(){
        
        PFUser.logOut()
    }
}