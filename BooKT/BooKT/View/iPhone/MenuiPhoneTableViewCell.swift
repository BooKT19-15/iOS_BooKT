//
//  MenuiPhoneTableViewCell.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 04/02/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit
import SDWebImage

class MenuiPhoneTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(name: String, detail description: String ,price: String,image: String){
       
        self.name.text = name
        self.detail.text = description
        self.price.text = price
        menuImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "one"), options: .continueInBackground, completed: nil)
        
    }
    
}
