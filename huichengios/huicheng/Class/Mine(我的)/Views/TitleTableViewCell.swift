//
//  TitleTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/31.
//  Copyright © 2018年 lvxin. All rights reserved.
//  标题

import UIKit
let TitleTableViewCellH = CGFloat(50)
let TitleTableViewCellID = "TitleTableViewCell_ID"

protocol TitleTableViewCellDelegate {
    func endEdite(inputStr : String, tagNum : Int)
}

class TitleTableViewCell: UITableViewCell {
    var delegate : TitleTableViewCellDelegate!

    var conTent :String = ""
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var titleNameLabel: UILabel!
    
    
    @IBAction func endText(_ sender: UITextField) {
        if let str = sender.text {
            conTent = str
            if let delgate = self.delegate {
                delgate.endEdite(inputStr: conTent, tagNum: self.textField.tag)
            }
        }
    }
    
    
    /// 利益冲突
    ///
    /// - Parameter titleStr: <#titleStr description#>
    func setData_checkCaseView(titleStr : String,indexPath : IndexPath) {
        
        self.titleNameLabel.textColor = darkblueColor
        self.titleNameLabel.text = titleStr



    }
    
    
    /// 发布公告
    ///
    /// - Parameter titleStr: <#titleStr description#>
    func setData_AddNotice(titleStr : String) {
        self.titleNameLabel.textColor = darkblueColor
        self.titleNameLabel.text = titleStr
    }


    /// 会议室
    ///
    /// - Parameter titleStr: <#titleStr description#>
    func setData_room(titleStr: String) {
        self.textField.keyboardType = .numberPad
        self.titleNameLabel.textColor = darkblueColor
        self.titleNameLabel.text = titleStr
    }
    
    /// 公告详情
    ///
    /// - Parameters:
    ///   - titleStr: <#titleStr description#>
    ///   - contentStr: <#contentStr description#>
    func setData_noticeDetail(titleStr : String, contentStr : String) {
//        self.setData_AddNotice(titleStr: titleStr)
        self.textField.placeholder = contentStr
        self.conTent = contentStr
    }


    /// 案件 详情
    ///
    /// - Parameters:
    ///   - titleStr: <#titleStr description#>
    ///   - contentStr: <#contentStr description#>
    ///   - indexPath: <#indexPath description#>
    func setData_caseDetail(titleStr : String, contentStr : String,indexPath : IndexPath) {
        let tagNum = indexPath.section * 10 + indexPath.row
        self.textField.tag = tagNum
        self.titleNameLabel.textColor = darkblueColor
        self.titleNameLabel.text = titleStr
        self.titleNameLabel.textAlignment = .left

        self.textField.text = contentStr

    }
    
    /// 案件  添加
    ///
    /// - Parameter titleStr: <#titleStr description#>
    func setData_caseAdd(titleStr : String,indexPath : IndexPath) {
        let tagNum = indexPath.section * 10 + indexPath.row
        self.textField.tag = tagNum
        self.titleNameLabel.textColor = darkblueColor
        self.titleNameLabel.text = titleStr
        self.titleNameLabel.textAlignment = .left
    }


    /// 结案信息
    ///
    /// - Parameters:
    ///   - titleStr: <#titleStr description#>
    ///   - indexPath: <#indexPath description#>
    func setData_ovewdeal(titleStr : String,indexPath : IndexPath)  {
        let tagNum = indexPath.row
        self.textField.tag = tagNum
        self.titleNameLabel.textColor = darkblueColor
        self.titleNameLabel.text = titleStr
        self.titleNameLabel.textAlignment = .left

    }
    
    
    /// 搜索页面 标题
    ///
    /// - Parameter titleStr: <#titleStr description#>
    func setData_search(titleStr : String)  {
        self.titleNameLabel.textColor = darkblueColor
        self.titleNameLabel.text = titleStr
    }

    /// 发票申请
    ///
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - content: <#content description#>
    func setData_addinvoce(title : String,content : String,indexPath : IndexPath)  {
        self.textField.tag = indexPath.section * 10 + indexPath.row
        self.titleNameLabel.textColor = darkblueColor
        self.titleNameLabel.text = title

        self.textField.text = content
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
