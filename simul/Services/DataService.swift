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
    
    
    
    
    
}
