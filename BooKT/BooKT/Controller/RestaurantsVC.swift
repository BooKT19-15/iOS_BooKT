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
        RestaurantsCollectionView.register(UINib(nibName: "RestaurantCell", bundle: nil), forCellWithReuseIdentifier: "RestaurantsCell")
        
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
        
        
    let cell = RestaurantsCollectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantsCell", for: indexPath)
        //cell.backgroundColor = UIColor.blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reuseableView = RestaurantsCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderRestaurantsCell", for: indexPath) as! HeaderRestaurantsReuseableView

        return reuseableView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat =  10.0
        let collectionViewSize = RestaurantsCollectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize - 20 , height: 120.0)
        
    }
}

