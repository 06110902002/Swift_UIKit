//
//  GuideView.swift
//  SwiftUiKit
//
//  Created by Liu Xiaobing on 2020/6/4.
//  Copyright © 2020 Liu HuLai. All rights reserved.
//  在任何视图上添加新手引导视图

import UIKit

class GuideView: UIView {
    
    var _currentIndex:CGFloat = 0
    public var currentIndex:CGFloat{
        get {
            return _currentIndex
        }
        set {
            _currentIndex = newValue
            if Int(newValue) == totalCount - 1{
                margin = 25
            }
            showGuideMask()
        }
    }
    
    var totalCount : NSInteger = 0
    lazy var maskLayer:CAShapeLayer = CAShapeLayer.init()
    
    lazy var targetViews:NSArray = NSArray.init()
    var margin : CGFloat = 0
    
    
    
    /// 显示指导层
    /// - Parameters:
    ///   - views: 视图集合
    ///   - margin: 边距
    func show2(targetView views:NSArray,cornerRadius margin:CGFloat)  {
        
        if views.count < 1 {
            return
        }
        totalCount = views.count
        
        let frame = UIScreen.main.bounds
        self.frame = frame
        self.backgroundColor = UIColor.black
        self.alpha = 0.0
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        window?.addSubview(self)
        UIView.animate(withDuration: 0.3, animations: {
                   () ->Void in
            self.alpha = 0.7
               })
        self.currentIndex = 0
        targetViews = views;
        self.margin = margin
        
        showGuideMask()
    }
    
    /**
      对于当前页面新手引导步骤比较多的则可以使用本接口
     */
    func showGuideMask() ->Void{
        if targetViews.count < 1 {
            return
        }
        
        let fromPath = maskLayer.path
        maskLayer.frame = self.bounds
        maskLayer.fillColor = UIColor.black.cgColor
        
        /// 获取可见区域的路径(开始路径)
        let visualPath = UIBezierPath.init(roundedRect: obtainVisualFrame(targetView: targetViews[Int(self.currentIndex)] as! UIView), cornerRadius: margin)
        
         /// 获取终点路径
        let toPath = UIBezierPath.init(rect: self.bounds)
        toPath.append(visualPath)
        
        /// 遮罩的路径
        self.maskLayer.path = toPath.cgPath;
        self.maskLayer.fillRule = .evenOdd;
           self.layer.mask = self.maskLayer;
        
        /// 开始移动动画
        let anim = CABasicAnimation.init(keyPath: "path")
        anim.duration = 0.3
        anim.fromValue = fromPath
        anim.toValue = toPath
        self.maskLayer.add(anim, forKey: nil)
        
    }
    
    /// 获取需要高亮部分的边框
    /// - Parameter view: 目标视图
    func obtainVisualFrame(targetView view:UIView) -> CGRect {
        
        var visualRect = self.convert(view.frame, from: view.superview)
        let maskInsets = UIEdgeInsets.init(top: -8, left: -8, bottom: -8, right: -8)
        
         visualRect.origin.x += maskInsets.left;
         visualRect.origin.y += maskInsets.top;
         visualRect.size.width  -= (maskInsets.left + maskInsets.right);
         visualRect.size.height -= (maskInsets.top + maskInsets.bottom);
        
        return visualRect
    }
    

    func show(targetView view:UIView) {
        show(targetView: view, cornerRadius: 0)
    }
    
    func show(targetView view:UIView,cornerRadius margin:CGFloat) -> Void {
        
        let frame = UIScreen.main.bounds
        self.frame = frame
        self.backgroundColor = UIColor.black
        self.alpha = 0.7
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(onTouchEvent))
        self.addGestureRecognizer(tap)
         
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        window?.addSubview(self)
        let rect = self.convert(view.frame, to: window)
        let path = UIBezierPath.init(rect: frame)
        path.append(UIBezierPath.init(roundedRect: rect, cornerRadius: margin).reversing())
        //渲染路径
        let shapeLayer = CAShapeLayer.init()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.blue.cgColor
        self.layer.mask = shapeLayer
        
        
    }
    
    @objc func onTouchEvent(_ tap:UITapGestureRecognizer) -> Void {
        print("93--------")
        let view = tap.view
        view?.removeFromSuperview()
        view?.removeGestureRecognizer(tap)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if Int(self.currentIndex) < totalCount - 1 {
            self.currentIndex += 1
        } else {
            hide()
        }
    }
    
    func hide() {
        
        UIView.animate(withDuration: 0.3, animations: {
            () ->Void in
            self.alpha = 0
        }, completion: {
                (finished:Bool) -> Void in
                self.removeFromSuperview()
        })
        
    }
    
    

}
