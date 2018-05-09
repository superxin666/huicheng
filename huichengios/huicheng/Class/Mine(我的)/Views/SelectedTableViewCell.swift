//
//  SelectedTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/4/24.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

let SelectedTableViewCellH = CGFloat(50)
let SelectedTableViewCellID = "SelectedTableViewCell_id"

protocol SelectedTableViewCellDelegate {
    func selectedClickDelegate_type(tag : Int,type : String)
}

class SelectedTableViewCell: UITableViewCell {
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var specialBtn: UIButton!
    @IBOutlet weak var normalBtn: UIButton!
    var delegate : SelectedTableViewCellDelegate!
    var lastBtn : UIButton!

    /// 0-增值税普通发票;1-增值税专用发票  0-未开;1-已开
    var invoiceType = "0"



    /// 发票申请
    func setData_addinvoice() {
        normalBtn.isSelected = true
        lastBtn = normalBtn
    }

    /// 生成合同
    func setData_deal() {
        normalBtn.isSelected = true
        lastBtn = normalBtn
        self.titleNameLabel.text = "发票情况"

        normalBtn.setTitle("未开", for: .normal)
        specialBtn.setTitle("已开", for: .normal)
    }

    func setData_dealcheckdetail(state : String) {
        if state == "1" {
            specialBtn.isSelected = false

            normalBtn.isSelected = true
            lastBtn = normalBtn
        } else {
            normalBtn.isSelected = false

            specialBtn.isSelected = true
            lastBtn = specialBtn
        }

        self.titleNameLabel.text = "审核状态"
        normalBtn.setTitle("审核通过", for: .normal)
        specialBtn.setTitle("驳回审核", for: .normal)
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
            self.delegate.selectedClickDelegate_type(tag: 0, type: invoiceType)
        }

    }



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
