//
//  ScrollLabel.swift
//  SwiftUiKit
//
//  Created by Liu Xiaobing on 2020/5/21.
//  Copyright © 2020 Liu HuLai. All rights reserved.
//

import UIKit

class ScrollLabel: UIView {

    lazy var parentView : UIView = UIView.init();
    lazy var upLabel : UIButton = UIButton.init();
    lazy var bottom : UIButton = UIButton.init();
    lazy var titleArray:NSMutableArray = NSMutableArray.init();
    var index:NSInteger = 0;
    lazy var timer:Timer? = Timer.init()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setTarget(_ parentView:UIView, withTitleArray array:NSMutableArray) ->Void {
        self.parentView = parentView
        self.titleArray = array
        
        self.upLabel.backgroundColor = UIColor.green;
        self.upLabel.tag = 21;
        self.upLabel.addTarget(self, action: #selector(onClickListener(btn:)), for:.touchUpInside)
        self.upLabel.setTitle(self.titleArray.object(at: self.index) as? String, for:.normal)
        self.upLabel.frame = CGRect.init(x: 0, y: 0, width: parentView.frame.size.width, height: parentView.frame.size.height)
    
        self.index += 1
       self.bottom.backgroundColor = UIColor.brown;
       self.bottom.tag = 22;
       self.bottom.addTarget(self, action: #selector(onClickListener(btn:)), for:.touchUpInside)
        self.bottom.setTitle(self.titleArray.object(at: self.index) as? String, for:.normal)
       self.bottom.frame = CGRect.init(x: 0, y: parentView.frame.size.height, width: parentView.frame.size.width, height: parentView.frame.size.height)
        
        parentView.addSubview(self.upLabel)
        parentView.addSubview(self.bottom)
    }
    
    
    @objc func onClickListener(btn : UIButton?)  {
        switch btn?.tag {
        case 21,22:
            NSLog("----")
            break;
        default:
            break;
        }
    }
    
    public func start() -> Void {
        if self.titleArray.count == 1 {
            return;
        }
        if self.timer == nil {
            
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(onFire), userInfo: nil, repeats: true);
                
            self.timer?.fire()
        }
        
        
    }
    
    @objc func onFire() -> Void {
        
        UIView.transition(with: self.upLabel, duration: 2 * 0.5, options: .curveEaseInOut, animations: {
            self.upLabel.tx_bottom = 0
            
            UIView.transition(with: self.upLabel, duration: 2 * 0.5, options: .curveEaseInOut, animations: {
                           
                           self.bottom.y = 0;
                           
                       }, completion: {_ in
                           self.upLabel.y = self.parentView.height;
                           let tempLabel = self.upLabel;
                           self.upLabel = self.bottom;
                           self.bottom = tempLabel;
                           self.index += 1;
                           let title = self.titleArray.object(at: self.index % self.titleArray.count) as? String
                           tempLabel.setTitle(title, for:.normal)
                       })
            
            
        }, completion: {_ in
        
        })
        
    }
    
    public func stop(){
        if(self.timer != nil){
            self.timer!.invalidate()
            self.timer = nil;
        }
        
    }
    
}
