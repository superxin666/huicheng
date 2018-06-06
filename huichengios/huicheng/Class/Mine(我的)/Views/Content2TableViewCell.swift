//
//  Content2TableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/6/6.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let Content2TableViewCellH = CGFloat(80)
let Content2TableViewCellID =  "Content2TableViewCell_id"

class Content2TableViewCell: UITableViewCell,UITextViewDelegate {
    @IBOutlet weak var textView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.textView.delegate = self
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        let str = textView.text!
        HCLog(message: str)
    }

    func setData_shareDetail(content : String) {
        self.textView.isUserInteractionEnabled = false

        do{
            let attrStr = try! NSAttributedString(
                data: content.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options:[NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            self.textView.attributedText = attrStr
        }catch let error as NSError {
            print(error.localizedDescription)
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
