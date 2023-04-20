//
//  Task.swift
//  FireBaseTraining
//
//  Created by Александр Макаров on 13.04.2023.
//

import Firebase

struct Task: Hashable {
    let title: String
    let userId: String
    let ref: DatabaseReference?
    var completed: Bool = false
    
    init(title: String, userId: String, ref: DatabaseReference?, completed: Bool) {
        self.title = title
        self.userId = userId
        self.ref = ref
        self.completed = completed
    }
    
    init(title: String, userId: String) {
        self.title = title
        self.userId = userId
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        title = snapshotValue["title"] as! String
        userId = snapshotValue["userId"] as! String
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
    }
    
    func convertToDictionary() -> Any {
        return ["title": title, "userId": userId, "completed": completed]
    }
}
