//
//  RestaurantsVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 06/03/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class RestaurantsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var parallaxOffSetSpeed: CGFloat = 10
    let cellHeight: CGFloat = 250
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(RestaurantTableCell.self, forCellReuseIdentifier: "RestaurantCell")
        tableView.register(UINib(nibName: "RestaurantTableCell", bundle: nil), forCellReuseIdentifier: "RestaurantCell")

        tableView.delegate = self
        tableView.dataSource = self
    }
    var parallaxImageHeight: CGFloat {
        let maxOffSet = (sqrt(pow(cellHeight, 2) + 4 * parallaxOffSetSpeed * self.tableView.frame.height) - cellHeight) / 2
        return maxOffSet + cellHeight
    }
    
    func parallaxOffSet(newOffSSetY: CGFloat, cell: UITableViewCell) -> CGFloat {
        return(newOffSSetY - cell.frame.origin.y) / parallaxImageHeight * parallaxOffSetSpeed
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = tableView.contentOffset.y
        for cell in tableView.visibleCells as! [RestaurantTableCell] {
            cell.parallaxTopConstraint.constant = parallaxOffSet(newOffSSetY: offSetY, cell: cell)
            
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantTableCell
        cell.parallaxImageHeight.constant = self.parallaxImageHeight
        cell.parallaxTopConstraint.constant = parallaxOffSet(newOffSSetY: tableView.contentOffset.y, cell: cell)
        return cell
    }
}
