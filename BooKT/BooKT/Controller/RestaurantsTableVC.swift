//
//  RestaurantsTableVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 29/01/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class RestaurantsTableVC: UITableViewController {
   
    var Headerview : UIView!
    var NewHeaderLayer : CAShapeLayer!
    
    private let Headerheight : CGFloat = 230
    private let Headercut : CGFloat = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UpdateView()
        setupNavBar()
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            registerCellForIpad()
        }else{
            registerCellForIphone()
        }
    }
    
    
    
    
    
    
    
    //MARK:- Setup view & Setup NavBar
    func setupNavBar(){
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func UpdateView() {
        
        tableView.backgroundColor = UIColor.white
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
    
    
    
    
    
    
    
    //MARK:- RegisterCells
    func registerCellForIphone(){
        
        tableView.register(iPhoneRestaurantTableViewCell.self, forCellReuseIdentifier: "iPhoneCellRestaurant")
        tableView.register(UINib(nibName: "iPhoneRestaurantTableViewCell", bundle: nil), forCellReuseIdentifier:  "iPhoneCellRestaurant")
        
    }
    
    
    func registerCellForIpad(){
        tableView.register(iPadRestaurantTableViewCell.self, forCellReuseIdentifier: "iPadCellRestaurant")
        tableView.register(UINib(nibName: "iPadRestaurantTableViewCell", bundle: nil), forCellReuseIdentifier: "iPadCellRestaurant")
        
    }
    
    
    
    
    
    
    
    //MARK:- TableView Delegates
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad){
            return 230
        }
        return 130
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "iPadCellRestaurant", for: indexPath) as! iPadRestaurantTableViewCell
            cell.backgroundColor = .blue
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "iPhoneCellRestaurant", for: indexPath) as! iPhoneRestaurantTableViewCell
            cell.backgroundColor = .yellow
            
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //this a comment that will remind me to dismiss the view using tab bar button
        //self.dismiss(animated: true, completion: nil)
    }
}
