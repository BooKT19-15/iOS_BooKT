//
//  Menu.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 01/04/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import Foundation
class Menu{
    
    var name: String
    var description: String
    var price: String
    var image: String
    
    init (name: String,description: String,price: String, image: String){
        self.name = name
        self.description = description
        self.price = price
        self.image = image
    }
}
