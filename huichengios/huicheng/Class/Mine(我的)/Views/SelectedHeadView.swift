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

    ///是否已入帐 0-未入帐;1-已入帐
    var isbooksStr = "0"


    /// 送达方式 0-上门自取;1-快递邮寄
    var sendtype = "0"




    func setBtnTitle_isbook() {
        self.leftBtn.tag = 10
        self.rightBtn.tag = 11
        self.titleNameLbael.text = "款项是否入账"
        self.leftBtn.setTitle("未入账", for: .normal)
        self.rightBtn.setTitle("已入账", for: .normal)

    }

    func setBtnTitle_sendtype() {
        self.leftBtn.tag = 20
        self.rightBtn.tag = 21

        self.titleNameLbael.text = "送达方式"
        self.leftBtn.setTitle("上门自取", for: .normal)
        self.rightBtn.setTitle("快递邮寄", for: .normal)


    }

    func setBtnTitle_type() {
        self.leftBtn.tag = 0
        self.rightBtn.tag = 1
    }


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
        var str = ""

        if sender.tag == 0 {
            //普通
            invoiceType = "0"
            str = invoiceType
        } else if sender.tag == 1 {
            //专项
            invoiceType = "1"
            str = invoiceType
        } else if sender.tag == 10 {
            //是否已入帐 0-未入帐;1-已入帐
            isbooksStr = "0"
            str = isbooksStr
        } else if sender.tag == 11 {
            isbooksStr = "1"
            str = isbooksStr

        } else if sender.tag == 20 {
            sendtype = "0"
            str = sendtype

        } else if sender.tag == 21 {
            sendtype = "1"
            str = sendtype

        }
        if self.delegate != nil {
            self.delegate.selectedHeadViewDelegate_type(tag: self.leftBtn.tag, type: str)
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
