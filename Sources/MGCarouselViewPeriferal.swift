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
//  MGCarouselViewPeriferal.swift
//  MGCarouselView-Demo
//
//  Created by song on 2017/8/2.
//  Copyright © 2017年 song. All rights reserved.
//

import UIKit

public protocol MGTimerFetching : class {
    
    var autoAnimation :Double { get set }
    
    var animationTimer:Timer? { get set }
    
    func pause()
    
    func resume()
    
    func resumeTimer(afterTimeInterval: TimeInterval)
}


extension MGTimerFetching{
    public func pause(){
        guard let `animationTimer` = animationTimer else { return }
        if animationTimer.isValid {
            animationTimer.fireDate = Date.distantFuture
        }
    }
    
    public func resume(){
        guard let `animationTimer` = animationTimer else { return }
        if animationTimer.isValid {
            animationTimer.fireDate = Date()
        }
    }
    
    public func resumeTimer(afterTimeInterval: TimeInterval){
        guard let `animationTimer` = animationTimer else { return }
        if animationTimer.isValid {
            animationTimer.fireDate = Date(timeIntervalSinceNow: afterTimeInterval)
        }
    }
}


public protocol  MGCarouselViewDelegate : class {
    
    /// 数据源传递
    ///
    /// - Returns: 数组对象
    func configureListData() -> [Any]?
    
    
    /// 展示的View
    ///
    /// - Parameters:
    ///   - index: 第几个轮播图
    ///   - view: 重用的View
    ///   - data: 需要的数据
    /// - Returns: 返回展示View
    func carousel(_ index: Int, reusing view: UIView?, viewOf data: Any) -> UIView
    
    
    /// 点击单个轮播图
    ///
    /// - Parameters:
    ///   - index: 下标
    ///   - data: 数据
    func selectCarousel(_ index: Int,viewAt data: Any)
    
}
