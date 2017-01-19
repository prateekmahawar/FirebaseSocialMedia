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
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var passField: FancyField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("SignInVC: ID Found in keychain")
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
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
                if let user = user {
                    self.completeSignIn(id: user.uid)
                }
            }
        })
    }
    
    @IBAction func SignInBtnPressed(_ sender: Any) {
        if let email = emailField.text , let pass = passField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pass, completion: { (user, error) in
                if error == nil {
                    print("SignInVC: Email User auth with Firebase")
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                } else  {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pass, completion: { (user, error) in
                        if error != nil {
                            print("SignInVC: Email User unable to authenticate tih firebase")
                        } else {
                            print("SignInVC: Successfully Authenticated with Firebase")
                            if let user = user {
                                self.completeSignIn(id: user.uid)
                            }
                        }
                    })
                }
            })
        }
        
    }
    
    func completeSignIn(id:String) {
       let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("SignInVC: Data saved to keychain\(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)

    }
}

