//
//  AuthService.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 31/03/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    
    static let instance = AuthService()
    
    func registerUser(withEmail email: String, andPassword password: String, andMobile mobile: String,name: String, userCreationComplete: @escaping (_ status : Bool, _ error: Error?) ->()) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            guard let user = user else {
                userCreationComplete(false,error)
                return
            }
            let userData = ["email": user.user.email, "mobile" :mobile , "name": name]
            DataService.instance.createDBUser(uid: user.user.uid , userData: userData)
            userCreationComplete(true,nil)
        }
    }
    
    
    func loginUser(withEmail email: String, andPassword password: String, userLoginComplete: @escaping (_ status: Bool, _ error: Error?) -> () ){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil{
                userLoginComplete(false, error)
                return
            }
            userLoginComplete(true,nil)
        }
    }
    
    
    func signout(){
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error)
        }
    }

}
