//
//  RestaurantVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 14/02/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class RestaurantVC: UIViewController{

   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    let images = ["one",
                  "one",
                  "one"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        tableView.backgroundColor = #colorLiteral(red: 0.1129432991, green: 0.1129470244, blue: 0.1129450426, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 90
        tableView.separatorStyle = .none
        scrollView.delegate = self
        tableView.contentInsetAdjustmentBehavior = .never
        pageControl.numberOfPages = images.count
        setScrollWithImages()
        setupNavBar()
    }

    
    //MARK:- Setup view & Setup NavBar
    func setupNavBar(){
        navigationController?.setNavigation()
        UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.2558506727, alpha: 1)
    }
    
    func setScrollWithImages(){
        for i in 0..<images.count {
            let imageView = UIImageView()
            imageView.contentMode = .scaleToFill
            imageView.image = UIImage(named: images[i])
            let xPostion = CGFloat(i)*self.view.bounds.size.width
            imageView.frame = CGRect(x: xPostion, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height)
            scrollView.contentSize.width = view.frame.size.width * CGFloat(i+1)
            scrollView.addSubview(imageView)
            
            tableView.register(RestaurantReviewCardTVCell.self, forCellReuseIdentifier: "restaurantReviewCell")
            tableView.register(UINib(nibName: "RestaurantReviewCardTVCell", bundle: nil), forCellReuseIdentifier: "restaurantReviewCell")
            
            tableView.register(MapTableViewCell.self, forCellReuseIdentifier: "mapcCell")
            tableView.register(UINib(nibName: "MapTableViewCell", bundle: nil), forCellReuseIdentifier: "mapcCell")
            
            
            tableView.register(seeAllReviews.self, forCellReuseIdentifier: "gotoAllReviews")
            tableView.register(UINib(nibName: "seeAllReviews", bundle: nil), forCellReuseIdentifier: "gotoAllReviews")

        }
    }
    
  
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
      //  navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func gotoMenu(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "gotoMenu", sender: self)
    }
}



extension RestaurantVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(page)
    }
}


extension RestaurantVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCardCell", for: indexPath) as! RestaurantHeaderCardTVCell
            return cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantReviewCell", for: indexPath)
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mapcCell", for: indexPath)
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "gotoAllReviews", for: indexPath)
            return cell
        } else {
            return RestaurantHeaderCardTVCell()
        }
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        if indexPath.row == 0 {
            return 230.0
        }
        else if indexPath.row == 2 {
            return 200.0
        } else if indexPath.row == 3 {
            return 60.0
        }
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
         performSegue(withIdentifier: "gotoReviews", sender: self)
        }
    }
}
