//
//  RestaurantVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 14/02/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class RestaurantVC: UIViewController {

    @IBOutlet weak var collectionViewOfImages: UICollectionView!
    @IBOutlet weak var pageView:UIPageControl!
    
    var counter = 0
    
    
    @IBOutlet weak var reserveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        reserveButton.layer.cornerRadius = 8
        reserveButton.layer.borderWidth = 1.2
        reserveButton.layer.borderColor = UIColor.white.cgColor
        
        pageView.numberOfPages = 5
        pageView.currentPage = counter
    
        collectionViewOfImages.delegate = self
        collectionViewOfImages.dataSource = self
        collectionViewOfImages.contentInsetAdjustmentBehavior = .never
        let index = IndexPath.init(row: counter, section: 0)
        self.collectionViewOfImages.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        applyDesignAnimation()
    }
    
    func applyDesignAnimation(){
        UIView.animate(withDuration: 2) {
            let lightColor = UIColor(red: 235/255, green: 39/255, blue: 72/255, alpha: 1)
            self.reserveButton.backgroundColor = lightColor
            self.reserveButton.layer.borderWidth = 0 
        }
    }
}

extension RestaurantVC: UICollectionViewDelegate , UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pageCell", for: indexPath)
        if let vc = cell.viewWithTag(111) as? UIImageView{
            vc.image = #imageLiteral(resourceName: "Image")
        }else if let ab = cell.viewWithTag(222) as? UIPageControl {
            ab.currentPage = indexPath.row
        }
        return cell 
    }
}


extension RestaurantVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionViewOfImages.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        counter += 1
        pageView.currentPage = counter
    }
}

// MARK-: PAGEVIEW DOES NOT WORK!!!!!!!!!!!!!!!
