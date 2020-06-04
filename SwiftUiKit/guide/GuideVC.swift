//
//  GuideVC.swift
//  SwiftUiKit
//
//  Created by Liu Xiaobing on 2020/6/3.
//  Copyright © 2020 Liu HuLai. All rights reserved.
//

import UIKit

class GuideVC: UIViewController {
    
    //为已经创建好的常量 addCloser1 赋值

     let view1 = { () ->UIView in
          var view = UIView.init(frame: CGRect.init(x: 10, y: 50, width: 50, height: 50))
          view.backgroundColor = UIColor.green
          return view;
     }
    
    let view2 = { () ->UIView in
         var view = UIView.init(frame: CGRect.init(x: 70, y: 50, width: 50, height: 50))
         view.backgroundColor = UIColor.green
         return view;
    }
    
    let view3 = { () ->UIView in
         var view = UIView.init(frame: CGRect.init(x: 130, y: 50, width: 50, height: 50))
         view.backgroundColor = UIColor.green
         return view;
    }
    
    let view4 = { () ->UIView in
         var view = UIView.init(frame: CGRect.init(x: 10, y: 150, width: 50, height: 50))
         view.backgroundColor = UIColor.green
         return view;
    }
    
    let view5 = { () ->UIView in
         var view = UIView.init(frame: CGRect.init(x: 70, y: 150, width: 50, height: 50))
         view.backgroundColor = UIColor.green
        view.layer.cornerRadius = 25
         return view;
    }
    
    var views:NSMutableArray = NSMutableArray.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.view1())
        self.view.addSubview(self.view2())
        self.view.addSubview(self.view3())
        self.view.addSubview(self.view4())
        self.view.addSubview(self.view5())
        


        views.add(self.view1())
        views.add(self.view2())
        views.add(self.view3())
        views.add(self.view4())
        views.add(self.view5())

        
        
        createGuideLayer()
    }
    
    func createGuideLayer() -> Void {
//        let frame = UIScreen.main.bounds
//        let bgView = UIView.init(frame: frame)
//        bgView.backgroundColor = UIColor.black
//        bgView.alpha = 0.7
//        let tap = UITapGestureRecognizer.init(target: self, action: #selector(onTouchEvent))
//        bgView.addGestureRecognizer(tap)
////        let tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sureTapClick:)];
////          [bgView addGestureRecognizer:tap];
//
//
//        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
//        window?.addSubview(bgView)
//
//        let rect = self.view.convert(self.view1().frame, to: window)
//
//        let path = UIBezierPath.init(rect: frame)
//        path.append(UIBezierPath.init(roundedRect: rect, cornerRadius: 5).reversing())
//
//        //渲染路径
//        let shapeLayer = CAShapeLayer.init()
//        shapeLayer.path = path.cgPath
//        shapeLayer.strokeColor = UIColor.blue.cgColor
//        bgView.layer.mask = shapeLayer
        let guideView = GuideView.init()
        //guideView.show(targetView: self.view1(), cornerRadius: 5)
        guideView.show2(targetView: views, cornerRadius: 5)
        
    }
    
    @objc func onTouchEvent(_ tap:UITapGestureRecognizer) -> Void {
        
        let view = tap.view
        view?.removeFromSuperview()
        view?.removeGestureRecognizer(tap)
        
        
    }
    

    

}
