//
//  SignupVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 18/03/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var mobile: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func registerButtonPressed(_ sender: UIButton) {
        if name.text != nil && email.text != nil && password.text != nil && mobile.text != nil {
            AuthService.instance.registerUser(withEmail: email.text!, andPassword: password.text!, andMobile: mobile.text!, name: name.text!) { (success, error) in
                if error != nil {
                    print("Problem")
                }
            }
        }
        
    }
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoLogin", sender: self)
    }
}



// I added all the delegation through the stroyboard for each textField 
extension SignupVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
