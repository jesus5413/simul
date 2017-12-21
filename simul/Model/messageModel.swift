//
//  messageModel.swift
//  simul
//
//  Created by Jesus Nieto on 12/20/17.
//  Copyright © 2017 Jesus Nieto. All rights reserved.
//

import Foundation

class messageModel{
    private var _content: String
    private var _userNameID: String
    
    var content: String{
        return _content
    }
    
    var userNameID: String{
        return _userNameID
    }
    
    init(content: String, userNameID: String) {
        self._content = content
        self._userNameID = userNameID
    }
    
}
