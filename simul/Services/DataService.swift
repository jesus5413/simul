//
//  DataService.swift
//  simul
//
//  Created by Jesus Nieto on 12/18/17.
//  Copyright © 2017 Jesus Nieto. All rights reserved.
//

import Foundation
import Firebase

//connects with firebase database
let DB_BASE = FIRDatabase.database().reference()

class DataService{
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE // database reference
    private var _REF_USER = DB_BASE.child("users") // user reference
    private var _REF_GROUPS = DB_BASE.child("groups") // groups reference
    private var _REF_FEED = DB_BASE.child("feed") // feed reference
    
    //public values
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_USER: FIRDatabaseReference {
        return _REF_USER
    }
    
    var REF_GROUPS: FIRDatabaseReference {
        return _REF_GROUPS
    }
    
    var REF_FEED: FIRDatabaseReference {
        return _REF_FEED
    }
    
    //creates firbase user
    func createDBUser(uid: String, userData: Dictionary<String, Any>){
        REF_USER.child(uid).updateChildValues(userData)
        
    }
    
//    func getUserNameFromDataBase() -> String {
//        var userName: String
//        REF_BASE.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).observe(.value, with: { (snapshot) in
//            if let dictionary = snapshot.value as? [String: AnyObject]{
//                userName = dictionary["userName"] as? String
//
//            }
//
//        }, withCancel: nil)
//
//        return userName
//
//
//    }
    
    // uploads post and labels the username in the databasebelow the post 
    func uploadPost(withMessage message: String, withGroupKey groupKey: String?, sendComplete: @escaping (_ status: Bool)-> () ){
        if groupKey != nil{
            //send to specified gourp/group ref
            
        }else{
            
            REF_BASE.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject]{
                    let userName = dictionary["userName"] as? String
                    //print(userName)
                    self.REF_FEED.childByAutoId().updateChildValues(["content": message, "sendUserName": userName])
                }
                
                
            }, withCancel: nil)
            
            //REF_FEED.childByAutoId().updateChildValues(["content": message, "sendUserName": userName])
            sendComplete(true)
        }
        
        
    }
    
    
    
    func getAllFeedMessages(handler: @escaping (_ messages: [messageModel] ) -> ()){
        var messageArray = [messageModel]()
        REF_FEED.observeSingleEvent(of: .value, with: { (feedMessageSnapshot) in
            
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [FIRDataSnapshot] else{
                return
            }
            for message in feedMessageSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let userName = message.childSnapshot(forPath: "sendUserName").value as! String
                let message = messageModel(content: content, userNameID: userName)
                messageArray.append(message)
            }
            
            messageArray = messageArray.reversed() // reverses the order so latest post can be at the top
            handler(messageArray)
            
        }, withCancel: nil)
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
