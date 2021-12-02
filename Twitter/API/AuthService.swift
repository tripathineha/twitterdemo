//
//  AuthService.swift
//  Twitter
//
//  Created by Neha Tripathi on 05/10/21.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    func loginUser(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference)->Void) {
        
        
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
            if let error = error {
                print("DEBUG: Error is \(error.localizedDescription)")
                return
            }
            guard let uid = result?.user.uid else { return }
            guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
            let filename = NSUUID().uuidString
            let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
            
            storageRef.putData(imageData, metadata: nil) { metadata, error in
                storageRef.downloadURL { url, error in
                    guard let profileImageUrl = url?.absoluteString else {
                        return
                    }
                    let values = ["email": credentials.email,
                                  "username": credentials.username,
                                  "fullname": credentials.fullname,
                                  "profileImageUrl": profileImageUrl]
                    
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion) 
                }
            }
        }
    }
}
