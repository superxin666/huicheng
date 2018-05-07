//
//  AddInvoiceViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/31.
//  Copyright © 2018年 lvxin. All rights reserved.
//  添加发票

import UIKit

class AddInvoiceViewController: BaseTableViewController,MineRequestVCDelegate,TitleTableViewCellDelegate {

    let sectionNameArr = ["发票类型","名称","社会统一信用代码","发票内容","发票金额",]


    /// 0 1 2 3
    var section1Type : Int!

    /// 未入账 自取
    let section1NameArr = ["款项是否入账","送达方式","上门自取时间","备注"]

    /// 入账 自取
    let section1NameArr1 = ["款项是否入账","入账时间","送达方式","上门自取时间","备注"]

    /// 未入账 邮寄
    let section1NameArr2 = ["款项是否入账","送达方式","收件人","联系电话","邮编","邮寄地址","付费方式","收件时间","备注",]

    /// 入账 邮寄
    let section1NameArr3 = ["款项是否入账","入账时间","送达方式","收件人","联系电话","邮编","邮寄地址","付费方式","收件时间","备注",]

    var currectSectionArr : [String] = []


    ///是否已入帐 0-未入帐;1-已入帐
    var isbooksStr = "0"

    /// 送达方式 0-上门自取;1-快递邮寄
    var sendtype = "0"

    /// 第一组 行数
    var section1RowNum = 2

    // MARK: - life
    override func viewWillLayoutSubviews() {

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor

        self.navigation_title_fontsize(name: "发票申请", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.navigationBar_rightBtn_title(name: "确定")
        //默认 未入账  上门自取
        currectSectionArr = section1NameArr
        section1Type = 0
        self.creatUI()



    }
    // MARK: - UI
    func creatUI() {
        self.tableView.backgroundColor = viewBackColor
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.backgroundView?.backgroundColor = .clear
        self.tableView.register(UINib.init(nibName: "SelectedTableViewCell", bundle: nil), forCellReuseIdentifier: SelectedTableViewCellID)
        self.tableView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
        self.tableView.register(UINib.init(nibName: "Title5TableViewCell", bundle: nil), forCellReuseIdentifier: Title5TableViewCellID)
        self.tableView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)
        self.tableView.register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
        self.tableView.register(UINib.init(nibName: "Selected2TableViewCell", bundle: nil), forCellReuseIdentifier: Selected2TableViewCellID)
    }
    // MARK: - delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        } else if section == 1 {
            return currectSectionArr.count
//            if isbooksStr == "1"{
//                //已入账 显示入账时间
//                section1RowNum = section1RowNum + 1
//            } else {
//
//            }
//            if sendtype == "0"{
//                //上门自取
//                section1RowNum = section1RowNum + 1
//            } else {
//                //
//                section1RowNum = section1RowNum + 6
//            }
//            return section1RowNum
        } else {
            return 1
        }

    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0   {
                let cell : SelectedTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: SelectedTableViewCellID, for: indexPath) as! SelectedTableViewCell
                cell.setData_addinvoice()
                return cell
            } else if indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 4{
                let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.delegate = self
                cell.setData_addinvoce(title: sectionNameArr[indexPath.row], content: "",indexPath : indexPath)
                return cell
            }else {
                let cell : Title5TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Title5TableViewCellID, for: indexPath) as! Title5TableViewCell
                return cell
            }
        } else if indexPath.section == 1 {
            //
            if section1Type == 0  {
                if indexPath.row == 0 {
                    let cell : Selected2TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Selected2TableViewCellID, for: indexPath) as! Selected2TableViewCell
                    cell.setDataAddInvoice(title: section1NameArr[indexPath.row], leftStr: "未入账", rightStr: "已入账", indexPath: indexPath)
                    return cell
                } else if indexPath.row == 1 {
                    let cell : Selected2TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Selected2TableViewCellID, for: indexPath) as! Selected2TableViewCell
                    cell.setDataAddInvoice(title: section1NameArr[indexPath.row], leftStr: "上门自取", rightStr: "快递邮寄", indexPath: indexPath)
                    return cell
                } else if indexPath.row == 1 {
                    let cell : endTimeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    cell.setData(titleStr: "上门自取时间", tag: 0)
                    return cell
                } else {
                    let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    cell.delegate = self
                    cell.setData_addinvoce(title: section1NameArr[indexPath.row], content: "",indexPath : indexPath)
                    return cell
                }
            } else if section1Type == 1 {
                return UITableViewCell()
            } else if section1Type == 2 {
                return UITableViewCell()
            } else {
               return UITableViewCell()
            }

        } else {
            return UITableViewCell()
        }


    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 2 {
                return Title5TableViewCellH
            } else {
                return 50
            }
        } else if indexPath.section == 1 {
            return 50
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 20))
        view.backgroundColor = viewBackColor
        return view

    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 || section == 2 {
            return 20
        } else {
            return 0
        }
    }
    // MARK: - net
    func requestFail_mine() {

    }
    func requestSucceed_mine(data: Any, type: MineRequestVC_enum) {

    }

    func endEdite(inputStr: String, tagNum: Int) {

    }

    override func navigationRightBtnClick() {
        HCLog(message: "确定")
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
