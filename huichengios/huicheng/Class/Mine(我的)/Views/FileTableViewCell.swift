//
//  FileTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/31.
//  Copyright © 2018年 lvxin. All rights reserved.
//  附件cell

import UIKit
let FileTableViewCellH = CGFloat(50)
let FileTableViewCellID = "FileTableViewCell_ID"
class FileTableViewCell: UITableViewCell {
    @IBOutlet weak var titleNameLabel: UILabel!
    
    @IBOutlet weak var fileNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData_deal() {
        self.titleNameLabel.text = "合同扫描件"
    }
    func setData_fileName(fileName : String) {
        self.fileNameLabel.text = fileName
    }
    
}
