//
//  ReservationVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 06/02/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class ReservationVC: UIViewController {
    var count = 1
    @IBOutlet weak var seatsNumberLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        seatsNumberLabel.text = "\(count)"
    }
   
    @IBAction func numberOfSeats(_ sender: UIButton) {
        if sender.tag == 101 && count < 30{
            count += 1
            seatsNumberLabel.text = "\(count)"
        } else if sender.tag == 102 && count > 1 {
            count -= 1
            seatsNumberLabel.text = "\(count)"
        }
    }
}




