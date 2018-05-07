//
//  Selected2TableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/4/24.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let Selected2TableViewCellID = "Selected2TableViewCell_id"
let Selected2TableViewCellH = CGFloat(50)

protocol Selected2TableViewCellDelegate {
    func selectedClickDelegate(tag : Int,type : String)
}

class Selected2TableViewCell: UITableViewCell {
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!

    @IBOutlet weak var titleNameLabel: UILabel!

    var delegate : Selected2TableViewCellDelegate!

    /// 送达方式 0-上门自取;1-快递邮寄
    var sendtype = "0"

    ///是否已入帐 0-未入帐;1-已入帐
    var isbooksStr = "0"

    var lastBtn : UIButton!

    /// 是否入账
    ///
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - leftStr: <#leftStr description#>
    ///   - right: <#right description#>
    func setDataAddInvoice(title:String,leftStr: String,rightStr:String,indexPath : IndexPath)  {
        self.titleNameLabel.text = title
        self.leftBtn.setTitle(leftStr, for: .normal)
        self.rightBtn.setTitle(rightStr, for: .normal)

        self.leftBtn.tag = indexPath.section * 10 + indexPath.row
        self.rightBtn.tag = 100 + indexPath.section * 10 + indexPath.row
        leftBtn.isSelected = true
        lastBtn = leftBtn
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

        if tagNum == 10 {
            //是否入账
            isbooksStr = "0"
            str = isbooksStr
        } else if tagNum == 110 {
            isbooksStr = "1"
            str = isbooksStr
        } else if tagNum == 11 {
            // 送达方式
            sendtype = "0"
            str = sendtype
        } else if tagNum == 111 {
            sendtype = "1"
            str = sendtype
        }


        if (self.delegate) != nil  {
            delegate.selectedClickDelegate(tag: tagNum, type: str)
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
