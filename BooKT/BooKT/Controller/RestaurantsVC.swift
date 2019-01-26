//
//  RestaurantsVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 23/01/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class RestaurantsVC: UIViewController {

    @IBOutlet weak var RestaurantsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        RestaurantsCollectionView.dataSource = self
        RestaurantsCollectionView.delegate = self
        RestaurantsCollectionView.contentInsetAdjustmentBehavior = .never
        RestaurantsCollectionView.register(UINib(nibName: "RestaurantsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RestaurantCell")
        
    }
    

}

//MARK:- CollectionView Delegations
extension RestaurantsVC: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
    let cell = RestaurantsCollectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCell", for: indexPath)
        //cell.backgroundColor = UIColor.blue
        cell.layer.cornerRadius = 8
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reuseableView = RestaurantsCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderRestaurantsCell", for: indexPath) as! HeaderRestaurantsReuseableView

        return reuseableView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let numberOfColumns: CGFloat =  2
            let width = RestaurantsCollectionView.frame.size.width
            let xInsets: CGFloat = 10
            let cellSpacing: CGFloat = 5
            
            
            return CGSize(width: (width / numberOfColumns) - (xInsets + cellSpacing), height:200.0)
            
            
        }
        let padding: CGFloat =  8.0
        let collectionViewSize = RestaurantsCollectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize  , height: 130.0)
        
    }
}

