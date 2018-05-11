//
//  FileListTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/5/11.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let FileListTableViewCellH = CGFloat(50)
let FileListTableViewCellID = "FileListTableViewCell_id"


class FileListTableViewCell: UITableViewCell {
    @IBOutlet weak var titleNameLabel: UILabel!


    func setData(titleStr : String) {
        self.titleNameLabel.text = titleStr
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
