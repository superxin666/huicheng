//
//  RoomTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/4/23.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let RoomTableViewCellID = "UITableViewCell_id"
let RoomTableViewCellH = CGFloat(80)
typealias RoomTableViewCellBlock = (_ model : roomModel)->()

class RoomTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    var delBlock : RoomTableViewCellBlock!
    var dataModel : roomModel!

    func setData(model : roomModel)  {
        dataModel = model
        if let bt = model.bt,let et = model.et,let ut = model.ut {
            let str = String.hc_getDate_string(dateStr: bt) + "~" + String.hc_getDate_string(dateStr: et)+" （\(ut)小时）"
            self.titleLabel.text = str

        }
        var str = ""

        if let total = model.total {
            str = "\(total)人"
        }
        if let name = model.name {
            str = str + "   " + name
        }
        self.contentLabel.text = str

        if let stateStr = model.stateStr {
            self.stateLabel.text = stateStr
        }

        if let state = model.state {
            if state == 0 {
                //待审核
                self.stateLabel.backgroundColor = darkblueColor

            } else if state == 1 {
                //已批准
                self.stateLabel.backgroundColor = UIColor.hc_colorFromRGB(rgbValue: 0xcccccc)


            } else {
                //审核驳回
                 self.stateLabel.backgroundColor = orangeColor
            }
            self.stateLabel.textColor = .white
        }

    }

    func setData_share(model :shareGetlistModel)  {
        if let title = model.title {
            self.titleLabel.text = title
        }
        if let addtime = model.addtime,let typeStr = model.typeStr {
            self.contentLabel.text = String.hc_getDate_string(dateStr: addtime) + "  " + typeStr

        }
        if let stateStr = model.stateStr {
            self.stateLabel.text = stateStr
        }
        if let state = model.state {
            if state == 0 {
                //自动发布
                self.stateLabel.backgroundColor = UIColor.hc_colorFromRGB(rgbValue: 0xcccccc)
            } else if state == 1 {
                //
                self.stateLabel.backgroundColor = darkblueColor
            } else {
                self.stateLabel.backgroundColor = darkblueColor
            }
        }



    }


    
    func setData_shareMy(model :shareGetlistModel)  {
        if let title = model.title {
            self.titleLabel.text = title
        }
        if let addtime = model.addtime,let typeStr = model.typeStr {
            self.contentLabel.text = String.hc_getDate_string(dateStr: addtime) + "  " + typeStr

        }
        if let stateStr = model.stateStr {
            self.stateLabel.text = stateStr
        }
        if let state = model.state {
            if state == 0 {
                //自动发布
                self.stateLabel.backgroundColor = UIColor.hc_colorFromRGB(rgbValue: 0xcccccc)
            } else if state == 1 {
                //
                self.stateLabel.backgroundColor = darkblueColor
            } else {
                self.stateLabel.backgroundColor = darkblueColor
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClik))
//        self.addGestureRecognizer(tap)
    }

//    @objc func tapClik() {
//        self.delBlock(dataModel)
//    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
