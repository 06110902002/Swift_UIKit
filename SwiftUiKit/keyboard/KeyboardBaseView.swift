//
//  KeyboardBaseView.swift
//  SwiftUiKit
//
//  Created by Liu Xiaobing on 2020/5/25.
//  Copyright © 2020 Liu HuLai. All rights reserved.
//  键盘视图基类

import UIKit

@objc protocol OnKeyListener {
    @objc optional func onClick(button view:UIButton);
    
    
    /// 文本观察监听接口
    /// - Parameters:
    ///   - view: 被观察的对象
    ///   - bStr: 观察之前的文本
    ///   - cStr: 当前u文本
    ///   - aStr: 编辑之后最终的文本
    @objc optional func addTextWatch(button view:UIButton,
                                     beforeText bStr:String?,
                                     curText cStr:String?,
                                     afterText aStr:String?);
    
}

class KeyboardBaseView: UIView {
    
    var textFiled       : UITextField?
    let DELETE          : NSInteger = 19;
    let FINISH          : NSInteger = 21;
    let ABC             : NSInteger = 22;
    let CAPTIAL         : NSInteger = 23;
    let SWITCH_TYPE     : NSInteger = 24;
    let SEARCH          : NSInteger = 25;
    let SPACE           : NSInteger = 98;
    
    
    var onClickListener : OnKeyListener?
    lazy var beforeText : String = String.init()
    lazy var curText    : String = String.init()
    lazy var afterText  : String = String.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func createView(inputView targetView:UITextField,addOnClickListener listener:OnKeyListener){
        self.textFiled = targetView;
        targetView.inputView = self
        self.onClickListener = listener
    }
    
    func createKey(titleTxt title:String,posX x:CGFloat, posY y:CGFloat, width w:CGFloat,hight h : CGFloat,forId id:NSInteger)->Void{
        self.createKey(titleTxt: title, posX: x, posY: y, width: w, hight: h, forId: id, normalImg: nil, highLightimg: nil)
    }
    
    func createKey(titleTxt title:String,
                   posX x:CGFloat,
                   posY y:CGFloat,
                   width w:CGFloat,
                   hight h : CGFloat,
                   forId id:NSInteger,normalImg norBgImg:String?, highLightimg himg:String?)->Void{
        
        let btnKey = UIButton();
        btnKey.frame = CGRect.init(x: x, y: y, width: w, height: h);
        self.addSubview(btnKey)
        btnKey.tag = id
        btnKey.setTitle(title, for: .normal)
        btnKey.setTitleColor(UIColor.black, for: .normal)
        btnKey.addTarget(self, action: #selector(onClickListener(button:)), for: .touchUpInside)
        guard let nImg = norBgImg else{
            btnKey.layer.cornerRadius = 5.0
            return
        }
        btnKey.setBackgroundImage(UIImage.init(named: nImg), for: .normal)
        guard let hImg = himg else{
            return
        }
        btnKey.setBackgroundImage(UIImage.init(named: hImg), for: .highlighted)
        
    }
    
    @objc func onClickListener(button:UIButton) {
        switch button.tag {
            case (0...10),(100...126):
                if self.onClickListener != nil {
                    self.onClickListener!.onClick?(button: button)
                }
                self.afterText.append(button.titleLabel!.text!)
                break;
                
            case ABC:
                switchKeyboardType()
                break;
            
        case SEARCH:
            
            break;
            
        case SWITCH_TYPE:
            switchKeyboardType()
            break;
            
        case CAPTIAL:
            switchCaptial(button: button)
            break;
                
            case DELETE:
                if !self.afterText.isEmpty{
                    let index = self.afterText.count - 1
                    self.afterText = self.afterText.prefix(index).description
                }
                break;
                
            case FINISH:
                hideKeyboard()
                break;
                
            default:
                break;
        }
        
        if self.onClickListener != nil && !(21...30).contains(button.tag){
            
            self.onClickListener?.addTextWatch?(button: button,
                                            beforeText: self.beforeText,
                                               curText: button.titleLabel!.text,
                                             afterText: self.afterText)
            self.beforeText = self.afterText;
        }
        
    }
    
    func hideKeyboard() {
        self.textFiled?.endEditing(true)
    }
    
    func switchCaptial(button view : UIButton) {
        
    }
    
    func switchKeyboardType() {
        
    }


}
