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


class SelectedTableViewCell: UITableViewCell {
    @IBOutlet weak var specialBtn: UIButton!
    @IBOutlet weak var normalBtn: UIButton!

    var lastBtn : UIButton!

    /// 0-增值税普通发票;1-增值税专用发票
    var invoiceType = "0"



    /// 发票申请
    func setData_addinvoice() {
        normalBtn.isSelected = true
        lastBtn = normalBtn
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
