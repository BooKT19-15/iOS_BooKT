//
//  RestaurantsTableVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 29/01/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage
class RestaurantsTableVC: UITableViewController {
   
    var cuisine: Cuisine!
    var restaurant: Restaurants!
    var restaurantsList = [Restaurants]()
    let cellHeight: CGFloat = 250
    
    var Mainimages: [String]!
    
    
    
    
    //MARK:- View Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        SVProgressHUD.show()
        self.title = cuisine.type
        
        setupTableView()
        registerCell()
        //setupNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
       
        if let cuisine = cuisine {
         fetchingRestaurants(cuisineType: cuisine.type)
        }
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
    func registerCell(){
        tableView.register(RestaurantTableCell.self, forCellReuseIdentifier: "RestaurantCell")
        tableView.register(UINib(nibName: "RestaurantTableCell", bundle: nil), forCellReuseIdentifier: "RestaurantCell")
        
    }
    
    
    //MARK:- Back Bar Button
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    
    
    
    
    
    
    //MARK:- Fetching Data
    
    func fetchingRestaurants(cuisineType: String){
        DataService.instance.getRestaurantInfo(cuisineType: cuisineType) { (returnedRestaurants) in
            self.restaurantsList = returnedRestaurants
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    
    
    
    
    func fetchRestaurantImages(id: String){
        DataService.instance.getRestaurantImages(id: id) { (returnedImages) in
            self.Mainimages = returnedImages
            self.performSegue(withIdentifier: "gotoRestaurant", sender: self)
            SVProgressHUD.dismiss()
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
        //print(restaurantsList[indexPath.row].image)
        let restaurant = restaurantsList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantTableCell
        cell.configureCell(name: restaurant.name, image: restaurant.image, open: restaurant.open, close: restaurant.close, location: restaurant.location, price: restaurant.price)
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fetchRestaurantImages(id: restaurantsList[indexPath.row].id)
        restaurant = restaurantsList[indexPath.row]
        SVProgressHUD.show()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoRestaurant" {
            let restaurantVC = segue.destination as! RestaurantVC
            restaurantVC.restaurant = restaurant
            restaurantVC.images = Mainimages
            restaurantVC.cuisine = cuisine.type
        }
    }
}



