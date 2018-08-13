//
//  ShareHeadView.swift
//  huicheng
//
//  Created by lvxin on 2018/4/24.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
protocol ShareHeadViewDelegate {
    func headViewClick(tagNum : Int)
}

class ShareHeadView: UIView,NibLoadable {
    var delegate : ShareHeadViewDelegate!

    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var listBtn: UIButton!
    

    var lastBtn : UIButton!
    var lastView : UIView!


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

//        if tag == 0 {
//            leftView.isHidden = false
//            rightView.isHidden = true
//
//        } else {
//            leftView.isHidden = true
//            rightView.isHidden = false
//        }

        leftView.isHidden = !listBtn.isSelected
        rightView.isHidden = !mineBtn.isSelected




        if (delegate != nil) {
            self.delegate.headViewClick(tagNum: tagNum)
        }

    }

    override func awakeFromNib() {
        self.lastBtn = listBtn
        self.lastView = leftView
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
