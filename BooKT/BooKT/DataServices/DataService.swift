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
    //var status_main : Bool!
    
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
    
    
    
    
    
    
    
    
    //MARK:- GET REVIEWS
    func getReviews(handler: @escaping(_ reviews: UInt) ->()) {
        REF_JEDDAH.child("Cuisine").child("ids").child("American").observe(.value) { (snapshot) in
            let reviewSnapshot = snapshot.childSnapshot(forPath: "reviews")
            print(reviewSnapshot.childrenCount)
        }
    }
    
    
    
    //MARK: GET RESTAURANT IMAGES
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
    
    
    
    
    
    //MARK:- GET MENU
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
            print(menu.count,"COUNTER")
            print(mainMenu.count,"COUNT")
    
        }
    }
    
    
    
    
    
    
    
    
    //MARK:- GET SECTIONS
    func getSections(id: String, handler: @escaping(_ sectionList: [String])->()){
        var sections = [String]()
        REF_RESTAURANT.child(id).child("restaurantDetails").observe(.value) { (snapshot) in
            let section = snapshot.childSnapshot(forPath: "sections").value as! String
            let newString = section
            
            if newString.elementsEqual("Single + Family") {
                sections.append("single")
                sections.append("family")
            } else if newString.elementsEqual("Single") {
                sections.append("single")
            } else if newString.elementsEqual("Family") {
                sections.append("family")
            } else {
                print("ERROR")
            }
            handler(sections)
        }
    }
    
    //MARK:- GET SEATS
    func getSeats(id: String, section: String, handler: @escaping(_ seatList: [Int])->()){
        
        if section.elementsEqual("family"){
            REF_RESTAURANT.child(id).child("tableListFamily").observe(.value) { (snapshot) in
                let tables = snapshot.childSnapshot(forPath: "tables").value as! String
                let fullString = tables;
                let result = fullString.split(separator: ",")
                let intArray = result.map { Int($0) ?? 1}
                print(intArray)
                handler(intArray.sorted())
            }
        }else if section.elementsEqual("single"){
            REF_RESTAURANT.child(id).child("tableListSingle").observe(.value) { (snapshot) in
                let tables = snapshot.childSnapshot(forPath: "tables").value as! String
                let fullString = tables;
                let result = fullString.split(separator: ",")
                print(result)
                let intArray = result.map { Int($0) ?? 1}
                print(intArray)
                handler(intArray.sorted())
            }
        }
    }
    
    
    
    
    
    
//    //MARK:- Reservation Functions
//    func checkReservation(id: String,max:String,year:Int,month: Int,day: Int,hour: Int,section: String,seatNumber: Int, user: User, additionalInfo: String, flag: Bool) {
//        DB_BASE.child("Reservation").child(id).child("sections").child(section).child("T\(seatNumber)").child("date").child("\(year)").child("\(month)").child("\(day)").child("\(hour)").observeSingleEvent(of: .value) { (snapshot) in
//            
//            //check if current selected time is full
//            var status = false
//            if Int(snapshot.childrenCount) >= Int(max)! {
//                status = true
//                print("if", status)
//            }else {
//                status = false
//                print("elseif", status)
//            }
//            
//            // if current selected time is NOT full
//            if !status {
//                
//                var status_two = false
//                
//                // check if NEXT hour is full
//                DB_BASE.child("Reservation").child(id).child("sections").child(section).child("T\(seatNumber)").child("date").child("\(year)").child("\(month)").child("\(day)").child("\(hour+1)").observeSingleEvent(of: .value) { (snapshot2) in
//                    
//                    if Int(snapshot2.childrenCount) >= Int(max)! {
//                        status_two = true
//                    }
//                    
//                    // if next hour is NOT full --> RESERVE
//                    if !status_two {
//                        
//                        DB_BASE.child("Reservation").child(id).child("sections").child(section).child("T\(seatNumber)").child("date").child("\(year)").child("\(month)").child("\(day)").child("\(hour)").childByAutoId().updateChildValues(["name":"\(user.name)","mobile":"\(user.mobile)","email":"\(user.email)","month":"\(month)","day":"\(day)","hour":"\(hour)","additional_Info":additionalInfo])
//                        
//                        
//                        DB_BASE.child("Reservation").child(id).child("sections").child(section).child("T\(seatNumber)").child("date").child("\(year)").child("\(month)").child("\(day)").child("\(hour+1)").childByAutoId().updateChildValues(["name":"\(user.name)","mobile":"\(user.mobile)","email":"\(user.email)","month":"\(month)","day":"\(day)","hour":"\(hour)","additional_Info":additionalInfo])
//                        
//                        if flag{
//                            self.setAuthUserProfileReservation(id: id, user: user, year: year, month: month, day: day, hour: hour, section: section, seatNumber: seatNumber, additionalInfo: additionalInfo)
//                        }
//                        
//                    }
//                    
//                }
//                
//            }
//            
//        }
//    }
//    
//    
//    func setReservation(id: String,user: User,year:Int,month: Int,day: Int,hour: Int,section: String,seatNumber: Int,additionalInfo: String){
//        DB_BASE.child("Reservation").child(id).child("sections").child("single").child("T\(seatNumber)").observeSingleEvent(of: .value) { (snapshot) in
//            
//            let max = snapshot.childSnapshot(forPath: "max").value as! String
//            self.checkReservation(id: id, max: max, year: year, month: month, day: day, hour: hour, section: section, seatNumber: seatNumber, user: user, additionalInfo: additionalInfo, flag: false)
//            
//        }
//    }
//    
//    
//    func setReservationForAuthUser(id: String,user: User,year:Int,month: Int,day: Int,hour: Int,section: String,seatNumber: Int,additionalInfo: String){
//    
//        let uid = Auth.auth().currentUser!.uid
//        
//            REF_USERS.child("\(uid)").child("reservations").child("active").child("\(id)").observe(.value, with: { (snapshot) in
//                if snapshot.exists() {
//                    
//        
//                   
//                }else {
//                    
//                    DB_BASE.child("Reservation").child(id).child("sections").child("single").child("T\(seatNumber)").observeSingleEvent(of: .value) { (snapshot) in
//                        
//                        let max = snapshot.childSnapshot(forPath: "max").value as! String
//                        self.checkReservation(id: id, max: max, year: year, month: month, day: day, hour: hour, section: section, seatNumber: seatNumber, user: user, additionalInfo: additionalInfo, flag: true)
//                        
//                    }
//                }
//            })
//    }
//    
//    func setAuthUserProfileReservation(id: String,user: User,year:Int,month: Int,day: Int,hour: Int,section: String,seatNumber: Int,additionalInfo: String){
//        print("PASS")
//        let uid = Auth.auth().currentUser!.uid
//        REF_USERS.child("\(uid)").child("reservations").child("active").child("\(id)").childByAutoId().updateChildValues(["name":"\(user.name)","mobile":"\(user.mobile)","email":"\(user.email)","month":"\(month)","day":"\(day)","hour":"\(hour)","additional_Info":additionalInfo,"date":"\(month)/\(day)/\(year)"])
//    }
//    
//    

    
    
    
    
    
    
    //MARK:- User
    func createDBUser(uid: String, userData: Dictionary<String,Any>){
        REF_USERS.child(uid).child("profile_info").updateChildValues(userData)
    }
    
    func getUserInfo(uid: String,handler: @escaping(_ user: User) -> ()){
        var user: User!
        REF_USERS.child(uid).child("profile_info").observe(.value) { (snapshot) in
            let name = snapshot.childSnapshot(forPath: "name").value as! String
            let mobile = snapshot.childSnapshot(forPath: "mobile").value as! String
            let email = snapshot.childSnapshot(forPath: "email").value as! String
            print("NAME:",name,"\nEMAIL",email,"\nMOBILE",mobile)
            let userObject = User(name: name, email: email, mobile: mobile)
            user = userObject
            handler(user)
        }
       
    }
}































// I comment this for future use.


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



