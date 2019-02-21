//
//  RestaurantTableVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 04/02/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit
class RestaurantTableVC: UITableViewController {
    
    @IBOutlet weak var reserveButton: UIButton!
    var Headerview : UIView!
    var NewHeaderLayer : CAShapeLayer!
    
    private let Headerheight : CGFloat = 500
    private let Headercut : CGFloat = 0
    
    
    override func viewDidLoad() {
        setupTableview()
        animateButton()

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
       let cell = tableView.dequeueReusableCell(withIdentifier: "mapcCell", for: indexPath)
        return cell 
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 3
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
