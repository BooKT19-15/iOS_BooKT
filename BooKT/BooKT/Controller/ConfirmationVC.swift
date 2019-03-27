//
//  ConfirmationVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 06/02/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class ConfirmationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigation()
        UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.2558506727, alpha: 1)
        
    }
    
    
    func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
