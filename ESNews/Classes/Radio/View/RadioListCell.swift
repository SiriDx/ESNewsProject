//
//  RadioListCell.swift
//  ESNews
//
//  Created by Dean on 2018/10/9.
//  Copyright © 2018年 siridx. All rights reserved.
//

import UIKit

class RadioListCell: UITableViewCell {
    
    var logoImgView: UIImageView!
    let disposeBag = DisposeBag()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(size: 17, isBold: true)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(size: 12)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    lazy var playBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: ""), for: .normal)
        btn.backgroundColor = UIColor.cyan
        return btn
    }()
    
    var item:RadioItem? {
        didSet {
            guard let item = self.item else { return }
            
            let logoURL = URL(string: item.logo)
            logoImgView.kf.setImage(with: logoURL)
            
            titleLabel.text = item.name
            
            descLabel.text = item.bandDial + ", " + item.location
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none

        let imageView = UIImageView()
        self.logoImgView = imageView
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(15).scnFit()
            make.top.equalTo(10).scnFit()
            make.width.height.equalTo(80).scnFit()
            make.bottom.equalTo(-10).scnFit()
        }
        
        let tbM = ((80 + 10 * 2) - 20 - 15 - 10) * 0.5
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tbM).scnFit()
            make.left.equalTo(imageView.snp.right).offset(15).scnFit()
            make.right.equalTo(-80).scnFit()
            make.height.equalTo(20).scnFit()
        }
        
        contentView.addSubview(descLabel)
        descLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10).scnFit()
            make.height.equalTo(15).scnFit()
        }
        
        contentView.addSubview(playBtn)
        playBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.width.height.equalTo(44)
            make.centerY.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
