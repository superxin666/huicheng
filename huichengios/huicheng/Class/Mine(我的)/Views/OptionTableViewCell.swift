//
//  OptionTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/4/13.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let OptionTableViewCellID = "OptionTableViewCell_ID"
let OptionTableViewCellH = CGFloat(50)

class OptionTableViewCell: UITableViewCell {
    @IBOutlet weak var titleNameLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!


    func setData_caseDetail(titleStr : String,contentStr : String) {
        self.titleNameLabel.text = titleStr
        self.contentLabel.text = contentStr

    }
    
    func setOptionData(contentStr : String)  {

        self.contentLabel.text = contentStr
    }

    func setDataOption(titleStr : String) {
        self.titleNameLabel.text = "报销类型"
        self.contentLabel.text = titleStr

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
