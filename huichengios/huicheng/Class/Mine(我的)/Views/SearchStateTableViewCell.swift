//
//  SearchStateTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/30.
//  Copyright © 2018年 lvxin. All rights reserved.
//  搜索页面--状态选择   发布公告--接受对象

import UIKit
let SearchStateTableViewCellID = "SearchStateTableViewCell_id"

enum SearchStateTableViewCellType {
    //搜索中状态  报销  接受对象      发票列表
    case searchState,Object,invoice_getlist
}
class SearchStateTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    var cuurectID : String = ""
    /// 类型 默认搜索
    var type :SearchStateTableViewCellType = .searchState
    //搜索 报销
    //0 1 2 3
    var nameArr = ["未审核","已审核","审核驳回","已支付",]
    var idArr = ["0","1","2","3",]

    //接受对象
    //数组
    var dataArr : [getobjectlistModel] = []

    //发票
    var nameArr_invoice = ["未审核","已审核","审核驳回","已寄送",]
    var idArr_invoice = ["0","1","2","3",]



    
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var pickView: UIPickerView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.pickView.delegate = self
        self.pickView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    /// 搜索页面
    ///
    /// - Parameter titleStr: <#titleStr description#>
    func setData_searchState(titleStr : String) {
        self.titleNameLabel.textAlignment = .right
        self.titleNameLabel.text = titleStr
    }
    
    
    /// 发布公告--接受对象
    ///
    /// - Parameter titleStr: <#titleStr description#>
    func setData_Object(titleStr : String) {
        self.titleNameLabel.textAlignment = .left
        self.titleNameLabel.text = titleStr
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if type == .searchState {
            return nameArr.count
        } else if type == .invoice_getlist {
            return nameArr_invoice.count
        } else {
            return dataArr.count
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
   
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //显示
        var titleStr = ""
        if type == .searchState {
           titleStr = nameArr[row]
           cuurectID = idArr[row]
        } else if type == .invoice_getlist {
            titleStr = nameArr[row]
            cuurectID = idArr[row]
        } else {
            let model = dataArr[row]
            titleStr = model.name!
            cuurectID = "\(model.id!)"
            
        }
        let label = UILabel(frame: CGRect(x: 0, y: 15, width: 100, height: 20))
        label.text = titleStr
        label.textColor = UIColor.hc_colorFromRGB(rgbValue: 0x666666)
        label.font = hc_fontThin(13)
        return label
    }
    
}
