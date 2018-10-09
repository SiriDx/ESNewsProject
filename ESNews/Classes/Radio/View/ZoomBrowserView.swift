//
//  ZoomBrowserView.swift
//  igola
//
//  Created by Dean on 2018/8/9.
//  Copyright © 2018年 www.igola.com. All rights reserved.
//

import UIKit

class ZoomBrowserView: UIView {
    
//    private let topInset:CGFloat = frameMath(10)
//    private let itemW:CGFloat = frameMath(178)
//    private var itemH:CGFloat = frameMath(125.5)
//
//    private var margin:CGFloat {
//        get {
//           return (self.width - itemW) * 0.5 - frameMath(25)
//        }
//    }
//
//    private var lrInset:CGFloat {
//        get{
//            return (self.width - self.itemW) * 0.5
//        }
//    }
//
    private let multiBy:Int = 5000
    
    private weak var collectionView:UICollectionView!
    private weak var flowLayout:UICollectionViewFlowLayout!
    private weak var displayCell:UICollectionViewCell?
    
    private weak var timer:Timer?
    
    private var currentPage:Int = 0
    
    var endScrollAtIndex:((Int)->())?
    
    var datas = [[String:Any]]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var selectIndex:Int = 0 {
        didSet {
            if datas.count <= 1 {
                scrollTo(toIndex: selectIndex)
            } else {
                scrollTo(toIndex: datas.count * multiBy / 2 + selectIndex)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        setupCollectionView()
    }
    
    private func scrollTo(toIndex index:Int, animated:Bool = false) {
        DispatchQueue.main.async {
//            let newOffsetX = (self.itemW + self.margin) * CGFloat(index) - self.lrInset
//            self.collectionView.setContentOffset(CGPoint(x: newOffsetX, y: self.collectionView.contentOffset.y), animated: animated)
            self.currentPage = index
            self.collectionView.layoutIfNeeded()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = self.bounds
        
//        collectionView.contentInset = UIEdgeInsets(top: topInset, left: lrInset, bottom: 25, right: lrInset)
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0
//        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
//        flowLayout.itemSize = CGSize(width: itemW, height: itemH)
        
    }

}

extension ZoomBrowserView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setupCollectionView() {
        
        let layout = ZoomBrowserFlowLayout()
        self.flowLayout = layout
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        
        self.collectionView = collectionView
        addSubview(collectionView)
        
        collectionView.backgroundColor = UIColor.white
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(ZoomBrowserCell.classForCoder(), forCellWithReuseIdentifier: "cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if datas.count <= 1 {
            return datas.count
        } else {
            return datas.count * multiBy
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        var hotelLabel:HotelRecommendLabel?
//        if datas.count <= 1 {
//            hotelLabel = datas[indexPath.row]
//        } else {
//            let row = indexPath.row % datas.count
//            hotelLabel = datas[row]
//        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ZoomBrowserCell
//        cell.hotelLabel = hotelLabel
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

class ZoomBrowserCell: UICollectionViewCell {
    
    
    var imageView:UIImageView!
    var titleLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 15)
        self.layer.shadowOpacity = 0.05
        self.layer.shadowRadius = 8
        
        // 图片
        let imageView = UIImageView()
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        
        self.imageView = imageView
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        // 蒙版
        let bgView = UIView()
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
//        bgView.backgroundColor = UIColor.hexColor(.H323232, alpha: 0.5)
//        bgView.layer.cornerRadius = frameMath(5)
        bgView.layer.masksToBounds = true
        
        // 标题
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        titleLabel.adjustsFontSizeToFitWidth = true
//        titleLabel.font = UIFont.customFont(name: .PingFangSCMedium, size: 24)
        titleLabel.lineBreakMode = .byTruncatingMiddle
        
        contentView.addSubview(titleLabel)
        self.titleLabel = titleLabel
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
//            make.left.equalTo(frameMath(25))
//            make.right.equalTo(-frameMath(25))
        }
        
//        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let atts = layoutAttributes as? ZoomBrowserViewLayoutAttributes {
            self.layer.anchorPoint = atts.anchorPoint
        }
    }
    
}

extension ZoomBrowserView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let page = Int((scrollView.contentOffset.x + lrInset) / (itemW + margin))
//        self.currentPage = page
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        stopTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
//            startTimer()
            endScroll()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        endScroll()
    }
    
    func endScroll() {
        if let endScrollAtIndex = self.endScrollAtIndex {
            let index = currentPage % datas.count
            endScrollAtIndex(index)
        }
    }
    
}

//MARK: ZoomBrowserFlowLayout
class ZoomBrowserFlowLayout: UICollectionViewFlowLayout {
    
    override class var layoutAttributesClass: AnyClass {
        return ZoomBrowserViewLayoutAttributes.self
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        if let attributes = super.layoutAttributesForElements(in: rect) as? [ZoomBrowserViewLayoutAttributes],
            let collectionView = self.collectionView {
            
            let topInset = collectionView.contentInset.top
            
            let visibleRect = CGRect.zero
//            let visibleRect = CGRect(x: collectionView.contentOffset.x, y: collectionView.contentOffset.y, width: collectionView.width, height: collectionView.height)
            
            guard let copyAttributes = NSArray.init(array: attributes, copyItems: true) as? [ZoomBrowserViewLayoutAttributes] else { return nil }

            let newAttributes = copyAttributes.map { (attribute) -> UICollectionViewLayoutAttributes in

                if visibleRect.intersects(attribute.frame) {
                    
                    // 设置锚点
                    attribute.anchorPoint = CGPoint(x: 0.5, y: 1)
                    attribute.center.y += itemSize.height * 0.5 + topInset

                    // 计算缩放比例
                    let contentOffsetX = collectionView.contentOffset.x
                    let collectionViewCenterX = collectionView.bounds.size.width * 0.5
                    
                    let centerX = attribute.center.x
                    let distance = abs(centerX - contentOffsetX - collectionViewCenterX)
                    
                    let totalDistance = itemSize.width + minimumLineSpacing

                    let offsetW = (totalDistance - distance) / totalDistance * (285 - itemSize.width)
                    
                    let offsetH = (totalDistance - distance) / totalDistance * (135 - itemSize.height)
                    
                    attribute.bounds = CGRect(x: 0, y: 0, width: itemSize.width + offsetW, height: itemSize.height + offsetH)
                    
                    // 计算透明度比例
                    let scaleA = 0.5 + (0.5 / totalDistance) * (totalDistance - distance)
                    attribute.alpha = scaleA
                    
                }

                return attribute
            }

            return newAttributes
        }
        return nil
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        if let collectionView = self.collectionView {

            let lastRect = CGRect(x: proposedContentOffset.x, y: proposedContentOffset.y, width: collectionView.frame.size.width, height: collectionView.frame.size.height)
            
            let centerX = proposedContentOffset.x + collectionView.frame.size.width * 0.5;

            if let attributes = self.layoutAttributesForElements(in: lastRect) {

                var adjustOffsetX = CGFloat(MAXFLOAT);
                for att in attributes {
                    let offsetX = abs(att.center.x - centerX)
                    if offsetX < abs(adjustOffsetX) {
                        adjustOffsetX = att.center.x - centerX;
                    }
                }
                
                let newProposedContentOffsetX = proposedContentOffset.x + adjustOffsetX
                
                return CGPoint(x: newProposedContentOffsetX, y: proposedContentOffset.y)
            }
        }

        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
    }
    
}

//MARK: ZoomBrowserViewLayoutAttributes
class ZoomBrowserViewLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var anchorPoint = CGPoint(x: 0.5, y: 1)
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copiedAttributes = super.copy(with: zone) as! ZoomBrowserViewLayoutAttributes
        copiedAttributes.anchorPoint = self.anchorPoint
        
        return copiedAttributes
    }
    
}

//MARK: Timer
extension ZoomBrowserView {
    func startTimer() {
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .commonModes)
        self.timer = timer
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func timerUpdate() {
        currentPage += 1
        scrollTo(toIndex: currentPage, animated: true)
    }
}

