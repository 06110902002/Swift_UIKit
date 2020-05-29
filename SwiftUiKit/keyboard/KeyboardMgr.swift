//
//  KeyboardMgr.swift
//  SwiftUiKit
//
//  Created by Liu Xiaobing on 2020/5/26.
//  Copyright © 2020 Liu HuLai. All rights reserved.
//  键盘管理类，整个键盘的实现方式使用策略模式

import UIKit

class KeyboardMgr: UIView {

    var keyboard : KeyboardBaseView?
    static let shareInstace = KeyboardMgr()
    
    lazy var keyboardInstanceDict : [String : KeyboardBaseView] = Dictionary()
    
    func setInputMethodKeyboard(keyboardview keyboard : KeyboardBaseView,
                                inputView textfiled:UITextField,
                                onKeyClickListener listener:OnKeyListener) {
        self.keyboard = keyboard
        self.keyboard?.createView(inputView: textfiled, addOnClickListener: listener)
        keyboardInstanceDict[keyboard.description] = keyboard
    }

}
