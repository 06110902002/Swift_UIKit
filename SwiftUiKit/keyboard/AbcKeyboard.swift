//
//  AbcKeyboard.swift
//  SwiftUiKit
//
//  Created by Liu Xiaobing on 2020/5/26.
//  Copyright © 2020 Liu HuLai. All rights reserved.
//

import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let FIT_WIDTH = SCREEN_WIDTH / 320.0


class AbcKeyboard: KeyboardBaseView {

    lazy var array = NSMutableArray.init(objects:
        "q","w","e","r","t","y","u","i","o","p",
        "a","s","d","f","g","h","j","k","l",
        "z","x","c","v","b","n","m")
    var capitalKeyBgImg :UIImageView?
    
    override func createView(inputView targetView: UITextField, addOnClickListener listener: OnKeyListener) {
        super.createView(inputView: targetView, addOnClickListener: listener)
        for view in self.subviews{
            view.removeFromSuperview()
        }

        self.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "bgs.png")!)
        for i in 0..<10{
            createKey(titleTxt: array[i] as! String,
                          posX: 1 + CGFloat(i) * 32.0 * FIT_WIDTH,
                          posY: 5 * FIT_WIDTH,
                         width: 34 * FIT_WIDTH,
                         hight: 48 * FIT_WIDTH,
                         forId: i + 100,
                     normalImg: "tu1 (2).png",
                  highLightimg: "tu1 2.png")
        }
        
        for i in 0..<9{
            createKey(titleTxt: array[i + 10] as! String,
                          posX: 16 + CGFloat(i) * 32.0 * FIT_WIDTH,
                          posY: 53 * FIT_WIDTH,
                         width: 34 * FIT_WIDTH,
                         hight: 48 * FIT_WIDTH,
                         forId: i + 110,
                     normalImg: "tu1 (2).png",
                  highLightimg: "tu1 2.png")
        }
        
        for i in 0..<7{
            createKey(titleTxt: array[i + 19] as! String,
                      posX: 46.0 * FIT_WIDTH + CGFloat(i) * 32.0 * FIT_WIDTH,
                          posY: 103 * FIT_WIDTH,
                         width: 34 * FIT_WIDTH,
                         hight: 48 * FIT_WIDTH,
                         forId: i + 119,
                     normalImg: "tu1 (2).png",
                  highLightimg: "tu1 2.png")
        }
        
        //删除键
        createKey(titleTxt: "",
                  posX: 272.0 * FIT_WIDTH,
                posY: 103 * FIT_WIDTH,
               width: 43 * FIT_WIDTH,
               hight: 49 * FIT_WIDTH,
               forId: DELETE,
           normalImg: "tu2 2.png",
        highLightimg: "tu2 (2).png")
        
        let deleteKeyBgImg = UIImageView.init(frame: CGRect.init(x: 277*FIT_WIDTH, y:113*FIT_WIDTH, width:32*FIT_WIDTH, height:28*FIT_WIDTH))
        deleteKeyBgImg.image = UIImage.init(named: "tu2 (3).png")
        self.addSubview(deleteKeyBgImg)
        
        //大小切换键
        createKey(titleTxt: "",
                  posX: 1.0 ,
                posY: 103 * FIT_WIDTH,
               width: 43 * FIT_WIDTH,
               hight: 49 * FIT_WIDTH,
               forId: CAPTIAL,
           normalImg: "tu2 2.png",
        highLightimg: "tu2 (2).png")
        
        let capitalKey = self.viewWithTag(CAPTIAL) as! UIButton
        capitalKey.setBackgroundImage(UIImage.init(named: "tu2 (2).png"), for: .selected)
        
        capitalKeyBgImg = UIImageView.init(frame: CGRect.init(x: 7*FIT_WIDTH, y:113*FIT_WIDTH, width:31*FIT_WIDTH, height:27*FIT_WIDTH))
        capitalKeyBgImg!.image = UIImage.init(named: "da_.png")
        self.addSubview(capitalKeyBgImg!)
        
        //数字123键
        createKey(titleTxt: "",
                  posX: 1.0 ,
                posY: 152 * FIT_WIDTH,
               width: 80 * FIT_WIDTH,
               hight: 49 * FIT_WIDTH,
               forId: SWITCH_TYPE,
           normalImg: "tu3-4",
        highLightimg: "tu3-04 (2).png")
        
        let num123Label = UILabel.init()
        num123Label.frame = self.viewWithTag(SWITCH_TYPE)!.frame
        num123Label.backgroundColor = UIColor.clear
        num123Label.textColor = UIColor.white
        num123Label.textAlignment = .center
        num123Label.font = UIFont.init(name: "STHeitiSC-Light", size: 18.0 * FIT_WIDTH)
        num123Label.text = "1 2 3"
        self.addSubview(num123Label)
        
        //space键
        createKey(titleTxt: " ",
                  posX: 80 * FIT_WIDTH,
                posY: 152 * FIT_WIDTH,
               width: 160 * FIT_WIDTH,
               hight: 49 * FIT_WIDTH,
               forId: SPACE,
           normalImg: "tu4 (2).png",
        highLightimg: "tu4 2.png")
        
        let spaceLabel = UILabel.init()
        spaceLabel.frame = self.viewWithTag(SPACE)!.frame
        spaceLabel.backgroundColor = UIColor.clear
        spaceLabel.textColor = UIColor.white
        spaceLabel.textAlignment = .center
        spaceLabel.font = UIFont.init(name: "STHeitiSC-Light", size: 18.0 * FIT_WIDTH)
        spaceLabel.text = " "
        self.addSubview(spaceLabel)
        
        createKey(titleTxt: " ",
                  posX: SCREEN_WIDTH - 80 * FIT_WIDTH,
                posY: 152 * FIT_WIDTH,
               width: 80 * FIT_WIDTH,
               hight: 49 * FIT_WIDTH,
               forId: SEARCH,
           normalImg: "tu4 (2).png",
        highLightimg: "tu4 2.png")
        
        let searchLabel = UILabel.init()
        searchLabel.frame = self.viewWithTag(SEARCH)!.frame
        searchLabel.backgroundColor = UIColor.clear
        searchLabel.textColor = UIColor.blue
        searchLabel.textAlignment = .center
        searchLabel.font = UIFont.init(name: "STHeitiSC-Light", size: 14.0 * FIT_WIDTH)
        searchLabel.text = "搜索"
        self.addSubview(searchLabel)
    }
    
    override func switchCaptial(button view: UIButton) {
        if view.isSelected {
            view.isSelected = false
            capitalKeyBgImg?.image = UIImage.init(named: "da_.png")
            
            for(idx,obj) in array.enumerated(){
                let tmp = obj as! String
                array[idx] = tmp.lowercased()
                let key = self.viewWithTag(100 + idx) as! UIButton
                key.setTitle(tmp.lowercased(), for: .normal)
            }
            
        }else{
            view.isSelected = true
            capitalKeyBgImg?.image = UIImage.init(named: "da.png")
            for(idx,obj) in array.enumerated(){
                let tmp = obj as! String
                array[idx] = tmp.uppercased()
                let key = self.viewWithTag(100 + idx) as! UIButton
                key.setTitle(tmp.uppercased(), for: .normal)
            }
            
        }
         
    }
    
    override func switchKeyboardType() {
        var numKeyboard = KeyboardMgr.shareInstace.keyboardInstanceDict[NumberKeyboard.self.description()]
        if(numKeyboard == nil){
            numKeyboard = NumberKeyboard.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 260))
            KeyboardMgr.shareInstace.keyboardInstanceDict[NumberKeyboard.self.description()] = numKeyboard
        }
        KeyboardMgr.shareInstace.setInputMethodKeyboard(keyboardview: numKeyboard!,
                                                        inputView: textFiled!,
                                                        onKeyClickListener: onClickListener!)
        textFiled?.reloadInputViews()
    }

}
