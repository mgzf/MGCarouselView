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
//  MGCarouselContentView.swift
//  MGCarouselView-Demo
//
//  Created by song on 2017/8/3.
//  Copyright © 2017年 song. All rights reserved.
//

open class MGImageModel: AnyObject {
    var imageUrl : String?
    var imageName : String?
    var placeholderImageName : String?
    var title : String?
}

import UIKit

open class MGCarouselContentView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
}
