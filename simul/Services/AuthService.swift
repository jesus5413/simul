//
//  AuthService.swift
//  simul
//
//  Created by Jesus Nieto on 12/18/17.
//  Copyright © 2017 Jesus Nieto. All rights reserved.
//

import Foundation
import Firebase


//extension UIApplication {
//
//    static func topViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
//
//        if let nav = base as? UINavigationController {
//            return topViewController(base: nav.visibleViewController)
//        }
//
//        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
//            return topViewController(base: selected)
//        }
//
//        if let presented = base?.presentedViewController {
//            return topViewController(base: presented)
//        }
//
//        return base
//    }
//}

class AuthService{
    static let instance = AuthService()
    
    
    //function lets the user register
    func registerUser(withEmail email: String, andPass password: String,userName username: String,on controller: UIViewController, userCreationComplete: @escaping (_ status: Bool, _ error: Error?)-> ()){
        email.hasSuffix("my.utsa.edu")
        if  !password.isEmpty{
        
                    FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
                            guard let user = user else{
                                
                                let alert = UIAlertController(title: "User exists.", message: "Please Sign in", preferredStyle: UIAlertControllerStyle.alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                                controller.present(alert, animated: true, completion: nil)
                                userCreationComplete(false, error)
                                return
                            }
                        
                        
                            let userData = ["provider": user.providerID, "email": user.email, "userName": username]
                            DataService.instance.createDBUser(uid: user.uid, userData: userData)
                            FIRAuth.auth()?.currentUser?.sendEmailVerification(completion: {(error) in })
                        
                            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                            let logInVC = storyBoard.instantiateViewController(withIdentifier: "LogInVC")
                            let alert = UIAlertController(title: "Register Successful!", message: "Please verify your email by clicking on sent link!", preferredStyle: UIAlertControllerStyle.alert)
                            let okAction = UIAlertAction(title: "Ok", style: .default){
                            (_) in
                                controller.present(logInVC, animated: true, completion: nil)
                                
                            }
                            alert.addAction(okAction)
                            controller.present(alert, animated: true, completion: nil)
                            userCreationComplete(true, nil)
                            }
        }else{
            let alert = UIAlertController(title: "Register Error", message: "Please use your UTSA email", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            controller.present(alert, animated: true, completion: nil)
            
        }
        
        
    }
    
    
    //function logins the user, checks for email verification
    func logInUser(withEmail email: String, andPass password: String,on controller: UIViewController, logInComplete: @escaping (_ status: Bool, _ error: Error?)-> ()){
        //email.hasSuffix("my.utsa.edu")
        if  !password.isEmpty{
                FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                    
                    if error != nil{
                        let alert = UIAlertController(title: "Error", message: "Please create an account or check your password", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        controller.present(alert, animated: true, completion: nil)
                        logInComplete(false, error)
                        return
                        
                    }else if let user = FIRAuth.auth()?.currentUser {
                        if !user.isEmailVerified{
                            let alertVC = UIAlertController(title: "Error", message: "Sorry. Your email address has not yet been verified. Do you want us to send another verification email?", preferredStyle: .alert)
                            let alertActionOkay = UIAlertAction(title: "Yes", style: .default) {
                                (_) in
                                user.sendEmailVerification(completion: nil)
                            }
                            let alertActionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                            
                            alertVC.addAction(alertActionOkay)
                            alertVC.addAction(alertActionCancel)
                            controller.present(alertVC, animated: true, completion: nil)
                            
                        }else{
                            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                            let mainAppVC = storyboard.instantiateViewController(withIdentifier: "mainAppVC")
                            controller.present(mainAppVC, animated: true, completion: nil)
                            //controller.dismiss(animated: true, completion: nil)
                            
                            print("user signed in. Move to main app view controller, log in view dismissed")
                            
                        }
                    }
                    
                })
        }else{
            let alert = UIAlertController(title: "Error", message: "Please cheack your credientials", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            controller.present(alert, animated: true, completion: nil)
            
        }
        
        
    }
    
    
    
    
}
