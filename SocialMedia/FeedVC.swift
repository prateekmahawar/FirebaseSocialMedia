//
//  FeedVC.swift
//  SocialMedia
//
//  Created by Prateek Mahawar on 20/01/17.
//  Copyright © 2017 Prateek Mahawar. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func SignOutBtnTapped(_ sender: Any) {
        
        KeychainWrapper.standard.remove(key: KEY_UID)
        print("FeedVC: ID removed from keychain")
        try! FIRAuth.auth()?.signOut()
        print("FeedVC: LogOut Successful")
        
        dismiss(animated: true, completion: nil)
        
    }
  

}
