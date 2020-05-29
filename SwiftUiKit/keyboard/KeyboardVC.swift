//
//  KeyboardVC.swift
//  SwiftUiKit
//
//  Created by Liu Xiaobing on 2020/5/25.
//  Copyright © 2020 Liu HuLai. All rights reserved.
//

import UIKit

class KeyboardVC: UIViewController {
    
    lazy var textFiled : UITextField = UITextField.init(frame: CGRect.init(x: 20, y: 150, width: 100, height: 50))

    override func viewDidLoad() {
        super.viewDidLoad()

        //重新创建一个barButtonItem
        self.navigationController?.isNavigationBarHidden = false

        let backItem = UIBarButtonItem.init(title: "Back", style: .done, target: self, action: #selector(onClickListener))
        backItem.tag = 50
        //设置backBarButtonItem即可
        self.navigationItem.leftBarButtonItem = backItem;
        self.navigationItem.title = "标题文字"
        self.view.backgroundColor = UIColor.white
        
    
        textFiled.backgroundColor = UIColor.gray
        self.view.addSubview(textFiled)
        
        let keyBoardView = AbcKeyboard.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 260))
        
        KeyboardMgr.init().setInputMethodKeyboard(keyboardview: keyBoardView, inputView: textFiled, onKeyClickListener: self)
        
        
    
        
        
    }
    
    @objc func onClickListener(){
        self.navigationController?.popViewController(animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//实现键盘按钮点击协议
extension KeyboardVC:OnKeyListener{
    
    func onClick(button view: UIButton) {
        print("60---\(String(describing: view.titleLabel?.text))")
    }
    
    func addTextWatch(button view: UIButton, beforeText bStr: String?, curText cStr: String?, afterText aStr: String?) {
        print("65-----beforetext:\(bStr) curtext:\(cStr) aftertext:\(aStr)")
        textFiled.text = aStr
    }
}
