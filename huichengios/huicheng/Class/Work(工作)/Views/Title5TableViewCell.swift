//
//  Title5TableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/4/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let Title5TableViewCellID = "Title5TableViewCell_id"
let  Title5TableViewCellH = CGFloat(50)


class Title5TableViewCell: UITableViewCell {
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var cancleBtn: UIButton!
    @IBOutlet weak var openBtn: UIButton!

    @IBAction func btnClick(_ sender: UIButton) {



    }

    func setData(titleStr: String)  {
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
