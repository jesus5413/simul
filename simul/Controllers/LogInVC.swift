//
//  LogInVC.swift
//  simul
//
//  Created by Jesus Nieto on 12/18/17.
//  Copyright © 2017 Jesus Nieto. All rights reserved.
//

import UIKit

class LogInVC: UIViewController {

    @IBOutlet weak var emailField: textFieldUI!
    @IBOutlet weak var passwordField: textFieldUI!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
        
        // Do any additional setup after loading the view.
    }

    @IBAction func logInPressed(_ sender: Any) {
        AuthService.instance.logInUser(withEmail: emailField.text!, andPass: passwordField.text!, on: self, logInComplete: {(success, logInError) in
            if success{
                print("sucessful signing in")
            }else{
                print("error signing in")
            }
            
        })
        
        emailField.text = ""
        passwordField.text = ""
        
    }
    
    
    

}

extension LogInVC: UITextFieldDelegate{ }
