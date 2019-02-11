//
//  XYZTableViewController.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 11/02/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class XYZTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let segment: UISegmentedControl = UISegmentedControl(items: ["First", "Second"])
//        segment.sizeToFit()
//        segment.tintColor = UIColor(red:0.99, green:0.00, blue:0.25, alpha:1.00)
//        segment.selectedSegmentIndex = 0;
//        segment.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "ProximaNova-Light", size: 15)!], for: .normal)
//        self.navigationItem.titleView = segment
        navigationController?.navigationBar.backgroundColor = .black
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell 
    }
}
