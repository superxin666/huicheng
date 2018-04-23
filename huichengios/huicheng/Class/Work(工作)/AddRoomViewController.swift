//
//  AddRoomViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/4/23.
//  Copyright © 2018年 lvxin. All rights reserved.
//  添加会议室

import UIKit
typealias AddRoomViewControllerBlock = ()->()
class AddRoomViewController: BaseTableViewController,TitleTableViewCellDelegate ,ContentTableViewCellDelegate,DatePickViewDelegate,WorkRequestVCDelegate{

    /// 开始时间
    var btStr = ""
    /// 结束时间
    var etStr = ""
    /// 人数
    var tStr = ""
    /// 内容
    var nStr = ""
    /// 时间
    let dateView : DatePickView = DatePickView.loadNib()

    let requestVC = WorkRequestVC()
    var sucessBlock : AddRoomViewControllerBlock!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.navigationBar_rightBtn_title(name: "确定")
        self.navigation_title_fontsize(name: "会议室预约", fontsize: 18)
        requestVC.delegate = self
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
        self.tableView .register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
        self.tableView .register(UINib.init(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: ContentTableViewCellID)
        self.tableView .register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 || indexPath.row == 1{
            let endTimeCell : endTimeTableViewCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
            if indexPath.row == 0 {
                endTimeCell.setData_case(titleStr: "开始时间", timeStr: btStr)
            } else {
                endTimeCell.setData_case(titleStr: "结束时间", timeStr: etStr)
            }

            return endTimeCell
        } else if indexPath.row == 2 {
            let cell : TitleTableViewCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
            cell.delegate = self
            cell.setData_room(titleStr: "参加人数")
            return cell
        } else {
            let cell : ContentTableViewCell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
            cell.delegate = self
            cell.setData_overdeal(titleStr: "内容")
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //开始时间
            self.dateView.setData(type: 0)

        } else if indexPath.row == 1 {
            //结束时间
            self.dateView.setData(type: 1)
        }
        self.showDate()

    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3  {
            return ContentTableViewCellH
        } else {
            return TitleTableViewCellH
        }
    }


    func endEdite(inputStr: String, tagNum: Int) {
        HCLog(message: inputStr)
        self.tStr = inputStr
    }

    func endText_content(content: String) {
        HCLog(message: content)
        self.nStr = content
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
        if type == 0 {
            //开始
            self.btStr = timeStr
            let cell : endTimeTableViewCell  = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! endTimeTableViewCell
            cell.setTime(str: timeStr)

        } else {
            //结束
            self.etStr = timeStr
            let cell : endTimeTableViewCell  = self.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! endTimeTableViewCell
            cell.setTime(str: timeStr)
        }
        self.dateView.removeFromSuperview()
        self.maskView.removeFromSuperview()
    }

    func requestSucceed_work(data: Any, type: WorkRequestVC_enum) {
        self.sucessBlock()
        self.navigationController?.popViewController(animated: true)
    }
    func requestFail_work() {

    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        HCLog(message: "确定")
        self.view.endEditing(true)
        requestVC.roomsave(b: self.btStr, e: etStr, t: tStr, n: nStr)
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
