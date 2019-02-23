//
//  ConfirmationVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 06/02/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit

class ConfirmationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupNavBarImage()
    }
    func setupNavbar(){
        navigationController?.navigationBar.barTintColor = UIColor(red: 235/255, green: 39/255, blue: 72/255, alpha: 1)
        //navigationController?.navigationBar.prefersLargeTitles = true
    }
    func setupNavBarImage() {
        
        let navBar = navigationController!
        if let image = UIImage(named: "Image-2"){
            let imageView = UIImageView(image: image)
            
            let bannerWidth = navBar.navigationBar.frame.size.width
            let bannerHeight = navBar.navigationBar.frame.size.height
            
            let bannerX = bannerWidth / 2 - image.size.width  / 2
            let bannarY = bannerHeight / 2 - image.size.height / 2
            imageView.frame = CGRect(x: bannerX, y: bannarY, width: bannerWidth, height: bannerHeight)
            imageView.contentMode = .scaleAspectFit
            
            navigationItem.titleView = imageView
            
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
