//
//  ConbenTopView.swift
//  huicheng
//
//  Created by lvxin on 2018/3/22.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
protocol ConbenTopViewDelegate {
    
    /// 按钮点击
    ///
    /// - Parameter tag: tag
    func btnClick(tag : Int)
}
class ConbenTopView: UIView,NibLoadable {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
     */
    @IBOutlet weak var kanshousuoBtn: UIButton!
    @IBOutlet weak var gonganjiguanBtn: UIButton!
    
    @IBOutlet weak var fayuanBtn: UIButton!
    
    @IBOutlet weak var jianchayuanBtn: UIButton!
    
    @IBOutlet weak var zhongcaiweiBtn: UIButton!
    
    var delegate : ConbenTopViewDelegate!
    
    
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
                if !(self.delegate == nil) {
            self.delegate.btnClick(tag: sender.tag)
        }
    }
    
}
