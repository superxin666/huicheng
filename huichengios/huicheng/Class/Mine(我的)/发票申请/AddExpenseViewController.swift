//
//  AddExpenseViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/29.
//  Copyright © 2018年 lvxin. All rights reserved.
//  添加报销申请

import UIKit
typealias AddExpenseViewControllerBlock = ()->()

enum AddExpenseViewController_type {
    case add_type,detaile_type
}

class AddExpenseViewController: BaseTableViewController ,MineRequestVCDelegate,OptionViewDelgate,InputTableViewCellDelegate{
    let mainTabelView : UITableView = UITableView()
    var request : MineRequestVC = MineRequestVC()
    var dataArr : [expense_gettypeModel] = []
    var cuurectModel  : expense_gettypeModel!
    var expenseString : String = ""

    var nStr  = ""
    var mStr = ""



    /// 选项
    let optionView : OptionView = OptionView.loadNib()

    
    var type: AddExpenseViewController_type!
    var expenseId : Int!
    var sureStateBlock : AddExpenseViewControllerBlock!

//    override func viewWillLayoutSubviews() {
//        mainTabelView.snp.makeConstraints { (make) in
//            make.top.equalTo(self.view).offset(0)
//            make.left.right.equalTo(self.view).offset(0)
//            make.bottom.equalTo(self.view).offset(0)
//        }
//    }


    // MARK: - life cicle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        self.navigation_title_fontsize(name: "报销申请", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        request.delegate = self

        
        if self.type == .add_type {
            //获取报销类型
            self.navigationBar_rightBtn_title(name: "确定")
            self.creatUI()
            SVPMessageShow.showLoad()
            request.expense_gettypeRequest()

        } else {
            //报销详情

            self.navigationBar_rightBtn_title(name: "编辑")
            request.expense_getinfoRequest(id: expenseId)

        }

    }

    // MARK: - UI
    func creatUI() {
     
        mainTabelView.delegate = self;
        mainTabelView.dataSource = self;
        mainTabelView.tableFooterView = UIView()
        mainTabelView.separatorStyle = .none
        mainTabelView.showsVerticalScrollIndicator = false
        mainTabelView.showsHorizontalScrollIndicator = false
        mainTabelView.backgroundView?.backgroundColor = .clear


        mainTabelView.register(UINib.init(nibName: "ExpenseTitleTableViewCell", bundle: nil), forCellReuseIdentifier: ExpenseTitleTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "Content2TableViewCell", bundle: nil), forCellReuseIdentifier: Content2TableViewCellID)
        mainTabelView.register(UINib.init(nibName: "InputTableViewCell", bundle: nil), forCellReuseIdentifier: InputTableViewCellID)

        self.tableView = mainTabelView

    }

    // MARK: - delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell : ExpenseTitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: ExpenseTitleTableViewCellID, for: indexPath) as! ExpenseTitleTableViewCell
            return cell

        } else if indexPath.row == 1 {
            let cell : OptionTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
            if self.dataArr.count > 0 {
                cell.setOptionData(contentStr: cuurectModel.name)
            }
            return cell


        } else if indexPath.row == 2 {

            let cell : Content2TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Content2TableViewCellID, for: indexPath) as! Content2TableViewCell
            if self.dataArr.count > 0 {
                cell.setDataExpense(contentStr: cuurectModel.note)
            }

            return cell
        } else if indexPath.row == 3 {
            let cell : InputTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: InputTableViewCellID, for: indexPath) as! InputTableViewCell
            cell.delegate = self
            cell.setUpData(name: "报销金额", tagNum: indexPath.row)
            return cell
        } else {
            let cell : InputTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: InputTableViewCellID, for: indexPath) as! InputTableViewCell
            cell.delegate = self
            cell.setUpData(name: "附件张数", tagNum: indexPath.row)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row < self.dataArr.count {
//            let model = self.dataArr[indexPath.row]
//            let vc = AddExpenseViewController()
//            vc.hidesBottomBarWhenPushed = true
//            vc.type = .detaile_type
//            vc.expenseId = model.id
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
        self.view.endEditing(true)
        if indexPath.row ==  1 {

            self.showOptionView_state()
        }
    }



    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.row == 0 {
            return ExpenseTitleTableViewCellH
        } else if indexPath.row == 1 {
            return OptionTableViewCellH
        } else if indexPath.row == 2 {
            return Content2TableViewCellH
        } else {
            return InputTableViewCellH
        }

    }

    
    // MARK: - delegate
    func requestSucceed_mine(data: Any, type: MineRequestVC_enum) {
        if type == .expense_save {
            //保存
            SVPMessageShow.dismissSVP()
            let model : CodeData = data as! CodeData
            if model.code == 1 {
                self.sureStateBlock()
                self.navigationController?.popViewController(animated: true)
            }
            
            
        } else if type == .expense_gettype{
            //type 列表
            let arr = data as! [expense_gettypeModel]
            if dataArr.count > 0 {
                self.dataArr.removeAll()
            }
            self.dataArr = arr
            cuurectModel = self.dataArr[0]
            expenseString = "\(cuurectModel.id!)"
            self.tableView.reloadData()

        } else if type == .expense_getinfo{
            //详情
            let model : expense_getinfoModel = data as! expense_getinfoModel


        }
    }
    func requestFail_mine() {
        
    }
    // MARK: - response
    override func navigationRightBtnClick() {
//        if self.type == .add_type {

        self.view.endEditing(true)
        if !(nStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入发票张数")
            return
        }
        if !(mStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入金额")
            return
        }
        request.expense_saveRequest(t: expenseString, n: nStr, m:  mStr)
//        } else {
//            HCLog(message: "编辑")
//        }

    }
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }

    func showOptionView_state() {
        self.maskView.addSubview(self.optionView)
        self.view.window?.addSubview(self.maskView)
        self.optionView.setDataExpensive(dataArr: self.dataArr)
        self.optionView.delegate = self
        self.optionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(160)
        }
    }

    func optionSure(idStr: String, titleStr: String, noteStr: String, pickTag: Int) {

        let model : expense_gettypeModel = expense_gettypeModel()
        model.name = titleStr
        model.note = noteStr
        expenseString = idStr
        cuurectModel = model

        self.optionView.removeFromSuperview()
        self.maskView.removeFromSuperview()

        self.mainTabelView.reloadData()

    }


    func endEdite_input(inputStr: String, tagNum: Int) {
        HCLog(message: inputStr)
        HCLog(message: tagNum)
        if  tagNum == 3 {
            mStr = inputStr
        } else {
            nStr = inputStr
        }
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
