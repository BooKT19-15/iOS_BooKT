//
//  DataService.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 23/03/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import Foundation
import Firebase


let DB_BASE = Database.database().reference()
class DataService {
    
    static let instance = DataService()
    private var _REF_BASE = DB_BASE
    private var _REF_JEDDAH = DB_BASE.child("Country").child("Saudi Arabia").child("cities").child("Jeddah")
    private var _REF_RESTAURANT = DB_BASE.child("Restaurants")
    
    private var _REF_USERS = DB_BASE.child("Users")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_JEDDAH: DatabaseReference {
        return _REF_JEDDAH
    }
    
    var REF_RESTAURANT: DatabaseReference {
        return _REF_RESTAURANT
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
   
    
    
    
    
    
    //MARK:- Fetch Data for Home View
    func getCuisines(handler: @escaping (_ cuisineTypes: [Cuisine]) ->()){
        var cuisineList = [Cuisine]()
        
        REF_JEDDAH.child("Cuisine").child("Cuisine_names").observeSingleEvent(of: .value) { (CuisineSnapshot) in
            guard let CuisineSnapshot = CuisineSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for cuisine in CuisineSnapshot {
                print(cuisine)
             let type = cuisine.childSnapshot(forPath: "type").value as! String
             let cuisineObject = Cuisine(type: type)
             cuisineList.append(cuisineObject)
            }
            handler(cuisineList)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK:- Fetch Data for Restaurants View
    func getRestaurantInfo(cuisineType: String,handler: @escaping(_ restaurants:[Restaurants]) ->()){
        var restaurantsList = [Restaurants]()
        //American
        REF_JEDDAH.child("Cuisine").child("ids").child(cuisineType).observe(.childAdded, with: { snapshot in
            
            let restaurantsSnap = snapshot.childSnapshot(forPath: "restaurant_info")
            //print(restaurantsSnap.childrenCount)
            let name = restaurantsSnap.childSnapshot(forPath: "restaurant_name").value as! String
            let open = restaurantsSnap.childSnapshot(forPath: "restaurant_open").value as! String
            let image = restaurantsSnap.childSnapshot(forPath: "restaurant_image").value as! String
            let close = restaurantsSnap.childSnapshot(forPath: "restaurant_close").value as! String
            let price = restaurantsSnap.childSnapshot(forPath: "restaurant_price").value as! String
            let location = restaurantsSnap.childSnapshot(forPath: "restaurant_location").value as! String
            //let status = restaurantsSnap.childSnapshot(forPath: "status").value as! String
            let id = restaurantsSnap.childSnapshot(forPath: "firebase_id").value as! String
            
            let restaurant = Restaurants(name: name, close: close, open: open, image: image, location: location, price: price, id: id)
            restaurantsList.append(restaurant)

            
            handler(restaurantsList)
            })
        }
    
    
    
    func getReviews(handler: @escaping(_ reviews: UInt) ->()) {
        REF_JEDDAH.child("Cuisine").child("ids").child("American").observe(.value) { (snapshot) in
            let reviewSnapshot = snapshot.childSnapshot(forPath: "reviews")
            print(reviewSnapshot.childrenCount)
        }
    }
    
    
    
    
    func getRestaurantImages(id: String, handler: @escaping(_ restaurant: [String]) ->()){
        REF_RESTAURANT.child(id).child("imageList").observe(.value) { (RestaurantSnapshot) in
            print(id)
            var resaurantImage = [String]()
            guard let RestaurantSnapshot = RestaurantSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for restaurants in RestaurantSnapshot {
                let image = restaurants.childSnapshot(forPath: "image").value as! String
                print(image)
                let restaurantObject = RestaurantImages(image: image)
                resaurantImage.append(restaurantObject.image)
            }
            handler(resaurantImage)
        }
    }
    
    
    func getMenu(id:String,handler: @escaping(_ menus: [MainMenu]) ->()){
        REF_RESTAURANT.child(id).child("menuItems").observe(.childAdded) { (snapshot) in
            var mainMenu = [MainMenu]()
            var menu = [Menu]()
            var listName = [String]()
            
            let name = snapshot.childSnapshot(forPath: "menuCategory").value as! String
            print(name,"MMMMMnameMMMMMM")
            listName.append(name)
            
            let menuSnapshot = snapshot.childSnapshot(forPath: "menuItems")
            print(id)
            //for _ in 0..<snapshot.childrenCount{
                for i in 0..<menuSnapshot.childrenCount{
                    
                    let item = menuSnapshot.childSnapshot(forPath: "\(i)")
                    let nameItem = item.childSnapshot(forPath: "name").value as! String
                    let price = item.childSnapshot(forPath: "price").value as! String
                    let description = item.childSnapshot(forPath: "description").value as! String
                    let image = item.childSnapshot(forPath: "image").value as! String
                    print("NAME",nameItem,"\n","PRICE",price,"\n","DES",description,"\n","IMAGE",image)
                    menu.append(Menu(name: nameItem, description: description, price: price, image: image))
                    mainMenu.append(MainMenu(name: listName[0], isExpandable: false, menu: menu))
                    handler(mainMenu)
                }
           // }//mainMenu.append(MainMenu(name: name!, isExpandable: false, menu: menu))
            print(menu.count,"COUNTER")
            print(mainMenu.count,"COUNT")
            //handler(mainMenu)
        }
    }
    
    
//    func getRestaurantImages22(handler: @escaping(_ restaurant: [String]) ->()){
//
//        REF_JEDDAH.child("Cuisine").child("ids").child("French").observe(.childAdded) { (RestaurantSnapshot) in
//            var resaurantImage = [String]()
//            let x = RestaurantSnapshot.childSnapshot(forPath: "imageList")
//            for i in 0..<x.childrenCount {
//                let newPath = x.childSnapshot(forPath: "\(i)")
//                let image = newPath.childSnapshot(forPath: "image").value as! String
//                resaurantImage.append(image)
//                //print(image)
//            }
//
//            handler(resaurantImage)
//        }
//    }
    
    
    
    
    func createDBUser(uid: String, userData: Dictionary<String,Any>){
        REF_USERS.child(uid).child("profile_info").updateChildValues(userData)
    }
}


