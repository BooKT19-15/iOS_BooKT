//
//  Navigation+Extension.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 27/03/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    func setNavigation(){
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        let redColor = #colorLiteral(red: 1, green: 0, blue: 0.2558506727, alpha: 1)
        // let darkColor = #colorLiteral(red: 0.1129432991, green: 0.1129470244, blue: 0.1129450426, alpha: 1)
        self.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationBar.backgroundColor = redColor
    }
}
