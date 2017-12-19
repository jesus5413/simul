//
//  SignUpVC.swift
//  simul
//
//  Created by Jesus Nieto on 12/18/17.
//  Copyright © 2017 Jesus Nieto. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {

    @IBOutlet weak var emailTextField: textFieldUI!
    @IBOutlet weak var passwordTextField: textFieldUI!
    @IBOutlet weak var confirmPasswordField: textFieldUI!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func createPressed(_ sender: Any) {
        if passwordTextField.text == confirmPasswordField.text{
            AuthService.instance.registerUser(withEmail: emailTextField.text!, andPass: passwordTextField.text!, on: self, userCreationComplete: {(success, registerError) in
                if success{
                    print("user created")
                }else{
                    print("there was en error")
                }
                
            })
        }else{
            let alerVC = UIAlertController(title: "Password Error", message: "Please check your passwords", preferredStyle: .alert)
            alerVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alerVC, animated: true, completion: nil)
            
        }
        //clears text field
        emailTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordField.text = ""
        
        
    }
    
    

}

extension SignUpVC: UITextFieldDelegate{ }
