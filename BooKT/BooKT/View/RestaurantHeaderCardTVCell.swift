//
//  RestaurantHeaderCardTVCell.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 12/03/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class RestaurantHeaderCardTVCell: UITableViewCell {

    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantLocation: UILabel!
    @IBOutlet weak var RestaurantWorkHours: UILabel!
    @IBOutlet weak var restaurantCuisine: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(name: String, location: String, open: String, close: String, cuisine: String){
        restaurantName.text = name
        restaurantLocation.text = location
        restaurantCuisine.text = cuisine
        RestaurantWorkHours.text = "\(open)  \(close)"
        restaurantCuisine.text = cuisine
    }
}
