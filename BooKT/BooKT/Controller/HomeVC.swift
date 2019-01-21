//
//  HomeVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 21/01/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var galleryCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
    }
}











//MARK:- CollectionView Delegations
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) 
        print(indexPath.row)
        
        return cell 
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reuseableView = galleryCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "reuseableCell", for: indexPath)
        
        return reuseableView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat =  10.0
        let collectionViewSize = galleryCollectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
        
    }
}
