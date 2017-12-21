//
//  feedCell.swift
//  simul
//
//  Created by Jesus Nieto on 12/20/17.
//  Copyright © 2017 Jesus Nieto. All rights reserved.
//

import UIKit

class feedCell: UITableViewCell {

   
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var content: UILabel!
    
    func configureCell(userName: String, content: String){
        self.userName.text = userName
        self.content.text = content
        
    }
    
    
    
    
    

}
