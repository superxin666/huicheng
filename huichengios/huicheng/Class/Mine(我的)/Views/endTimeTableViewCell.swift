//
//  endTimeTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/4/2.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let endTimeTableViewCellid = "endTimeTableViewCell_id"

class endTimeTableViewCell: UITableViewCell {
    @IBOutlet weak var titleNameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    /// 占位符
    ///
    /// - Parameters:
    ///   - titleStr: <#titleStr description#>
    ///   - timeStr: <#timeStr description#>
    ///   - tag: <#tag description#>
    func setDataPla(titleStr : String,timeStr : String,tag : Int) {

        self.titleNameLabel.text = titleStr
        self.titleNameLabel.textAlignment = .left
        self.timeLabel.text = timeStr
        self.timeLabel.textAlignment = .left


    }

    /// 时间标题
    ///
    /// - Parameters:
    ///   - titleStr: <#titleStr description#>
    ///   - tag: <#tag description#>
    func setData(titleStr  :String,tag : Int)  {
        self.titleNameLabel.text = titleStr
    }


    /// 案件 详情
    ///
    /// - Parameters:
    ///   - titleStr: <#titleStr description#>
    ///   - timeStr: <#timeStr description#>
    func setData_case(titleStr  :String,timeStr : String) {

        self.titleNameLabel.text = titleStr
        self.titleNameLabel.textAlignment = .left
        self.timeLabel.text = timeStr
        self.timeLabel.textAlignment = .left
        
    }

    /// 选择时间之后 展示时间
    ///
    /// - Parameter str: <#str description#>
    func setTime(str : String) {
        self.timeLabel.text = str
    }
}
