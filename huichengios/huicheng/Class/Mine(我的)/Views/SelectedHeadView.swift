//
//  SelectedHeadView.swift
//  huicheng
//
//  Created by lvxin on 2018/8/27.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let SelectedHeadViewH = CGFloat(50)
let SelectedHeadViewID = "SelectedHeadView_id"

protocol SelectedHeadViewDelegate {
    func selectedHeadViewDelegate_type(tag : Int,type : String)
}

class SelectedHeadView: UIView,NibLoadable {

    var delegate : SelectedHeadViewDelegate!
    var lastBtn : UIButton!



    @IBOutlet weak var titleNameLbael: UILabel!
    @IBOutlet weak var leftBtn: UIButton!

    @IBOutlet weak var rightBtn: UIButton!

    /// 0-增值税普通发票;1-增值税专用发票
    var invoiceType = "0"

    func setSelected(type : String) {
        if type == "0" {
            leftBtn.isSelected = true
            rightBtn.isSelected = false
        } else {
            leftBtn.isSelected = false
            rightBtn.isSelected = true
        }
    }

    @IBAction func btnClick(_ sender: UIButton) {

        HCLog(message: "点击")
        if sender.isSelected {
            return
        }
        let tagNum = sender.tag
        HCLog(message: "点击\(tagNum)")
        lastBtn.isSelected = sender.isSelected
        sender.isSelected = !sender.isSelected
        lastBtn = sender

        if sender.tag == 0 {
            //普通
            invoiceType = "0"
        } else {
            //专项
            invoiceType = "1"
        }
        if self.delegate != nil {
            self.delegate.selectedHeadViewDelegate_type(tag: 0, type: invoiceType)
        }
    }
    
    override func awakeFromNib() {
        lastBtn = leftBtn
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
