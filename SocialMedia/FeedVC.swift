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
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("FeedVC: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                        
                    }
                }
                
            }
            
            self.tableView.reloadData()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 338.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        print("FeedVC: \(post.caption)")
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
