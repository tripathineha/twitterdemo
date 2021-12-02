//
//  TweetService.swift
//  Twitter
//
//  Created by Neha Tripathi on 27/10/21.
//

import Firebase

struct TweetService {
    static let shared = TweetService()
    
    func uploadTweet(caption: String, completion: @escaping ( Error?, DatabaseReference)-> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let values: [String : Any] = ["uid": uid,
                      "timestamp": Int(NSDate().timeIntervalSince1970),
                      "likes": 0,
                      "retweets": 0,
                      "caption": caption]

        REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
    
    func fetchTweets(completion: @escaping ([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        REF_TWEETS.observe(.childAdded) { snapshot in
            print("TweetSnaphot: \(snapshot)")
            
            guard let dictionary = snapshot.value as? [String: Any] else {
                return
            }
            let tweetId = snapshot.key
            let uid =  dictionary["uid"] as? String ?? ""
            UserService.shared.fetchUser(uid: uid) { user in
                let tweet = Tweet(tweetID: tweetId, user: user, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
            
        }
    }
}
