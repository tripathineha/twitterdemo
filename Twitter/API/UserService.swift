//
//  UserService.swift
//  Twitter
//
//  Created by Neha Tripathi on 13/10/21.
//

import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser(uid: String? = nil, completion: @escaping(User)-> Void) {
        var userId: String
        if let uid = uid {
            userId = uid
        } else {
            guard let currentUserId = Auth.auth().currentUser?.uid else {
                return
            }
            userId = currentUserId
        }
        
        REF_USERS.child(userId).observeSingleEvent(of: .value) { snapshot in
            print("SNAPSHOT: \(snapshot)")
            guard let userInfo = snapshot.value as? [String: AnyObject] else {
                return
            }
           // let user = try? decoder.decode(User.self, from: userInfo.description.data(using: .utf8)!)
            let user = User(uid: userId, dictionary: userInfo)
            completion(user)
        }
    }
}
