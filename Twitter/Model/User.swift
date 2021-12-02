//
//  User.swift
//  Twitter
//
//  Created by Neha Tripathi on 13/10/21.
//

import Foundation

struct User {
    let fullname: String
    let email: String
    let username: String
    var profileImageURL: URL?
    let uid: String
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        if let imageUrl = dictionary["profileImageUrl"] as? String,
           let profileImageURL = URL(string: imageUrl) {
            self.profileImageURL = profileImageURL
        }
        self.fullname = dictionary["fullname"] as? String ?? ""
    }
    
    
}
