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
    let images = ["alps-background-beautiful-view-1227520",
                  "alps-background-beautiful-view-1227520",
                  "alps-background-beautiful-view-1227520"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 90
        tableView.separatorStyle = .none
        scrollView.delegate = self
        tableView.contentInsetAdjustmentBehavior = .never
        pageControl.numberOfPages = images.count
        setScrollWithImages()
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
        }
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
        return 3
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
        }
        else {
            return RestaurantHeaderCardTVCell()
        }
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        if indexPath.row == 0 {
            return 220.0
        }
        else if indexPath.row == 2 {
            return 280.0
        }
        return 90.0
    }
}
