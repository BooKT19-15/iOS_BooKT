//
//  SearchVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 26/01/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.dataSource = self
        searchTableView.delegate = self 
        
    }
//    func setupNavBarImage() {
//
//        let navBar = navigationController!
//        let image = UIImage(named: "Image-2")
//        let imageView = UIImageView(image: image)
//
//        let bannerWidth = navBar.navigationBar.frame
//
//    }
//




}



extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "KingsFood"
        cell.textLabel?.textColor = UIColor.black
        return cell 
    }
}
