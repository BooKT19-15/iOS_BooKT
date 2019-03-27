//
//  MainTabsMenuVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 20/02/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class MainTabsMenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        setupNavBar()
    }
    

    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    //MARK:- Setup view & Setup NavBar
    func setupNavBar(){
        
        navigationController?.setNavigation()
        UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.2558506727, alpha: 1)
        
    }
}
