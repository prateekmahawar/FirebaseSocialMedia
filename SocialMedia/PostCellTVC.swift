//
//  PostCellTVC.swift
//  SocialMedia
//
//  Created by Prateek Mahawar on 21/01/17.
//  Copyright © 2017 Prateek Mahawar. All rights reserved.
//

import UIKit

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
    
    func configureCell(post:Post) {
        self.post = post
        self.caption.text = post.caption
        self.likesLabel.text = "\(post.likes)"
        
    }
    
    
}
