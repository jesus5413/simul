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
            let userName = emailTextField.text!.prefix(6)
            print(userName)
            
            AuthService.instance.registerUser(withEmail: emailTextField.text!, andPass: passwordTextField.text!,userName: String(userName), on: self, userCreationComplete: {(success, registerError) in
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
    
    @IBAction func alreadyUserPRessed(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let LogInVC = storyBoard.instantiateViewController(withIdentifier: "LogInVC")
        self.present(LogInVC, animated: true, completion: nil)
        
    }
    

}

extension SignUpVC: UITextFieldDelegate{ }
