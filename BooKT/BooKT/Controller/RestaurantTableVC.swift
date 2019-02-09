//
//  RestaurantTableVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 04/02/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit
struct Objects {
    
    var sectionName = String()
    var opend = Bool()
    var sectionObjects = [String]()
}

class RestaurantTableVC: UITableViewController {
    
    @IBOutlet weak var reserveButton: UIButton!
    var sectionArray = [Objects]()
    var Headerview : UIView!
    var NewHeaderLayer : CAShapeLayer!
    
    private let Headerheight : CGFloat = 300
    private let Headercut : CGFloat = 0
    
    
    override func viewDidLoad() {
        setupTableview()
        animateButton()
        sectionArray = [Objects(sectionName:"TEST1" ,opend: false, sectionObjects: ["TEST1","TEST1","TEST1"]),Objects(sectionName:"TEST2" ,opend: false, sectionObjects: ["TEST2","TEST2","TEST2"]),Objects(sectionName: "TEST3", opend: false,sectionObjects: ["TEST3"]),Objects(sectionName: "TEST4",opend: false, sectionObjects: ["TEST4","TEST4","TEST4"]),Objects(sectionName: "TEST5", opend: false,sectionObjects: ["TEST5"]),Objects(sectionName: "TEST6",opend: false, sectionObjects: []),Objects(sectionName: "TEST6", opend: false,sectionObjects: [])]
        super.viewDidLoad()
        
        self.UpdateView()
        setupNavBar()
    }
    
    
    func animateButton(){
        UIView.animate(withDuration: 0.5, animations: {
            self.reserveButton.layer.borderWidth = 0.5
            self.reserveButton.layer.borderColor = UIColor.white.cgColor
            self.reserveButton.layer.cornerRadius = 5
        }) { (done) in
            if done {
                UIView.animate(withDuration: 1, animations: {
                    self.reserveButton.backgroundColor = UIColor(red: 235/255, green: 39/255, blue: 72/255, alpha: 1)
                    self.reserveButton.tintColor = .white
                    self.reserveButton.layer.borderWidth = 0
                }, completion: nil)
            }
        }

    }
    
    
    @IBAction func reserveButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoReserve", sender: self)
    }
    func setupTableview(){
        //galleryCell
        tableView.register(SectionsMenuTableViewCell.self, forCellReuseIdentifier: "sectionsCell")
        tableView.register(UINib(nibName: "SectionsMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "sectionsCell")
        tableView.register(MenuiPhoneTableViewCell.self, forCellReuseIdentifier: "menuCell")
        tableView.register(UINib(nibName: "MenuiPhoneTableViewCell", bundle: nil), forCellReuseIdentifier: "menuCell")
        tableView.register(MapTableViewCell.self, forCellReuseIdentifier: "mapcCell")
        tableView.register(UINib(nibName: "MapTableViewCell", bundle: nil), forCellReuseIdentifier: "mapcCell")
        tableView.register(GalleryTableViewCell.self, forCellReuseIdentifier: "galleryCell")
        tableView.register(UINib(nibName: "GalleryTableViewCell", bundle: nil), forCellReuseIdentifier: "galleryCell")
    }
    
    
    //MARK:- Setup view & Setup NavBar
    func setupNavBar(){
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func UpdateView() {
        
        //tableView.backgroundColor = UIColor.white
        Headerview = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.rowHeight = UITableView.automaticDimension
        tableView.addSubview(Headerview)
        
        NewHeaderLayer = CAShapeLayer()
        NewHeaderLayer.fillColor = UIColor.black.cgColor
        Headerview.layer.mask = NewHeaderLayer
        
        let newheight = Headerheight - Headercut / 2
        tableView.contentInset = UIEdgeInsets(top: newheight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -newheight)
        
        self.Setupnewview()
    }
    
    
    
    func Setupnewview() {
        let newheight = Headerheight - Headercut / 2
        var getheaderframe = CGRect(x: 0, y: -newheight, width: tableView.bounds.width, height: Headerheight)
        if tableView.contentOffset.y < newheight
        {
            getheaderframe.origin.y = tableView.contentOffset.y
            getheaderframe.size.height = -tableView.contentOffset.y + Headercut / 2
        }
        
        Headerview.frame = getheaderframe
        let cutdirection = UIBezierPath()
        cutdirection.move(to: CGPoint(x: 0, y: 0))
        cutdirection.addLine(to: CGPoint(x: getheaderframe.width, y: 0))
        cutdirection.addLine(to: CGPoint(x: getheaderframe.width, y: getheaderframe.height))
        cutdirection.addLine(to: CGPoint(x: 0, y: getheaderframe.height - Headercut))
        NewHeaderLayer.path = cutdirection.cgPath
    }
    
    
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tableView.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.Setupnewview()
        var offset = scrollView.contentOffset.y / 150
        if offset > -0.5
        {
            UIView.animate(withDuration: 0.2, animations: {
                offset = 1
                //let color = UIColor.init(red: 1, green: 1, blue: 1, alpha: offset)
                let navigationcolor = UIColor.init(hue: 0, saturation: offset, brightness: 1, alpha: 1)
                
                self.navigationController?.navigationBar.tintColor = navigationcolor
                self.navigationController?.navigationBar.backgroundColor = UIColor(red: 235/255, green: 39/255, blue: 72/255, alpha: 1) //color
                UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 235/255, green: 39/255, blue: 72/255, alpha: 1)  //color
                
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white] //navigationcolor]
                self.navigationController?.navigationBar.barStyle = .default
            })
        }
        else
        {
            UIView.animate(withDuration: 0.2, animations: {
                let color = UIColor.init(red: 1, green: 1, blue: 1, alpha: offset)
                self.navigationController?.navigationBar.tintColor = UIColor.white
                self.navigationController?.navigationBar.backgroundColor = color
                UIApplication.shared.statusBarView?.backgroundColor = color
                
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                self.navigationController?.navigationBar.barStyle = .black
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       //if section is map
        if indexPath.section == sectionArray.count - 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mapcCell", for: indexPath) as! MapTableViewCell
            return cell 
        }
        //if section is gallery
        if indexPath.section == sectionArray.count - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "galleryCell", for: indexPath) as! GalleryTableViewCell
            return cell
        }
        //others sections
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sectionsCell", for: indexPath)as! SectionsMenuTableViewCell
            cell.sectionName.text = sectionArray[indexPath.section].sectionName
            return cell
        }
        //menu cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuiPhoneTableViewCell
        //cell.sectionName.text = sectionArray[indexPath.section].sectionObjects[indexPath.row - 1]
        return cell

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row == 0 && indexPath.section == sectionArray.count - 2 {
            return 250.0
        }
        if indexPath.row == 0 && indexPath.section == sectionArray.count - 1 {
            return 250.0
        }
        
        if indexPath.row == 0 {
            return 60.0
        }else {
            return 100.0
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionArray[section].opend == true {
            return sectionArray[section].sectionObjects.count + 1
        }
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    //    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return sectionArray[section].sectionName
    //    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if sectionArray[indexPath.section].opend == true && indexPath.section != sectionArray.count - 1 && indexPath.row == 0 {
            sectionArray[indexPath.section].opend = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }else if sectionArray[indexPath.section].opend == false && indexPath.section != sectionArray.count - 1 && indexPath.row == 0 {
            sectionArray[indexPath.section].opend = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
    }
    
}
