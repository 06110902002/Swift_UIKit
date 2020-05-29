//
//  NumberKeyboard.swift
//  SwiftUiKit
//
//  Created by Liu Xiaobing on 2020/5/25.
//  Copyright © 2020 Liu HuLai. All rights reserved.
//

import UIKit

class NumberKeyboard: KeyboardBaseView {
    
    lazy var logoLabel:UILabel = UILabel()
    var colSpace : CGFloat = 5.0;
    var rowSpace : CGFloat = 5.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
        createLogoView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func createView(inputView targetView: UITextField,addOnClickListener listener:OnKeyListener) {
        super.createView(inputView: targetView,addOnClickListener: listener)
        for view in self.subviews{
            view.removeFromSuperview()
        }
        let width = (self.frame.size.width - self.colSpace * 4) / 3
        let height = (self.frame.size.height - self.logoLabel.frame.size.height - self.rowSpace * 4 ) / 4
        for i in 1..<10{
            
            let indexColSpace = self.colSpace * CGFloat((i - 1) % 3)
            let indexWidth = width * CGFloat((i - 1) % 3)
            let x = self.colSpace + indexColSpace +  indexWidth
            
            let indexRowSpace = self.rowSpace * CGFloat((i - 1) / 3)
            let indexRowHeight = height * CGFloat((i - 1) / 3)
            let y = 44 + indexRowSpace + indexRowHeight
            
            createKey(titleTxt: String.init(format: "%d", i),
                      posX: x,
                      posY: y,
                      width: width,
                      hight: height,
                      forId: i,
                  normalImg: "anniu1.png",
               highLightimg: "anniu1_select.png")
        }
        
        createKey(titleTxt: "ABC",
                             posX: self.colSpace,
                             posY: self.logoLabel.frame.size.height + self.rowSpace * 3 + height * 3,
                             width: width,
                             hight: height,
                             forId: ABC,
                             normalImg: "anniu1.png",
                             highLightimg: "anniu1_select.png")
        
        createKey(titleTxt: String.init(format: "%d", 0),
                        posX: self.colSpace * 2 + width,
                        posY: self.logoLabel.frame.size.height + self.rowSpace * 3 + height * 3,
                        width: width,
                        hight: height,
                        forId: 0,
                        normalImg: "anniu1.png",
                        highLightimg: "anniu1_select.png")
        
        createKey(titleTxt: "X",
                        posX: self.colSpace * 3 + width * 2,
                        posY: self.logoLabel.frame.size.height + self.rowSpace * 3 + height * 3,
                        width: width,
                        hight: height,
                        forId: DELETE,
                        normalImg: "anniu1.png",
                        highLightimg: "anniu1_select.png")
        
        
    }
    
    func createLogoView(){
        self.logoLabel.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 44)
        self.addSubview(self.logoLabel)
        self.logoLabel.text = "硬汉安全键盘"
        self.logoLabel.textAlignment = .center
        logoLabel.font = UIFont.systemFont(ofSize: 14)
        logoLabel.textColor = UIColor.white
        
        let btnFinish = UIButton.init()
        btnFinish.frame = CGRect.init(x: self.frame.size.width - 100, y: 0, width: 100, height: 44)
        self.addSubview(btnFinish)
        btnFinish.tag = FINISH
        btnFinish.setTitle("完成", for: .normal)
        btnFinish.setTitleColor(UIColor.blue, for: .normal)
        btnFinish.addTarget(self, action: #selector(onClickListener(button:)), for:.touchUpInside)
        
    }
    
    override func switchKeyboardType() {
        var abcKeyboard = KeyboardMgr.shareInstace.keyboardInstanceDict[AbcKeyboard.self.description()]
               
       if(abcKeyboard == nil){
           abcKeyboard = AbcKeyboard.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 260))
           KeyboardMgr.shareInstace.keyboardInstanceDict[AbcKeyboard.self.description()] = abcKeyboard
       }
       KeyboardMgr.shareInstace.setInputMethodKeyboard(keyboardview: abcKeyboard!,
                                                       inputView: textFiled!,
                                                       onKeyClickListener: onClickListener!)
       textFiled?.reloadInputViews()
    }
    

}
