//
//  ComposePostVC.swift
//  simul
//
//  Created by Jesus Nieto on 12/20/17.
//  Copyright © 2017 Jesus Nieto. All rights reserved.
//

import UIKit
import Firebase

class ComposePostVC: UIViewController {

    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        postButton.bindToKeyBoard()
        userNameLabel()
        self.hideKeyboardTapped()
        

        // Do any additional setup after loading the view.
    }

    @IBAction func sendButtonPressed(_ sender: Any) {
        
        if textView.text != nil && textView.text != "Compose..."{
            postButton.isEnabled = false
            DataService.instance.uploadPost(withMessage: textView.text, withGroupKey: nil, sendComplete: { (isComplete) in
                if isComplete{
                        self.postButton.isEnabled = true
                        self.dismiss(animated: true, completion: nil)
                        print("message sent")
                    
                }else{
                    self.postButton.isEnabled = true
                    print("there was an error")
                }
                
            })
        }
    }
    
    
    @IBAction func closeBurronPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // get the username to post it on top of the compose view
    func userNameLabel(){
        DataService.instance.REF_BASE.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let userName = dictionary["userName"] as? String
                self.userLabel.text = userName
                
            }
            
            
        }, withCancel: nil)
        
    }

    

}

extension ComposePostVC: UITextViewDelegate{
    //resets text view when type
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        
    }
    
    
}
