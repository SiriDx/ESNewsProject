//
//  MainNavigationController.swift
//  ESNews
//
//  Created by Dean on 2018/9/21.
//  Copyright © 2018年 siridx. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = childViewControllers.count == 1
        super.pushViewController(viewController, animated: true)
    }
    
}
