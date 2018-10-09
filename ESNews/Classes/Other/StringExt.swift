//
//  StringExt.swift
//  ESNews
//
//  Created by Dean on 2018/10/8.
//  Copyright © 2018年 siridx. All rights reserved.
//

import Foundation

extension String {
    
    static func localized(_ key:String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
}
