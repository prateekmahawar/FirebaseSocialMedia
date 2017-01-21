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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 338.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCellTVC
        
    }

    @IBAction func SignOutBtnTapped(_ sender: Any) {
        
        KeychainWrapper.standard.remove(key: KEY_UID)
        print("FeedVC: ID removed from keychain")
        try! FIRAuth.auth()?.signOut()
        print("FeedVC: LogOut Successful")
        
        dismiss(animated: true, completion: nil)
        
    }
  

}
