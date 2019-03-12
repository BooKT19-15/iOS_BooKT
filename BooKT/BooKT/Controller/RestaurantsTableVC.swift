//
//  RestaurantsTableVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 29/01/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class RestaurantsTableVC: UITableViewController {
   

    var parallaxOffSetSpeed: CGFloat = 30
    let cellHeight: CGFloat = 250
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 250
        tableView.separatorStyle = .none
        registerCellForIpad()
    }
    
    
    
    
    
    
    
    //MARK:- Setup view & Setup NavBar
    func setupNavBar(){
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
   
    
    var parallaxImageHeight: CGFloat {
        let maxOffSet = (sqrt(pow(cellHeight, 2) + 4 * parallaxOffSetSpeed * self.tableView.frame.height) - cellHeight) / 2
        return maxOffSet + cellHeight
    }
    
    func parallaxOffSet(newOffSSetY: CGFloat, cell: UITableViewCell) -> CGFloat {
        return(newOffSSetY - cell.frame.origin.y) / parallaxImageHeight * parallaxOffSetSpeed
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = tableView.contentOffset.y
        for cell in tableView.visibleCells as! [RestaurantTableCell] {
            cell.parallaxTopConstraint.constant = parallaxOffSet(newOffSSetY: offSetY, cell: cell)
            
        }
    }
    //MARK:- RegisterCells
    func registerCellForIphone(){
        
        tableView.register(iPhoneRestaurantTableViewCell.self, forCellReuseIdentifier: "iPhoneCellRestaurant")
        tableView.register(UINib(nibName: "iPhoneRestaurantTableViewCell", bundle: nil), forCellReuseIdentifier:  "iPhoneCellRestaurant")
        
    }
    
    
    func registerCellForIpad(){
        tableView.register(RestaurantTableCell.self, forCellReuseIdentifier: "RestaurantCell")
        tableView.register(UINib(nibName: "RestaurantTableCell", bundle: nil), forCellReuseIdentifier: "RestaurantCell")
        
    }
    
    
    
    
    
    
    
    //MARK:- TableView Delegates

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantTableCell
        cell.parallaxImageHeight.constant = self.parallaxImageHeight
        cell.parallaxTopConstraint.constant = parallaxOffSet(newOffSSetY: tableView.contentOffset.y, cell: cell)
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //this's a comment that will remind me to dismiss the view using tab bar button
        //self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "gotoRestaurant", sender: self)
    }
    
}
