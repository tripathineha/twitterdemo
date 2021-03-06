//
//  TweetViewModel.swift
//  Twitter
//
//  Created by Neha Tripathi on 17/11/21.
//

import Foundation
import UIKit

struct TweetViewModel {
    let tweet: Tweet
    let user: User
    
    var profileImageUrl: URL? {
        return tweet.user.profileImageURL
    }
    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullname,
                                              attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
       title.append(NSAttributedString(string: " @\(user.username)",
                                       attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                      .foregroundColor: UIColor.lightGray]))
        return title
    }
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
}
