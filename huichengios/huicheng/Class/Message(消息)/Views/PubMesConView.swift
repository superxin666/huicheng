//
//  PubMesConView.swift
//  huicheng
//
//  Created by lvxin on 2018/3/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class PubMesConView: UIView,NibLoadable {

    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func setData(model:newsdetialModel) {
        if let title = model.title {
            self.titleLabel.text = title
        }
        if let user = model.user ,let object = model.object{
            self.subLabel.text = "发布人：\(user)   接收对象：\(object)"
        }
        if let content = model.content {

            let attrStr = try! NSAttributedString(
                data: content.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options:[NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            self.contentTextView.attributedText = attrStr
        }
        if let time = model.createtime {
            self.timeLabel.text = time
        }
        
    }
    
}
