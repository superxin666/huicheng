//
//  AddExpenseViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/29.
//  Copyright © 2018年 lvxin. All rights reserved.
//  添加报销申请

import UIKit

class AddExpenseViewController: BaseViewController ,MineRequestVCDelegate{
    var backView : AddExpenseBackView!
    
    var request : MineRequestVC = MineRequestVC()
    var dataArr : [expense_gettypeModel] = []
    
    // MARK: - life cicle
    override func viewWillLayoutSubviews() {
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(LNAVIGATION_HEIGHT)
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        self.navigation_title_fontsize(name: "报销申请", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.navigationBar_rightBtn_title(name: "确定")
        request.delegate = self
        backView = AddExpenseBackView.loadNib()
        self.view.addSubview(backView)
        
        //获取报销类型
        request.expense_gettypeRequest()
    }
    // MARK: - delegate
    func requestSucceed(data: Any, type: MineRequestVC_enum) {
        if type == .expense_save {
            //保存
            
            
            
        } else {
            //type 列表
            let arr = data as! [expense_gettypeModel]
            if dataArr.count > 0 {
                self.dataArr.removeAll()
            }
            self.dataArr = arr
            backView.dataArr = self.dataArr
            backView.setData()
            backView.pickView.reloadAllComponents()
            
        }
    }
    func requestFail() {
        
    }
    
    // MARK: - net

    
    
    // MARK: - response
    override func navigationRightBtnClick() {
        HCLog(message: "确定")
        guard let type = backView.type else {
            SVPMessageShow.showErro(infoStr: "请选择报销类型")
            return
        }
        guard let money = backView.money else {
            SVPMessageShow.showErro(infoStr: "请输入报销金额")
            return
        }

        guard let num = backView.num else {
            SVPMessageShow.showErro(infoStr: "请输入票据数量")
            return
        }
        request.expense_saveRequest(t: type, n: money, m:  num)
        
    }
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
