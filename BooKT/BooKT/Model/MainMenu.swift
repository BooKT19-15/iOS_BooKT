//
//  MainMenu.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 01/04/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import Foundation


class MainMenu{
    var name: String
    var isExpandable: Bool
    var menu: [Menu]
    
    init(name: String,isExpandable: Bool, menu: [Menu]){
        self.name = name
        self.isExpandable = isExpandable
        self.menu = menu
    }
}


