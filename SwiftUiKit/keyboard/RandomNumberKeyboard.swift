//
//  RandomNumberKeyboard.swift
//  SwiftUiKit
//
//  Created by Liu Xiaobing on 2020/5/26.
//  Copyright © 2020 Liu HuLai. All rights reserved.
//

import UIKit

class RandomNumberKeyboard: KeyboardBaseView {

    lazy var logoLabel        : UILabel = UILabel()
    var colSpace              : CGFloat = 5.0;
    var rowSpace              : CGFloat = 5.0
    lazy var randomNumArray   : NSMutableArray = NSMutableArray.init()
    
    override init(frame: CGRect) {
       super.init(frame: frame)
       self.backgroundColor = UIColor.gray
       createLogoView()
        
        for i in 0..<10 {
            randomNumArray.add(NSString.init(format: "%d", i))
        }
    }
       
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
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
    
    override func createView(inputView targetView: UITextField, addOnClickListener listener: OnKeyListener) {
        super.createView(inputView: targetView, addOnClickListener: listener)
        createNumberAndRandom()
    }
    
    func createNumberAndRandom() {
        //随机乱序
        for i in (1...10).reversed() {
            let random = arc4random_uniform(UInt32(i))
            let tmp = self.randomNumArray[Int(random)];
            self.randomNumArray[Int(random)] = self.randomNumArray[i - 1];
            self.randomNumArray[i - 1] = tmp;
        }
        
        let width = (self.frame.size.width - self.colSpace * 4) / 3
        let height = (self.frame.size.height - self.logoLabel.frame.size.height - self.rowSpace * 4 ) / 4
        
        for(i, item)in randomNumArray.enumerated(){
            
            if(i == 0){
                createKey(titleTxt: item as! String,
                          posX: self.colSpace * 2 +  width,
                          posY: self.logoLabel.frame.size.height + self.rowSpace * 3 + height * 3,
                          width: width,
                          hight: height,
                          forId: i,
                          normalImg: "anniu1.png",
                          highLightimg: "anniu1_select.png")
                
            }else{
            
               let indexColSpace = self.colSpace + self.colSpace * CGFloat(i % 3)
               let indexWidth = width * CGFloat(i % 3)
               let x = indexColSpace +  indexWidth
               
               let indexRowSpace = self.logoLabel.frame.size.height + self.rowSpace * CGFloat((i - 1) / 3)
               let indexRowHeight = height * CGFloat((i - 1) / 3)
               let y = indexRowSpace + indexRowHeight
               
                createKey(titleTxt: item as! String,
                            posX: x,
                            posY: y,
                            width: width,
                            hight: height,
                            forId: i,
                            normalImg: "anniu1.png",
                            highLightimg: "anniu1_select.png")
            }
            
        }
        
        createKey(titleTxt: "ABC",
                             posX: self.colSpace,
                             posY: self.logoLabel.frame.size.height + self.rowSpace * 3 + height * 3,
                             width: width,
                             hight: height,
                             forId: ABC,
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
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        createNumberAndRandom()
    }

}
