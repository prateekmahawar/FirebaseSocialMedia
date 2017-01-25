//
//  PostCellTVC.swift
//  SocialMedia
//
//  Created by Prateek Mahawar on 21/01/17.
//  Copyright © 2017 Prateek Mahawar. All rights reserved.
//

import UIKit
import Firebase

class PostCellTVC: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLabel: UILabel!
    
    var post : Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    func configureCell(post:Post, img: UIImage? = nil) {
        self.post = post
        self.caption.text = post.caption
        self.likesLabel.text = "\(post.likes)"
        
        if img != nil {
            self.postImg.image = img
        } else {
            
                let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
                ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data,error) in
                    if error != nil {
                        print("PostCellVC: Unable to download image")
                    } else {
                        print("PostCellVC: Imaage downloaded from Firebase Storage")
                        if let imgData = data {
                            if let img = UIImage(data: imgData) {
                                self.postImg.image = img
                                FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                            }
                        }
                    }
                    
            })
        }
        
    }
    
    
}
