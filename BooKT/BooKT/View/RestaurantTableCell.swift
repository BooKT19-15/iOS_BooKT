//
//  RestaurantTableCell.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 05/03/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class RestaurantTableCell: UITableViewCell {

    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var parallaxImageHeight: NSLayoutConstraint!
    @IBOutlet weak var parallaxTopConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
//        restaurantImage.clipsToBounds = true 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


class RRRCell: UITableViewCell {
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var parallaxImageHeight: NSLayoutConstraint!
    @IBOutlet weak var parallaxTopConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
         restaurantImage.clipsToBounds = true 
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
