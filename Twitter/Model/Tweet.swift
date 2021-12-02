//
//  Tweet.swift
//  Twitter
//
//  Created by Neha Tripathi on 27/10/21.
//

import Foundation

struct Tweet {
    let caption: String
    let tweetID: String
    let uid: String
    let likes: Int
    let timestamp: Date!
    let retweets: Int
    let user: User
    
    init(tweetID: String, user: User, dictionary: [String: Any]) {
        self.tweetID = tweetID
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.retweets = dictionary["retweets"] as? Int ?? 0
        self.uid = dictionary["uid"] as? String ?? ""
        
        if let timestamp =  dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        } else {
            self.timestamp = Date.now
        }
        
        self.user = user
    }
}
