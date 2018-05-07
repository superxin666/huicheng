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

    /// 类型显示 0：是否入账 1：送达 2 付费方式
    var showType = 0

    /// 送达方式 0-上门自取;1-快递邮寄
    var sendtype = "0"
    ///是否已入帐 0-未入帐;1-已入帐
    var isbooksStr = "0"
    /// 快递-付费方式 0-收件人付费;1-律师帐扣
    var paytype = "0"

    var lastBtn : UIButton!


    /// 发票申请 选项
    ///
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - leftStr: <#leftStr description#>
    ///   - rightStr: <#rightStr description#>
    ///   - show: 0：是否入账 1：送达方式 2 付费方式
    func setData(title:String,leftStr: String,rightStr:String,show : Int)  {
        showType = show
        self.titleNameLabel.text = title
        
        self.leftBtn.setTitle(leftStr, for: .normal)
        self.rightBtn.setTitle(rightStr, for: .normal)
        if showType == 0 {
            self.leftBtn.tag = 10
            self.rightBtn.tag = 100
        } else if showType == 1 {
            self.leftBtn.tag = 20
            self.rightBtn.tag = 200
        } else{
            self.leftBtn.tag = 30
            self.rightBtn.tag = 300
        }
    }


    func setSelected(selectedType : String) {
        if selectedType == "0" {
            rightBtn.isSelected = false
            leftBtn.isSelected = true

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

        if tagNum == 10 {
            //是否入账
            isbooksStr = "0"
            str = isbooksStr
        } else if tagNum == 100 {
            isbooksStr = "1"
            str = isbooksStr
        } else if tagNum == 20 {
            // 送达方式
            sendtype = "0"
            str = sendtype

        } else if tagNum == 200{
            sendtype = "1"
            str = sendtype

        } else if tagNum == 30{
            paytype = "0"
            str = paytype
        } else {
            paytype = "1"
            str = paytype
        }
        self.delegate.selectedClickDelegate(tag: tagNum, type: str)
    }




    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lastBtn = leftBtn

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
