//
//  HomeCell.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 30/01/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {

    @IBOutlet weak var homeImageCell: UIImageView!
    @IBOutlet weak var homeLabelCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       // @IBOutlet weak var shanghaiImage: UIImageView!
        //        let layer = CAGradientLayer()
        //        layer.frame = cell.bounds
        //        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        //        //layer.locations = [0.0, 1.0]
        //        cell.layer.addSublayer(layer)

//
//        let view = UIView(frame: homeImageCell.bounds)
//        
//        let layer = CAGradientLayer()
//        
//        layer.frame = view.frame
//        
//        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
//        
//        gradient.locations = [0.0, 1.0]
//        
//        view.layer.insertSublayer(gradient, at: 0)
//        
//        homeImageCell.addSubview(view)
//        
//        homeImageCell.bringSubviewToFront(view)
//
        
//        let layer = CAGradientLayer()
//        layer.frame = cell.bounds
//        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
//        //layer.locations = [0.0, 1.0]
//        //cell.layer.addSublayer(layer)
//        homeImageCell.layer.addSublayer(layer)
//        //
        
    }

}
//extension UIImage {
//    static func gradientImageWithBounds(bounds: CGRect, colors: [CGColor]) -> UIImage {
//        let gradientLayer = CAGradientLayer()
//        //gradientLayer.frame = bounds
//        //gradientLayer.colors = colors
//        
//        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
//        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return image!
//    }
//}
