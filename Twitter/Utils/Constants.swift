//
//  Constants.swift
//  Twitter
//
//  Created by Neha Tripathi on 05/10/21.
//

import Firebase

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let REF_TWEETS = DB_REF.child("tweets")
