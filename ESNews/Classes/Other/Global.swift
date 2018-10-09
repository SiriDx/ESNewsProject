//
//  Global.swift
//  ESNews
//
//  Created by Dean on 2018/9/21.
//  Copyright © 2018年 siridx. All rights reserved.
//

@_exported import SnapKit
@_exported import RxSwift
@_exported import RxCocoa
@_exported import Kingfisher

let kScreenBounds = UIScreen.main.bounds
let kScreenW = kScreenBounds.size.width
let kScreenH = kScreenBounds.size.height

func scnFit(_ value: CGFloat) -> CGFloat {
    return value / 375.0 * kScreenW
}

extension ConstraintView {
    var usnp: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        } else {
            return self.snp
        }
    }
}

extension ConstraintMakerEditable {
    func scnFit() {
        multipliedBy(kScreenW / 375.0)
    }
}

extension UIFont {
    class func customFont(size fontSize: CGFloat, isBold:Bool = false) -> UIFont {
        if isBold {
            return UIFont.boldSystemFont(ofSize: scnFit(fontSize))
        } else {
            return UIFont.systemFont(ofSize: scnFit(fontSize))
        }
    }
}
