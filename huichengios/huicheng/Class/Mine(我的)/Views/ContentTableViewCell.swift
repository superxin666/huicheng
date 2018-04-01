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
