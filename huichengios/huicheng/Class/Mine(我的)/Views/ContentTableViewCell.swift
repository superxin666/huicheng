//
//  ContentTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/31.
//  Copyright © 2018年 lvxin. All rights reserved.
//  内容cell

import UIKit
let ContentTableViewCellH = CGFloat(200)
let ContentTableViewCellID = "ContentTableViewCell_ID"
class ContentTableViewCell: UITableViewCell,UITextViewDelegate {
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var textView: UITextView!
    
    var conTent :String = ""
    
    func textViewDidEndEditing(_ textView: UITextView) {
        HCLog(message: textView.text!)
        if let str = textView.text {
            conTent = str
        }

    }
    
    
    /// 通知详情 内容
    ///
    /// - Parameter contentStr: <#contentStr description#>
    func setData_notice(contentStr : String) {
        self.textView.text = contentStr
        self.conTent = contentStr
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
