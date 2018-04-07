//
//
//                        _____
//                       / ___/____  ____  ____ _
//                       \__ \/ __ \/ __ \/ __ `/
//                      ___/ / /_/ / / / / /_/ /
//                     /____/\____/_/ /_/\__, /
//                                      /____/
//
//                .-~~~~~~~~~-._       _.-~~~~~~~~~-.
//            __.'              ~.   .~              `.__
//          .'//                  \./                  \\`.
//        .'//                     |                     \\`.
//      .'// .-~"""""""~~~~-._     |     _,-~~~~"""""""~-. \\`.
//    .'//.-"                 `-.  |  .-'                 "-.\\`.
//  .'//______.============-..   \ | /   ..-============.______\\`.
//.'______________________________\|/______________________________`.
//
//
//  MGCarouselView.swift
//  MGCarouselView-Demo
//
//  Created by song on 2017/8/2.
//  Copyright © 2017年 song. All rights reserved.
//

import UIKit
import iCarousel

open class MGCarouselView: UIView,MGTimerFetching {
    
    //MARK: - 外部调用属性
    
    /*! 设置自动轮播时间如果没有设置 默认不开启自动轮播功能 */
    @IBInspectable public var autoAnimation :Double = 0.0{
        didSet{
            if autoAnimation > 0 {
                animationTimer = Timer.scheduledTimer(timeInterval: autoAnimation, target: self, selector: #selector(animationTimerDidFired), userInfo: nil, repeats: true)
                if carouseData.count == 0 {
                    pause()
                }
            }
        }
    }
    
    /*! 底部阴影高度 */
    @IBInspectable public var shadeHeight: CGFloat = 0{
        didSet{
            self.setNeedsLayout()
            self.bottomBgImageView.isHidden = shadeHeight == 0
        }
    }
    
    /*! 底部阴影图片 */
    @IBInspectable public var shadeImage: UIImage?{
        didSet{
            self.bottomBgImageView.image = shadeImage
        }
    }
    
    /*! MGCarouselViewDelegate  */
    public weak var delegate : MGCarouselViewDelegate?{
        didSet{
            reload()
        }
    }
    
    /*! 定时器额 */
    public var animationTimer:Timer?
    
    public lazy var page: UIPageControl = {
        let page = UIPageControl()
        page.isUserInteractionEnabled = false
        page.pageIndicatorTintColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        page.currentPageIndicatorTintColor = UIColor.white
        page.hidesForSinglePage = true
        page.alpha = 0.7
        return page
    }()
    
    public lazy var bottomBgImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        return imageView
    }()

    //MARK: - 私有属性
    
    fileprivate lazy var carousel: iCarousel = {
        let carousel = iCarousel()
        carousel.delegate = self
        carousel.dataSource = self
        carousel.type = .linear
        carousel.decelerationRate = 1;
        carousel.scrollToItemBoundary = true;
        carousel.stopAtItemBoundary = true;
        carousel.isPagingEnabled = true
        carousel.bounces = true;
        return carousel
    }()
    
    fileprivate var carouseData:[Any] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configureView()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        carousel.frame = bounds
        page.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 30)
        let pageCenterY = bounds.maxY*9.0/10.0 < 15 ? 15 : bounds.maxY*9.0/10.0
        page.center = CGPoint(x: carousel.center.x, y: pageCenterY)
        bottomBgImageView.frame = CGRect(x: 0, y: carousel.frame.height - shadeHeight, width: carousel.frame.width, height: shadeHeight)
    }
}

extension MGCarouselView {

    /*! 刷新第一列数据 */
    public func reload(){
        let listData = delegate?.configureListData() ?? []
        carouseData = listData
        carousel.reloadData()
        if carouseData.count == 0{
            pause()
        }
        else
        {
            resume()
        }
    }
}

extension MGCarouselView {
    
    fileprivate func configureView() {
        addSubview(carousel)
        addSubview(bottomBgImageView)
        addSubview(page)
    }

    @objc fileprivate func animationTimerDidFired(_ timer:Timer){
        let index = carousel.currentItemIndex + 1 == carousel.numberOfItems ? 0:carousel.currentItemIndex + 1
        carousel.scrollToItem(at: index, animated: true)
        carousel.itemView(at: index)?.frame = self.bounds
    }
}

extension MGCarouselView : iCarouselDelegate{
    
    public func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat
    {
        switch (option) {
        case iCarouselOption.wrap: //循环显示
            return carouseData.count > 1 ? 1 : 0
        case iCarouselOption.visibleItems: //3个后重用
            return 3;
        default:
            return value;
        }
    }
    
    public func carouselWillBeginDragging(_ carousel: iCarousel) {
        pause()
        
    }
    
    public func carouselDidEndDragging(_ carousel: iCarousel, willDecelerate decelerate: Bool) {
        resumeTimer(afterTimeInterval: autoAnimation)
    }
    
    
    public func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        guard let `delegate` = delegate else { return }
        delegate.selectCarousel(index, viewAt: carouseData[index])
    }
    
    public func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        page.currentPage = carousel.currentItemIndex
    }
}

extension MGCarouselView : iCarouselDataSource{
    
    public func numberOfItems(in carousel: iCarousel) -> Int{
        page.numberOfPages = carouseData.count
        return carouseData.count
    }
    
    public func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView{
        guard let `delegate` = delegate else { return UIView()}
        let contentView = delegate.carousel(index, reusing: view, viewOf: carouseData[index])
        return contentView
    }
}

