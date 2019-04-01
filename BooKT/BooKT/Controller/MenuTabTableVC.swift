//
//  MenuTabTableVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 20/02/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

//struct ExpandableNames {
//    var isExpanded: Bool
//    let names: [String]
//}
//
//

import UIKit
import XLPagerTabStrip

class MenuTabTableVC: UITableViewController {
  
    var id: String!
    
//    var twoDimensionArray = [ExpandableNames(isExpanded: false, names: ["A","B","C","D"]),
//                             ExpandableNames(isExpanded: false, names: ["A2","B2","C2","D2"]),
//                             ExpandableNames(isExpanded: false, names: ["A3","B3","C3","D3"])
//                            ]
//    var menux = [MainMenu(name: "X", isExpandable: false, menu: [Menu(name: "x1", description: "s", price: "10", image: "one"),
//                                                             Menu(name: "x2", description: "s2", price: "102", image: "one")]),
//             MainMenu(name: "X202", isExpandable: false, menu: [Menu(name: "x202", description: "s", price: "10", image: "one")]),
//             MainMenu(name: "X303", isExpandable: false, menu: [Menu(name: "x303", description: "s", price: "10", image: "one")])]
    //let menu = ["Starters","Main dish","Drinks"]
    var menu = [MainMenu]()
    //var menuX = [MainMenu]()
    var m = [Menu]()
    override func viewDidLoad() {
        super.viewDidLoad()
        id = restaurantID
       
        tableView.separatorStyle = .none
        tableView.register(MenuiPhoneTableViewCell.self, forCellReuseIdentifier: "menuCell")
        tableView.register(UINib(nibName: "MenuiPhoneTableViewCell", bundle: nil), forCellReuseIdentifier: "menuCell")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DataService.instance.getMenu(id: id!) { (returnedMenu) in
            self.menu = returnedMenu
            print("FROM THE MENUVC ", self.menu.count)
            self.tableView.reloadData()
        }
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .custom)
        button.setTitle(menu[section].name, for: .normal)
        button.setTitleColor(.white, for: .reserved)
        button.backgroundColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1)
        button.addTarget(self, action: #selector(handleExpandHeader), for: .touchUpInside)
        button.tag = section
        return button
    }
    @objc func handleExpandHeader(button: UIButton){
        let section = button.tag
        var indexPaths = [IndexPath]()
        for row in menu[section].menu.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        let isExpanded = menu[section].isExpandable
        menu[section].isExpandable = !isExpanded
        
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
        if !menu[section].isExpandable {
            return 0
        }
        return menu[section].menu.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return menu.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuiPhoneTableViewCell
        //let names = twoDimensionArray[indexPath.section].names[indexPath.row]
        //cell.textLabel?.text = names
        let index = menu[indexPath.section].menu[indexPath.row]
        cell.configureCell(name: index.name, detail: index.description, price: index.price, image: index.image)
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



