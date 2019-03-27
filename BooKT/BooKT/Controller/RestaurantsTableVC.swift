//
//  RestaurantsTableVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 29/01/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class RestaurantsTableVC: UITableViewController {
   
    var restaurantsList = [Restaurants]()
    let cellHeight: CGFloat = 250
    
    
    
    
    
    
    //MARK:- View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerCellForIpad()
        //setupNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        fetchData()
        setupNavBar()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavBar()
    }
    
    
    //MARK:- Setup TableView
    func setupTableView() {
        tableView.rowHeight = 280
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = #colorLiteral(red: 0.1129432991, green: 0.1129470244, blue: 0.1129450426, alpha: 1)
    }
    
    
    
    //MARK:- Setup view & Setup NavBar
    func setupNavBar(){
        
         navigationController?.setNavigation()
         UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.2558506727, alpha: 1)
        
    }
  

    
    //MARK:- RegisterCells
    func registerCellForIpad(){
        tableView.register(RestaurantTableCell.self, forCellReuseIdentifier: "RestaurantCell")
        tableView.register(UINib(nibName: "RestaurantTableCell", bundle: nil), forCellReuseIdentifier: "RestaurantCell")
        
    }
    
    
    
    
    
    
    //MARK:- Back Bar Button
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
        //dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    //MARK:- Fetching Data
    func fetchData(){
        DataService.instance.getRestaurantInfo { (returnedRestaurant) in
            self.restaurantsList = returnedRestaurant
            self.tableView.reloadData()
        }
    }
    
    
    
    
    
    
    
    
    

    //MARK:- TableView Delegates

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let restaurant = restaurantsList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantTableCell
        cell.configureCell(name: restaurant.name, image: restaurant.image, open: restaurant.open, close: restaurant.close, location: restaurant.location, price: restaurant.price)
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoRestaurant", sender: self)
    }
    
}



