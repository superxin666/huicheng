//
//  ConbenTopView.swift
//  huicheng
//
//  Created by lvxin on 2018/3/22.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class ConbenTopView: UIView,NibLoadable {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
     @IBOutlet weak var zhongcaiweiBtn: UIButton!
     */
    @IBOutlet weak var kanshousuoBtn: UIButton!
    @IBOutlet weak var gonganjiguanBtn: UIButton!
    
    @IBOutlet weak var fayuanBtn: UIButton!
    
    @IBOutlet weak var jianchayuanBtn: UIButton!
    
    @IBOutlet weak var zhongcaiweiBtn: UIButton!
    
    
    /// 上次的btn
    var lastBtn : UIButton!
    override func awakeFromNib() {
        lastBtn = fayuanBtn
    }
    
    @IBAction func btnClick(_ sender: UIButton) {
        if sender.isSelected {
            return
        }
        lastBtn.isSelected = sender.isSelected
        sender.isSelected = !sender.isSelected
        lastBtn = sender
        
        switch sender.tag {
        case 0:
             HCLog(message: "法院")
        case 1:
             HCLog(message: "检察院")
        case 2:
             HCLog(message: "公安机关")
        case 3:
             HCLog(message: "仲裁委")
        case 4:
             HCLog(message: "看守所")
        default:
            HCLog(message: "没有")
        }
    }
    
}
