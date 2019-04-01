//
//  LoginVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 18/03/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        AuthService.instance.loginUser(withEmail: email.text!, andPassword: password.text!) { (success, loginError) in
            if success {
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                print(String(describing: loginError?.localizedDescription))
            }
    }
}


}

// I added all the delegation through the stroyboard for each textField 
extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
