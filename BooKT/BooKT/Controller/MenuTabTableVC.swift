//
//  MenuTabTableVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 20/02/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//
struct ExpandableNames {
    var isExpanded: Bool
    let names: [String]
}
import UIKit
import XLPagerTabStrip

class MenuTabTableVC: UITableViewController {
    var twoDimensionArray = [ExpandableNames(isExpanded: true, names: ["A","B","C","D"]),
                             ExpandableNames(isExpanded: true, names: ["A2","B2","C2","D2"]),
                             ExpandableNames(isExpanded: true, names: ["A3","B3","C3","D3"])
                            ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.register(MenuiPhoneTableViewCell.self, forCellReuseIdentifier: "menuCell")
        tableView.register(UINib(nibName: "MenuiPhoneTableViewCell", bundle: nil), forCellReuseIdentifier: "menuCell")
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .custom)
        button.setTitle("Test", for: .normal)
        button.setTitleColor(.white, for: .reserved)
        button.backgroundColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1)
        button.addTarget(self, action: #selector(handleExpandHeader), for: .touchUpInside)
        button.tag = section
        return button
    }
    @objc func handleExpandHeader(button: UIButton){
        let section = button.tag
        var indexPaths = [IndexPath]()
        for row in twoDimensionArray[section].names.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        let isExpanded = twoDimensionArray[section].isExpanded
        twoDimensionArray[section].isExpanded = !isExpanded
        
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionArray[section].isExpanded {
            return 0
        }
        return twoDimensionArray[section].names.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuiPhoneTableViewCell
       //let names = twoDimensionArray[indexPath.section].names[indexPath.row]
       //cell.textLabel?.text = names
       //cell.textLabel?.textColor = .white
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100
    }
}


extension MenuTabTableVC: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Menu")
    }
}
