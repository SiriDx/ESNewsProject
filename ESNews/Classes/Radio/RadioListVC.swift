//
//  RadioVC.swift
//  ESNews
//
//  Created by Dean on 2018/10/8.
//  Copyright © 2018年 siridx. All rights reserved.
//

import UIKit

class RadioListVC: BaseVC {

    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        let items = Observable.just(
            [
                RadioItem(name: "Canal Sur Radio", bandDial: "FM 104.6", logo: "https://static-media.streema.com/media/cache/43/17/4317fc407293619e50c996777ab891ce.jpg", location: "Malaga, Spain", steam: "http://canalsurradiomalaga.rtva.stream.flumotion.com/rtva/canalsurradiomalaga.mp3.m3u")
            ]
        )
        
        items.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: RadioListCell.self)) { [weak self] (row, item, cell) in
            
                cell.item = item
            
                cell.playBtn.rx.tap
                    .bind { [weak self] in
                       self?.play()
                    }
                    .disposed(by: self!.disposeBag)
            
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(RadioItem.self).subscribe { [weak self](item) in
            
            let playerVC = RadioPlayerVC()
            self?.navigationController?.pushViewController(playerVC, animated: true)
            
        }.disposed(by: disposeBag)
        
    }
    
    func play() {
        
    }
    
    func setupTableView() {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.register(RadioListCell.self, forCellReuseIdentifier: "cell")
        self.tableView = tableView
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.usnp.edges)
        }
    }


}
