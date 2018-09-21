//
//  MainTabBarVC.swift
//  ESNews
//
//  Created by Dean on 2018/9/21.
//  Copyright © 2018年 siridx. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupChildVCs()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupChildVCs() {
        
        let homeVC = HomeVC()
        let navVC = BaseNavigationController(rootViewController: homeVC)
        self.addChildViewController(navVC)
    }
    
    
    
}
