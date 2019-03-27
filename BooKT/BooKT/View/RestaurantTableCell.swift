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
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantLocation: UILabel!
    @IBOutlet weak var restaurantOpen: UILabel!
    @IBOutlet weak var restaurantClose: UILabel!
    //@IBOutlet weak var restaurantPrice: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI(){
        restaurantOpen.adjustsFontSizeToFitWidth = true
        restaurantClose.adjustsFontSizeToFitWidth = true
    }
    
    func configureCell(name: String,image: String,open: String,close: String,location: String,price: String){
        restaurantName.text = name
        restaurantImage.image = UIImage(named: image)
        restaurantOpen.text = open
        restaurantClose.text = close
        restaurantLocation.text = location
        //restaurantPrice.text = price
    }
}
