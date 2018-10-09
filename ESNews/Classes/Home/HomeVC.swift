//
//  HomeVC.swift
//  ESNews
//
//  Created by Dean on 2018/9/21.
//  Copyright © 2018年 siridx. All rights reserved.
//

import UIKit
import AVFoundation

class HomeVC: BaseVC {

    var player:AVPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let url = URL(string: "http://stream.abacast.net//playlist//univision-klvefmmp3-ibc2.m3u")
        //http://5.9.16.126:8106/stream
        
        let url = URL(string: "http://190.113.128.139:8080/NihuilAM")
        
        let item = AVPlayerItem.init(url: url!)
        let player = AVPlayer.init(playerItem: item)
        self.player = player

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.player.play()
    }


}
