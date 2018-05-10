//
//  OverDealViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/4/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//  生成合同

import UIKit

class OverDealViewController:
BaseTableViewController,ContentTableViewCellDelegate,DatePickViewDelegate,OptionViewDelgate ,WorkRequestVCDelegate,SelectedTableViewCellDelegate{




    /// 合同id
    var dealId : Int!
    /// 合同编号
    var dealNum : String = ""

    /// 时间
    var dStr : String = ""

    /// 总款
    var aStr : String = ""


    /// 0-未开;1-已开
    var itStr : String = ""
    /// 发票信息(整型)
    var itIdStr : String = ""

    /// 时间
    let dateView : DatePickView = DatePickView.loadNib()
    /// 律师
    var userList : [userlistModel] = []

    /// 选项
    let optionView : OptionView = OptionView.loadNib()

    let request : WorkRequestVC = WorkRequestVC()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        request.delegate = self
        self.navigation_title_fontsize(name: "生成合同", fontsize: 18)
        self.navigationBar_rightBtn_title(name: "确定")
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.creatUI()

    }
    // MARK: - UI
    func creatUI() {
        self.tableView .backgroundColor = viewBackColor
        self.tableView .tableFooterView = UIView()
        self.tableView .separatorStyle = .none
        self.tableView .showsVerticalScrollIndicator = false
        self.tableView .showsHorizontalScrollIndicator = false
        self.tableView .backgroundView?.backgroundColor = .clear
        self.tableView .register(UINib.init(nibName: "Title4TableViewCell", bundle: nil), forCellReuseIdentifier: Title4TableViewCellID)
        self.tableView .register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
        self.tableView .register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
        self.tableView .register(UINib.init(nibName: "SelectedTableViewCell", bundle: nil), forCellReuseIdentifier: SelectedTableViewCellID)

        self.tableView .register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)
        self.tableView .register(UINib.init(nibName: "FileTableViewCell", bundle: nil), forCellReuseIdentifier: FileTableViewCellID)

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell : Title4TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Title4TableViewCellID, for: indexPath) as! Title4TableViewCell
            cell.setData_overCase(titleStr: "合同编号", contentStr: dealNum)
            return cell
        } else if indexPath.row == 1  {
            let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
            cell.setData_caseAdd(titleStr: "合同总款", indexPath: indexPath)
            return cell
        } else if indexPath.row == 2 {
            let cell : endTimeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
            cell.setData(titleStr: "合同付款期限", tag: 2)
            return cell

        } else if indexPath.row == 3 {
            let cell : SelectedTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: SelectedTableViewCellID, for: indexPath) as! SelectedTableViewCell
            cell.delegate = self
            cell.setData_deal()
            return cell
        } else if indexPath.row == 4 {
            let cell : OptionTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
            cell.setData_caseDetail(titleStr: "发票信息", contentStr: itStr)
            return cell
        } else {
            let cell : FileTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: FileTableViewCellID, for: indexPath) as! FileTableViewCell
            cell.setData_deal()
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        if indexPath.row == 4{
            //发票信息
            //立案律师
            if userList.count > 0 {
                self.showOptionPickView()
            } else {
                request.userlistRequest()
            }

        } else  if indexPath.row == 2 {
            //时间
            self.showDate()
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func endText_content(content: String,tagNum : Int) {
        dStr = content
    }


    /// 显示时间
    func showDate() {
        self.maskView.addSubview(self.dateView)
        self.view.window?.addSubview(self.maskView)
        self.dateView.delegate = self
        self.dateView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(160)
        }
    }


    /// 时间选项代理
    ///
    /// - Parameters:
    ///   - timeStr: <#timeStr description#>
    ///   - type: <#type description#>
    func datePickViewTime(timeStr: String, type: Int) {
        HCLog(message: timeStr)
        HCLog(message: type)
        self.dStr = timeStr
        let cell : endTimeTableViewCell  = self.tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! endTimeTableViewCell
        cell.setTime(str: timeStr)
        self.dateView.removeFromSuperview()
        self.maskView.removeFromSuperview()
    }

    func showOptionPickView() {

        self.maskView.addSubview(self.optionView)
        self.view.window?.addSubview(self.maskView)

        self.optionView.delegate = self

        self.optionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(160)
        }
    }

    func optionSure(idStr: String, titleStr: String, pickTag: Int) {
        let cell : OptionTableViewCell = self.tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as! OptionTableViewCell
        aStr = idStr
        cell.setOptionData(contentStr: titleStr)
        self.optionView.removeFromSuperview()
        self.maskView.removeFromSuperview()
    }

    func selectedClickDelegate_type(tag: Int, type: String) {

    }

    func requestSucceed_work(data: Any, type: WorkRequestVC_enum) {
        if type == .userlist {
            //律师
            userList = data as! [userlistModel]
            self.showOptionPickView()
        } else if type == .oversave{
            //申请完结
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

    func requestFail_work() {

    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        HCLog(message: "确定")
        self.view.endEditing(true)
        if !(self.aStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入合同总款")
            return
        }
        if !(self.dStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请选择时间")
            return
        }


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
