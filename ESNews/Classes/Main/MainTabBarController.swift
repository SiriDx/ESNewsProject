//
//  MainTabBarVC.swift
//  ESNews
//
//  Created by Dean on 2018/9/21.
//  Copyright © 2018年 siridx. All rights reserved.
//

import UIKit

struct ChildTabItem {
    var vc:UIViewController
    var tabBarItem:UITabBarItem
}

class MainTabBarController: UITabBarController {
    
    lazy var childItems: [ChildTabItem] = {
        var items = [ChildTabItem]()
        
//        let homeVC = HomeVC()
//
//        let homeTab = UITabBarItem(title: String.localized("tabbar_home"), image: UIImage.init(named: "42x_flights_default"), selectedImage: UIImage.init(named: "42x_flights_activated"))
//        let item1 = ChildTabItem(vc: homeVC, tabBarItem: homeTab)
//        items.append(item1)
        
        let radioVC = RadioListVC()
        let radioTab = UITabBarItem(title: String.localized("tabbar_radio"), image: UIImage.init(named: "42x_hotels_default"), selectedImage: UIImage.init(named: "42x_hotels_activated"))
        let item2 = ChildTabItem(vc: radioVC, tabBarItem: radioTab)
        items.append(item2)
        
        return items
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupChildVCs()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupChildVCs() {
        for item in childItems {
            let navVC = BaseNavigationController(rootViewController: item.vc)
            navVC.tabBarItem = item.tabBarItem
            self.addChildViewController(navVC)
        }
    }
    
}
