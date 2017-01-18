//
//  ViewController.swift
//  SocialMedia
//
//  Created by Prateek Mahawar on 15/01/17.
//  Copyright © 2017 Prateek Mahawar. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result,error) in
            if error != nil {
                print("SignInVC: Unable to Authenticate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("SignInVC: User Cancelled FB Authentication")
            } else {
                print("SignInVC: Successfuly Authenticated with facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("SignInVC: Unable to authenticate with firebase - \(error)")
            } else {
                print("SignInVC: Successfull auth with Firebase")
            }
        })
    }

}

