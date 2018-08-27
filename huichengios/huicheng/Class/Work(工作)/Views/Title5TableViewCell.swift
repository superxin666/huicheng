//
//  Title5TableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/4/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let Title5TableViewCellID = "Title5TableViewCell_id"
let  Title5TableViewCellH = CGFloat(80)
protocol Title5TableViewCellDelegate {

    func endText_title5(inputStr: String, tagNum: Int)
}

class Title5TableViewCell: UITableViewCell {
    var delegate :Title5TableViewCellDelegate!
    var conTent : String = ""

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var titleNameLabel: UILabel!


    @IBAction func title5EndText(_ sender: UITextField) {
        if let str = sender.text {
            conTent = str
            if let delgate = self.delegate {
                delgate.endText_title5(inputStr: conTent, tagNum: self.textField.tag)
            }
        }

    }

    func setData(titleStr: String)  {
        self.titleNameLabel.text = titleStr
    }

    func setData_overDeal(titleStr : String,contentStr : String) {
        self.textField.text = contentStr
        self.titleNameLabel.text = titleStr
    }

    func setData_invoice(title: String ,contentStr : String,index :IndexPath ) {
        self.textField.tag = index.row
        self.textField.text = contentStr
        self.titleNameLabel.text = title
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
