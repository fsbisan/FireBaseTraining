//
//  User.swift
//  FireBaseTraining
//
//  Created by Александр Макаров on 13.04.2023.
//

import Foundation
import Firebase

struct User {
    let uid: String
    let email: String
    
    init(user: Firebase.User) {
        self.uid = user.uid
        self.email = user.email!
    }
}
