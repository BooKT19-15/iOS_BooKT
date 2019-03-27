//
//  OffersTableVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 27/03/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class OffersTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView(){
     tableView.register(MenuiPhoneTableViewCell.self, forCellReuseIdentifier: "menuCell")
     tableView.register(UINib(nibName: "MenuiPhoneTableViewCell", bundle: nil), forCellReuseIdentifier: "menuCell")
     tableView.separatorStyle = .none
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuiPhoneTableViewCell
        return cell
    }
}



extension OffersTableVC: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Offers")
    }
}
