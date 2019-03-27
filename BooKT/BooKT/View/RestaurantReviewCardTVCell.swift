//
//  RestaurantReviewCardTVCell.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 12/03/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit
import MBCircularProgressBar
class RestaurantReviewCardTVCell: UITableViewCell {

    @IBOutlet weak var fiveRating: MBCircularProgressBarView!
    @IBOutlet weak var fourRating: MBCircularProgressBarView!
    @IBOutlet weak var threeRating: MBCircularProgressBarView!
    @IBOutlet weak var twoRating: MBCircularProgressBarView!
    @IBOutlet weak var oneRating: MBCircularProgressBarView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.fiveRating.value = 0
        self.fourRating.value = 0
        self.threeRating.value = 0
        self.twoRating.value = 0
        self.oneRating.value = 0
        updateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateUI(){
        
        UIView.animate(withDuration: 10) {
            self.fiveRating.value = 40
            self.fourRating.value = 30
            self.threeRating.value = 60
            self.twoRating.value = 90
            self.oneRating.value = 10
        }
    }
}
