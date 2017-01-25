//
//  Post.swift
//  SocialMedia
//
//  Created by Prateek Mahawar on 23/01/17.
//  Copyright © 2017 Prateek Mahawar. All rights reserved.
//

import Foundation

class Post {
    
    private var _caption: String!
    private var _imageUrl:String!
    private var _likes:Int!
    private var _postKey:String!
    
    var caption: String {
        return _caption
    }
    
    var imageUrl: String {
        if _imageUrl != nil {
        return _imageUrl
        } else {
            return "gs://socialmediatest-1fee7.appspot.com/post-pics/chest-1.jpg"
        }
    }
    
    var likes: Int {
        return _likes
    }
    
    var postKey: String {
        return _postKey
    }
    
    init(caption: String, imageUrl:String, likes: Int) {
        self._caption = caption
        self._likes = likes
        self._imageUrl = imageUrl
    }
    
    init(postKey:String, postData: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String {
            self._caption = caption
        }
        
        if let imageUrl = postData["imageurl"] as? String{
            self._imageUrl = imageUrl
        }
        
        if let likes = postData["likes"] as? Int {
            self._likes = likes
        }
    }
    
}
