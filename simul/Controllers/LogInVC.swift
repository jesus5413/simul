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

    //functions log ins user into the application 
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
    
    @IBAction func newUserPressed(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let signUpVC = storyBoard.instantiateViewController(withIdentifier: "SignUpVC")
        self.present(signUpVC, animated: true, completion: nil)
        
    }
    
    

}

extension LogInVC: UITextFieldDelegate{ }
