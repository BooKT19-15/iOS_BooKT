//
//  TabsMenuVC.swift
//  BooKT
//
//  Created by Abdualziz Aljuaid on 20/02/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class TabsMenuVC: ButtonBarPagerTabStripViewController {

  
    override func viewDidLoad() {
        self.settings.style.buttonBarHeight = 40
        loadDesign()
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuTabTableVC")
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OffersTableVC")
        
        return [child_1 , child_2]
    }
    
    func loadDesign(){
        //let darkColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1)
        //let lightColor = UIColor(red: 235/255, green: 39/255, blue: 72/255, alpha: 1)
        self.settings.style.selectedBarHeight = 1
        self.settings.style.selectedBarBackgroundColor = .black
        self.settings.style.buttonBarBackgroundColor = #colorLiteral(red: 0.1129432991, green: 0.1129470244, blue: 0.1129450426, alpha: 1)
        self.settings.style.buttonBarItemBackgroundColor = #colorLiteral(red: 0.1129432991, green: 0.1129470244, blue: 0.1129450426, alpha: 1)
        self.settings.style.selectedBarBackgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.2558506727, alpha: 1)
        self.settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 13)
        self.settings.style.selectedBarHeight = 4.0
        self.settings.style.buttonBarMinimumLineSpacing = 0
        self.settings.style.buttonBarItemTitleColor = #colorLiteral(red: 1, green: 0, blue: 0.2558506727, alpha: 1)
        self.settings.style.buttonBarItemsShouldFillAvailableWidth = true
        self.settings.style.buttonBarLeftContentInset = 10
        self.settings.style.buttonBarRightContentInset = 10
        
        changeCurrentIndexProgressive = {(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool)-> Void in
            guard changeCurrentIndex == true else {return}
            oldCell?.label.textColor = #colorLiteral(red: 1, green: 0, blue: 0.2558506727, alpha: 1)
            newCell?.label.textColor = #colorLiteral(red: 1, green: 0, blue: 0.2558506727, alpha: 1)
        }
    }

}
