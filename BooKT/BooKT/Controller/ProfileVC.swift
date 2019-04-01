//
//  ProfileVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 18/03/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var SignupButton: UIBarButtonItem!
    let active = ["One","Two","Three","One","Two","Three"]
    let inActive = ["X","Y","Z","X","Y","Z","X","Y","Z","X","Y","Z","X","Y","Z","X","Y","Z"]
    lazy var displayArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        segmentControl.selectedSegmentIndex = 0
        displayArray = active
        segmentControl.addTarget(self, action: #selector(handleSegmentChange        ), for: .valueChanged)
     
    }
    
    @objc func handleSegmentChange(){
        switch segmentControl.selectedSegmentIndex {
        case 0:
            displayArray = active
        default:
            displayArray = inActive
        }
        tableView.reloadData()
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    @IBAction func signupButtonPressed(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "gotoSignup", sender: self)
    }
    @IBAction func signoutButtomPressed(_ sender: UIBarButtonItem) {
        AuthService.instance.signout()
    }
}


extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        
        return cell 
    }
}
