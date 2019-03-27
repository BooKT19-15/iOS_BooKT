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
   
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_JEDDAH: DatabaseReference {
        return _REF_JEDDAH
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
    func getRestaurantInfo(handler: @escaping(_ restaurants:[Restaurants]) ->()){
        var restaurantsList = [Restaurants]()
        //American
        REF_JEDDAH.child("Cuisine").child("ids").child("American").observe(.childAdded, with: { snapshot in
            
            let restaurantsSnap = snapshot.childSnapshot(forPath: "restaurant_info")
            //print(restaurantsSnap.childrenCount)
            let name = restaurantsSnap.childSnapshot(forPath: "restaurant_name").value as! String
            let open = restaurantsSnap.childSnapshot(forPath: "restaurant_open").value as! String
            let image = restaurantsSnap.childSnapshot(forPath: "restaurant_image").value as! String
            let close = restaurantsSnap.childSnapshot(forPath: "restaurant_close").value as! String
            let price = restaurantsSnap.childSnapshot(forPath: "restaurant_price").value as! String
            let location = restaurantsSnap.childSnapshot(forPath: "restaurant_location").value as! String
            let status = restaurantsSnap.childSnapshot(forPath: "status").value as! String
            let id = restaurantsSnap.childSnapshot(forPath: "firebase_id").value as! String
            
            let restaurant = Restaurants(name: name, close: close, open: open, image: "one", location: location, price: price, id: id)
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
    }


