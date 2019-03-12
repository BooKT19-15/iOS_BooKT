//
//  ReviewTableVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 20/02/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ReviewTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: "reviewTabCell")
        tableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "reviewTabCell")
        tableView.rowHeight = 130
    }



override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 25
}

override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reviewTabCell", for: indexPath)
    return cell
}




}



extension ReviewTableVC: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Review")
    }
}
