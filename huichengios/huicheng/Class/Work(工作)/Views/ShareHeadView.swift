//
//  ShareHeadView.swift
//  huicheng
//
//  Created by lvxin on 2018/4/24.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class ShareHeadView: UIView,NibLoadable {

    @IBOutlet weak var listBtn: UIButton!
    

    var lastBtn : UIButton!

    @IBOutlet weak var mineBtn: UIButton!
    

    @IBAction func btnclick(_ sender: UIButton) {
        HCLog(message: "点击")
        if sender.isSelected {
            return
        }
        let tagNum = sender.tag
        HCLog(message: "点击\(tagNum)")
        lastBtn.isSelected = sender.isSelected
        sender.isSelected = !sender.isSelected
        lastBtn = sender

    }

    override func awakeFromNib() {
        self.lastBtn = listBtn
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
