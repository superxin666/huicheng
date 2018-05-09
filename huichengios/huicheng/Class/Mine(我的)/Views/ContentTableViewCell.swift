//
//  ContentTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/31.
//  Copyright © 2018年 lvxin. All rights reserved.
//  内容cell
protocol ContentTableViewCellDelegate {
    func endText_content(content:String)

}
import UIKit
let ContentTableViewCellH = CGFloat(200)
let ContentTableViewCellID = "ContentTableViewCell_ID"
class ContentTableViewCell: UITableViewCell,UITextViewDelegate {
    var delegate : ContentTableViewCellDelegate!

    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var textView: UITextView!
    
    var conTent :String = ""
    
    func textViewDidEndEditing(_ textView: UITextView) {
        HCLog(message: textView.text!)
        if let str = textView.text {
            conTent = str
        }
        if let delegate = self.delegate {
            delegate.endText_content(content: conTent)
        }

    }
    
    
    /// 通知详情 内容
    ///
    /// - Parameter contentStr: <#contentStr description#>
    func setData_notice(contentStr : String) {
        self.textView.text = contentStr
        self.conTent = contentStr
    }


    /// 案件详情
    ///
    /// - Parameter titleStr: <#titleStr description#>
    func setData_overdeal(titleStr : String) {
        self.titleLabel.textColor = darkblueColor
        self.titleLabel.text = titleStr


    }

    func setData_dealDetail(titleStr : String,contentStr : String) {
        self.titleLabel.textColor = darkblueColor
        self.titleLabel.text = titleStr

        self.textView.text = contentStr
    }


    /// 案件 详情
    ///
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - contentCase: <#contentCase description#>
    func setData_case(title : String,contentCase : String) {
        self.titleLabel.textColor = darkblueColor
        self.titleLabel.text = title

        self.textView.text = contentCase
    }

    /// 合同审查
    ///
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - contentCase: <#contentCase description#>
    func setData_dealcheckdetail(title : String,contentCase : String) {
        self.titleLabel.textColor = darkblueColor
        self.titleLabel.text = title
        self.textView.text = contentCase
        self.textView.isUserInteractionEnabled = false
    }


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.textView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
