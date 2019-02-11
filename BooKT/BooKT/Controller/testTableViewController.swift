//
//  testTableViewController.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 11/02/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class testTableViewController: UIViewController {
   
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            mainView.isHidden = false
            menuView.isHidden = true
        } else if sender.selectedSegmentIndex == 1 {
            mainView.isHidden = true
            menuView.isHidden = false 
        }
    }
}
