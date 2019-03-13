//
//  HomeCollectionVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 30/01/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit
var Headerview : UIView!
var NewHeaderLayer : CAShapeLayer!

private let Headerheight : CGFloat = 230
private let Headercut : CGFloat = 0




fileprivate let cellId = "mainCell"
fileprivate let headerId = "headerId"
let padding: CGFloat = 0
class HomeCollectionVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Register cell classes
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        setupCollectionViewLayout()
    
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: "mainCell")
        collectionView.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "mainCell")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    func setupCollectionViewLayout(){
        let layout = StrecheyHeader()
        //layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        collectionView.collectionViewLayout = layout
    }
   
    func transform(cell: UICollectionViewCell){
        let coverFrame = cell.convert(cell.bounds, to: self.view)
        let transfromOffsetY = collectionView.bounds.height * 2/3
        let precent = getPrecent(value: (coverFrame.minY - transfromOffsetY) / (collectionView.bounds.height - transfromOffsetY))
        let maxScaleDifference: CGFloat = 0.2
        let scale = precent * maxScaleDifference
        cell.transform = CGAffineTransform(scaleX: 1 - scale, y: 1 - scale)
    }
    func getPrecent(value: CGFloat) -> CGFloat{
        let lowerBound: CGFloat = 0
        let upperBound: CGFloat = 1
        
        if value < lowerBound {
            return lowerBound
        }else if value > upperBound {
            return upperBound
        }
        return value
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if  translation.y  < 0 {
            collectionView.visibleCells.forEach{transform(cell: $0)}
        }
        setNavbar(scrollView: scrollView)
        
        let contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY > 0 {
            headerView?.animator.fractionComplete = 0
            return
        }
        
        headerView?.animator.fractionComplete = abs(contentOffsetY) / 100
    }
    
    var headerView: HeaderView?
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? HeaderView
        return headerView!
    }
    
    func setNavbar(scrollView: UIScrollView){
        var offset = scrollView.contentOffset.y / 100
        if offset > 1 {
            offset = 1
            setNavColor(offset: offset)
        }else {
            setNavColor(offset: offset)
        }
        
    }
    func setNavColor(offset: CGFloat){
        let color = UIColor(red: 235/255, green: 39/255, blue: 72/255, alpha: offset)
        self.navigationController?.navigationBar.backgroundColor = color
        UIApplication.shared.statusBarView?.backgroundColor = color
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: 340)
   }
    
    
    
    // MARK:- Collectionview Delegate
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! HomeCell
//        ////
//        let layer = CAGradientLayer()
//        layer.frame = cell.bounds
//        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
//        //layer.locations = [0.0, 1.0]
//        //cell.layer.addSublayer(layer)
//        cell.homeImageCell.layer.addSublayer(layer)
////
        //cell.layer.cornerRadius = 8.0
        transform(cell: cell)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let rightList = [0,3,6,7,10,13,16,17]
        let leftList = [1,2,5,8,11,12,15,18]
        let centerList = [4,9,14,19]
        let numberOfColumns: CGFloat =  3
        let width = collectionView.frame.size.width
        let xInsets: CGFloat = 5
        let cellSpacing: CGFloat = 0
        
        // Check if it's iPad
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: (width / 3) - (xInsets + cellSpacing), height:250.0)
        }
        if rightList.contains(indexPath.row) {
            return CGSize(width: ((width / 2) - (xInsets + cellSpacing)) - 25, height: (width / numberOfColumns) - (xInsets + cellSpacing))
        }else if leftList.contains(indexPath.row) {
            return CGSize(width: ((width / 2) - (xInsets + cellSpacing)) + 25, height: (width / numberOfColumns) - (xInsets + cellSpacing))
        }else if centerList.contains(indexPath.row) {
            return CGSize(width: width, height: (width / numberOfColumns) - (xInsets + cellSpacing))
        }
        return CGSize(width: (width) - (xInsets + cellSpacing), height: (width / numberOfColumns) - (xInsets + cellSpacing))
        
    
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationController") as! NavigationController
               // present.rootViewController = viewController
        present(viewController, animated: true, completion: nil)
    }
    
    
}
