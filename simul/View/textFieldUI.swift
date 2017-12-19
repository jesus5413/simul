/*
 File maniupualtes text fields
 in the login and signup views
 */

import UIKit

class textFieldUI: UITextField {

    
    
    override func awakeFromNib() {
        textFieldBorder()
        placeHolderColor()
        super.awakeFromNib()
    }
    
    //function maniuplates border with single line at the bottom 
    func textFieldBorder(){
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
       
        
    }
    // function changes the place holder color to white
    func placeHolderColor(){
        let placeHolder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        self.attributedPlaceholder = placeHolder
    }
    

}
