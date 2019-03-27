//
//  Restaurants.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 23/03/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import Foundation

class Restaurants{
    var name: String
    var close: String
    var open: String
    var image: String
    var location: String
    var price: String
    var id: String
    //var status: String
    
    init(name: String, close: String, open: String, image: String, location: String, price: String,id: String) {
        self.name = name
        self.close = close
        self.open = open
        self.image = image
        self.location = location
        self.price = price
        self.id = id
    }
}
