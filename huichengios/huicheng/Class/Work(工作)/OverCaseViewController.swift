//
//  OverCaseViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/4/20.
//  Copyright © 2018年 lvxin. All rights reserved.
// 申请结案

import UIKit

class OverCaseViewController: BaseTableViewController,ContentTableViewCellDelegate,DatePickViewDelegate,OptionViewDelgate ,WorkRequestVCDelegate{




    /// 合同id
    var dealId : Int!
    /// 合同编号
    var dealNum : String = ""

    /// 时间
    var rtStr : String = ""

    /// 律师
    var nStr : String = ""
    /// 结案总结
    var dStr : String = ""


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
        self.navigation_title_fontsize(name: "申请结案", fontsize: 18)
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
        self.tableView .register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)
        self.tableView .register(UINib.init(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: ContentTableViewCellID)
        self.tableView .register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
        self.tableView .register(UINib.init(nibName: "FileTableViewCell", bundle: nil), forCellReuseIdentifier: FileTableViewCellID)

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell : Title4TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Title4TableViewCellID, for: indexPath) as! Title4TableViewCell
            cell.setData_overCase(titleStr: "合同编号", contentStr: dealNum)
            return cell
        } else if indexPath.row == 1  {
            let cell : OptionTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
            cell.setData_caseDetail(titleStr: "律师姓名", contentStr: "")
            return cell
        } else if indexPath.row == 2 {
            let cell : endTimeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
            cell.setData(titleStr: "结案日期", tag: 2)
            return cell

        } else if indexPath.row == 3 {
            let cell : ContentTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
            cell.setData_overdeal(titleStr: "结案总结")
            cell.delegate = self
            return cell
        } else {
            let cell : FileTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: FileTableViewCellID, for: indexPath) as! FileTableViewCell
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        if indexPath.row == 1{
            //律师
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
        if indexPath.row == 3 {
            return ContentTableViewCellH
        } else {
            return 50
        }
    }

    func endText_content(content: String) {
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
        self.rtStr = timeStr
        let cell : endTimeTableViewCell  = self.tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! endTimeTableViewCell
        cell.setTime(str: timeStr)
        self.dateView.removeFromSuperview()
        self.maskView.removeFromSuperview()
    }

    func showOptionPickView() {

        self.maskView.addSubview(self.optionView)
        self.view.window?.addSubview(self.maskView)
        self.optionView.setData_deal(dataArr: self.userList)
        self.optionView.delegate = self

        self.optionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(160)
        }
    }

    func optionSure(idStr: String, titleStr: String, pickTag: Int) {
        let cell : OptionTableViewCell = self.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! OptionTableViewCell
        nStr = idStr
        cell.setOptionData(contentStr: titleStr)
        self.optionView.removeFromSuperview()
        self.maskView.removeFromSuperview()
    }

    func requestSucceed_work(data: Any, type: WorkRequestVC_enum) {
        if type == .userlist {
            //律师
            userList = data as! [userlistModel]
            self.showOptionPickView()
        } else if type == .oversave{
            //申请完结

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
        request.dealoversave(id: self.dealId, n: self.nStr, t: self.rtStr, d: self.dStr, i: "")
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
