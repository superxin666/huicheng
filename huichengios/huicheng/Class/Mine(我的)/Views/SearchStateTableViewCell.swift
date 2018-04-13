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

    //搜索中状态  报销  接受对象      发票列表    我的收款  案件添加
    case searchState,Object,invoice_getlist,finance, caseAdd
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
    // 我的收款
    var nameArr_finance = ["未支付","已支付",]
    var idArr_finance = ["1","3",]


    //律师
    var data_userlist : [userlistModel] = []
    //组别
    var data_branch : [branchModel] = []
    //案件类型
    var data_casetype : [casetypeModel] = []

    
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
        self.titleNameLabel.textAlignment = .left
        self.titleNameLabel.text = titleStr
    }
    
    
    /// 发布公告--接受对象
    ///
    /// - Parameter titleStr: <#titleStr description#>
    func setData_Object(titleStr : String) {
        self.titleNameLabel.textAlignment = .left
        self.titleNameLabel.text = titleStr
    }


    /// 添加/详情  案件
    ///
    /// - Parameters:
    ///   - titleStr: <#titleStr description#>
    ///   - index: <#index description#>
    func setData_addCase(titleStr : String,index: IndexPath)  {
        self.titleNameLabel.textAlignment = .right
        self.titleNameLabel.text = titleStr
        self.pickView.tag = index.row
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if type == .searchState {
            return nameArr.count

        } else if type == .invoice_getlist {
            return nameArr_invoice.count

        }  else if type == .finance {

            return nameArr_finance.count

        } else if type == .Object {

            return dataArr.count
        } else if type == .caseAdd {
            if self.pickView.tag == 0 {
                return self.data_casetype.count
            } else if self.pickView.tag == 3 {
                return self.data_userlist.count
            }else if self.pickView.tag == 4 {
                return self.data_branch.count
            }else if self.pickView.tag == 5 {
                return self.data_userlist.count
            } else {
                return self.data_userlist.count
            }
        } else {
            return 0
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
   
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //显示
        var titleStr = ""
        if type == .searchState {
            //发票
           titleStr = nameArr[row]
           cuurectID = idArr[row]

        } else if type == .invoice_getlist {
            titleStr = nameArr[row]
            cuurectID = idArr[row]
        } else if type == .Object {
            //接受对象

            let model = dataArr[row]
            titleStr = model.name!
            cuurectID = "\(model.id!)"
            
        } else if type == .finance{
            //收款
            titleStr = nameArr_finance[row]
            cuurectID = idArr_finance[row]
            
        }else if type == .caseAdd{
            //案件
            titleStr = nameArr_finance[row]
            cuurectID = idArr_finance[row]

        }
        let label = UILabel(frame: CGRect(x: 0, y: 15, width: pickerView.frame.width, height: 20))
        label.text = titleStr
        label.textColor = UIColor.hc_colorFromRGB(rgbValue: 0x666666)
        label.font = hc_fontThin(13)
        label.textAlignment = .left
        return label
    }
    
}
