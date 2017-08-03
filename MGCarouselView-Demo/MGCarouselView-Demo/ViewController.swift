//
//  ViewController.swift
//  MGCarouselView-Demo
//
//  Created by song on 2017/8/2.
//  Copyright © 2017年 song. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var carouselView: MGCarouselView!{
        didSet{
          carouselView.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : MGCarouselViewDelegate{
    
    func configureListData() -> [Any]?{
        var models = [MGImageModel]()
        for index in 0...2 {
            let model = MGImageModel()
            model.imageName = "bannerCameraman-\(index)"
            models.append(model)
        }
        return models
    }
    
    func carousel(_ index: Int, reusing view: UIView?, viewOf data: Any) -> UIView{
        var contentView:MGCarouselContentView!
        if (view == nil)
        {
            /*! 自定义View */
            contentView = Bundle.main.loadNibNamed("MGCarouselContentView", owner: nil, options: nil)!.first as! MGCarouselContentView
            contentView.titleLabel.isHidden = true
        }
        else
        {
         }
        contentView.frame = carouselView.bounds
        let imageModel = data as!MGImageModel
        contentView.imageView.image = UIImage(named: imageModel.imageName!)
        
        return contentView
    }
    
    func selectCarousel(_ index: Int,viewAt data: Any){
    
    }
}

