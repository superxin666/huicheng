//
//  OptionView.swift
//  huicheng
//
//  Created by lvxin on 2018/4/13.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
protocol OptionViewDelgate {
    func optionSure(idStr : String,pickTag : Int)
}

enum OptionViewType {

    //搜索中状态  报销  接受对象      发票列表    我的收款  案件添加
    case searchState,Object,invoice_getlist,finance, caseAdd
}
class OptionView: UIView,UIPickerViewDelegate, UIPickerViewDataSource {
    var delegate : OptionViewDelgate!

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
    var data_userlistArr : [userlistModel] = []
    var data_userlistArr1 : [userlistModel] = []
    var data_userlistArr2 : [userlistModel] = []
    //部门列表
    var data_departArr : [departmentModel] = []
    //案件类型
    var data_casetypeArr : [casetypeModel] = []



    func setData_case(dataArr : [Any],indexPath : IndexPath) {
        self.pickView.tag = indexPath.row
        if indexPath.row == 0 {
            data_casetypeArr = dataArr as! [casetypeModel]
        } else if indexPath.row == 3 {
            data_userlistArr = dataArr as! [userlistModel]
        } else if indexPath.row == 4 {
            data_departArr = dataArr as! [departmentModel]
        } else if indexPath.row == 5 {
            data_userlistArr1 = dataArr as! [userlistModel]
        } else {
            data_userlistArr2 = dataArr as! [userlistModel]
        }
        self.pickView.reloadAllComponents()
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
                return self.data_casetypeArr.count
            } else if self.pickView.tag == 3 {
                return self.data_userlistArr.count
            }else if self.pickView.tag == 4 {
                return self.data_departArr.count
            }else if self.pickView.tag == 5 {
                return self.data_userlistArr1.count
            } else {
                return self.data_userlistArr2.count
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
            if self.pickView.tag == 0 {
                //类型
                let model : casetypeModel = self.data_casetypeArr[row]
                titleStr = model.name
                cuurectID = "\(model.id)"

            } else if self.pickView.tag == 3 {
                //立案律师
                let model : userlistModel = self.data_userlistArr[row]
                titleStr = model.name
                cuurectID = "\(model.id)"

            }else if self.pickView.tag == 4 {
                //部门
                let model : departmentModel = self.data_departArr[row]
                titleStr = model.name
                cuurectID = "\(model.id)"
            }else if self.pickView.tag == 5 {
                //承办律师1
                let model : userlistModel = self.data_userlistArr1[row]
                titleStr = model.name
                cuurectID = "\(model.id)"

            } else {
                //承办律师2
                let model : userlistModel = self.data_userlistArr2[row]
                titleStr = model.name
                cuurectID = "\(model.id)"
            }

        }
        let label = UILabel(frame: CGRect(x: 0, y: 15, width: pickerView.frame.width, height: 20))
        label.text = titleStr
        label.textColor = UIColor.hc_colorFromRGB(rgbValue: 0x666666)
        label.font = hc_fontThin(13)
        label.textAlignment = .center
        return label
    }

    @IBOutlet weak var pickView: UIPickerView!

    @IBAction func sureClick(_ sender: UIButton) {
        if let delegate = self.delegate {
            delegate.optionSure(idStr: cuurectID, pickTag: self.pickView.tag)
        }
    }

    override func awakeFromNib() {
        self.pickView.delegate = self
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


}
