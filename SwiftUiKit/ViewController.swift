//
//  ViewController.swift
//  SwiftUiKit
//
//  Created by Liu Xiaobing on 2020/5/21.
//  Copyright © 2020 Liu HuLai. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var scrollLabel:ScrollLabel?
    lazy var upLabel : UIButton = UIButton.init();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white


        let button = UIButton();
        button.backgroundColor = UIColor.gray
        button.tag = 19;
        button.frame = CGRect.init(x: 120, y: 50, width: 100, height: 50)
        button.addTarget(self, action: #selector(onClickListener(btn:)), for:.touchUpInside)
        button.setTitle("键盘", for: .normal);
        self.view.addSubview(button);
        
        
        

        self.upLabel.backgroundColor = UIColor.green;
       self.upLabel.tag = 21;
       self.upLabel.addTarget(self, action: #selector(onClickListener(btn:)), for:.touchUpInside)
       self.upLabel.setTitle("start", for:.normal)
       self.upLabel.frame = CGRect.init(x: 10, y: 50, width: 100, height: 50)
        self.view.addSubview(upLabel)
        
        let parentView : UIView = UIView.init(frame: CGRect.init(x: 50, y: 160, width: 180, height: 40))
        self.view.addSubview(parentView)
        parentView.backgroundColor = UIColor.blue
        parentView.clipsToBounds = true
        
        let array:NSMutableArray = NSMutableArray.init(objects: "香辣肉丝","听你讲个故事","听你唱首歌",
        "高考","大学","工作","生活")
        
        scrollLabel = ScrollLabel();
        scrollLabel?.setTarget(parentView, withTitleArray: array)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
         self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func onClickListener(btn : UIButton?)  {
           switch btn?.tag {
           case 21,22:
            scrollLabel?.start()
               break;
            
           case 19:
            self.navigationController?.pushViewController(KeyboardVC(), animated: false);
//            if (btn?.titleLabel?.text?.elementsEqual("键盘"))! {
//                btn?.setTitle("123", for: .normal)
//            }else{
//                btn?.setTitle("键盘", for: .normal)
//            }
            break;
            
           default:
            
               break;
           }
       }


}

