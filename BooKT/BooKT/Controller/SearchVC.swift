//
//  SearchVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 26/01/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchTableView.dataSource = self
        searchTableView.delegate = self
        navigationController?.setNavigation()
        UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.2558506727, alpha: 1)
    }
    
//    func setupNavbar(){
//        navigationController?.navigationBar.barTintColor = UIColor(red: 235/255, green: 39/255, blue: 72/255, alpha: 1)
//        //navigationController?.navigationBar.prefersLargeTitles = true
//    }
//    func setupNavBarImage() {
//
//        let navBar = navigationController!
//        if let image = UIImage(named: "Image-2"){
//        let imageView = UIImageView(image: image)
//
//        let bannerWidth = navBar.navigationBar.frame.size.width
//        let bannerHeight = navBar.navigationBar.frame.size.height
//
//        let bannerX = bannerWidth / 2 - image.size.width  / 2
//        let bannarY = bannerHeight / 2 - image.size.height / 2
//        imageView.frame = CGRect(x: bannerX, y: bannarY, width: bannerWidth, height: bannerHeight)
//        imageView.contentMode = .scaleAspectFit
//
//        navigationItem.titleView = imageView
//
//        }
    }


extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "KingsFood"
        cell.textLabel?.textColor = UIColor.black
        return cell 
    }
}



extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
}
