//
//  UserReservation.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 02/04/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import Foundation

class UserReservation{
    
    var name: String
    var email: String
    var mobile: String
    var additionalInfo: String
    var year: String
    var month: String
    var day: String
    var hour: String
    var section: String
    
    init(name: String, email: String, mobile: String, additionalInfo: String, year: String, month: String, day: String, hour: String, section: String){
        self.name = name
        self.email = email
        self.mobile = mobile
        self.additionalInfo = additionalInfo
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.section = section
    }
}
