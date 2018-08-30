//
//  PayCheckDetialViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/8/28.
//  Copyright © 2018年 lvxin. All rights reserved.
//  支付审核详情

import UIKit
typealias PayCheckDetialViewControllerBlock = ()->()

class PayCheckDetialViewController:  BaseViewController,Work2RequestVCDelegate,UITableViewDelegate,UITableViewDataSource,SelectedTableViewCellDelegate,ContentTableViewCellDelegate {

    var sucessBlock : PayCheckDetialViewControllerBlock!


    let mainTabelView : UITableView = UITableView()
    let request : Work2RequestVC = Work2RequestVC()
    var dataModel : pay_applyinfoModel!
    var id : String!

    var alertController : UIAlertController!

    var titleArr : [String] = []

    let name1 = ["收款律师","金额","支付信息","卡号","分成比列","申请时间","状态"]
    var content1 :[String] = []

    let name2 = ["报销类型","发票金额","附件张数","申请时间","审核人","审核时间"]
    var content2 : [String] = []

    let name3 = ["合同编号","案件编号","案件名称","立案时间","立案律师","承办律师","合同金额","已付金额"]
    var content3 : [String] = []

    /// 1-审核通过;2-审核驳回
    var stateStr = "1"

    var nStr : String = ""



    // MARK: - life
    override func viewWillLayoutSubviews() {
        mainTabelView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(0)
            make.left.right.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        self.navigation_title_fontsize(name: "支付审核", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.navigationBar_rightBtn_title(name: "保存")
        self.creatUI()
        request.delegate = self
        request.financePayapplyinfo(id: id)

    }
    // MARK: - UI
    func creatUI() {
        mainTabelView.backgroundColor = UIColor.clear
        mainTabelView.delegate = self;
        mainTabelView.dataSource = self;
        mainTabelView.tableFooterView = UIView()
        mainTabelView.separatorStyle = .none
        mainTabelView.showsVerticalScrollIndicator = false
        mainTabelView.showsHorizontalScrollIndicator = false
        mainTabelView.backgroundView?.backgroundColor = .clear
        mainTabelView.register(UINib.init(nibName: "Title4TableViewCell", bundle: nil), forCellReuseIdentifier: Title4TableViewCellID)
        mainTabelView.register(UINib.init(nibName: "SelectedTableViewCell", bundle: nil), forCellReuseIdentifier: SelectedTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: ContentTableViewCellID)
        self.view.addSubview(mainTabelView)
    }

    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        if let model = dataModel {
            return 3
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model = dataModel {
            if model.data.type == 0 {

                if section == 0 {
                    if stateStr == "1" {
                        return 1
                    } else {
                        return 2
                    }

                } else if section == 1 {
                    return name1.count
                } else {
                    return name3.count
                }
            } else {
                if section == 0 {
                    if stateStr == "1" {
                        return 1
                    } else {
                        return 2
                    }
                } else if section == 1 {
                    return name1.count
                } else {
                    return name2.count
                }
            }
        } else {
            return 0
        }

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let model = dataModel {

            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    let cell : SelectedTableViewCell  = tableView.dequeueReusableCell(withIdentifier: SelectedTableViewCellID, for: indexPath) as! SelectedTableViewCell
                    cell.delegate = self
                    cell.setData_dealcheckdetail(state: stateStr)
                    return cell
                } else {

                    let cell : ContentTableViewCell  = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
                    cell.delegate = self
                    cell.setData_casecheckDetail(title: "驳回原因", contentCase: nStr, tag: 10)
                    return cell
                }
            } else if indexPath.section == 1 {
                let cell : Title4TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Title4TableViewCellID, for: indexPath) as! Title4TableViewCell
                cell.setData_PayApplyDetail(titleStr: name1[indexPath.row], contentStr: content1[indexPath.row])
                return cell

            } else  {
                let cell : Title4TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Title4TableViewCellID, for: indexPath) as! Title4TableViewCell
                var titleStrArr : [String] = []
                var contentStrArr : [String] = []

                if model.data.type == 0 {
                    titleStrArr = name3
                    contentStrArr = content3
                } else {
                    titleStrArr = name2
                    contentStrArr = content2
                }
                cell.setData_PayApplyDetail(titleStr: titleStrArr[indexPath.row], contentStr: contentStrArr[indexPath.row])
                return cell
            }


        } else {
            let cell : UITableViewCell = UITableViewCell()
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return FinanceDetialViewControllerCellH
            } else if indexPath.row == 1 {
                return ContentTableViewCellH
            } else {
                return FinanceDetialViewControllerCellH
            }
        } else {
            return FinanceDetialViewControllerCellH
        }
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 40
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            return view

        } else {
            let view = FinanceDetialHeadView.loadNib()
            view.setData(name: titleArr[section - 1])
            view.backgroundColor = UIColor.hc_colorFromRGB(rgbValue: 0xcccccc)
            return view

        }

    }

    func selectedClickDelegate_type(tag: Int, type: String) {
        if type == "0" {
            stateStr = "1"
        } else {
            stateStr = "2"
        }
        self.mainTabelView.reloadSections([0], with: .automatic)

    }

    func endText_content(content: String, tagNum: Int) {
        nStr = content
    }

    func requestSucceed_work2(data: Any, type: Work2RequestVC_enum) {
        if type == .pay_applyinfo {
            dataModel = data as! pay_applyinfoModel
            if dataModel.data.type == 0 {
                //分成
                titleArr = ["支付信息","合同信息"]
                content1.append(dataModel.data.user)
                content1.append("\(dataModel.data.money!)")
                content1.append(dataModel.data.bank)
                content1.append(dataModel.data.cardno)
                content1.append("\(dataModel.data.prpportion!)")//比例
                content1.append(dataModel.data.addtime)
                content1.append(dataModel.data.stateStr)


                content3.append(dataModel.income.dealnum)
                content3.append(dataModel.data.casenum)//案件编号
                content3.append(dataModel.data.casename) //案件名称
                content3.append(dataModel.income.regtime)
                content3.append(dataModel.income.reguser)
                content3.append("暂无")//承办律师
                content3.append("\(dataModel.data.dealamount!)")
                content3.append("\(dataModel.data.paymoney!)")

            } else {
                //报销
                titleArr = ["支付信息","报销信息",]
                content1.append(dataModel.data.user)
                content1.append("\(dataModel.data.money!)")
                content1.append(dataModel.data.bank)
                content1.append(dataModel.data.cardno)
                content1.append("\(dataModel.data.prpportion!)")//比例
                content1.append(dataModel.data.addtime)
                content1.append(dataModel.data.stateStr)


                content2.append(dataModel.expense.typeStr)
                content2.append("\(dataModel.expense.money!)")
                content2.append("\(dataModel.expense.total!)")
                content2.append(dataModel.expense.addtime)
                content2.append(dataModel.data.applyname)
                content2.append(dataModel.data.applytime)

            }
            self.mainTabelView.reloadData()

        } else if type == .pay_applysave {
            self.sucessBlock()
            self.navigationLeftBtnClick()
        }

    }


    func requestFail_work2() {

    }
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }

    override func navigationRightBtnClick() {
        HCLog(message: "保存")
        self.view.endEditing(true)
        if stateStr == "2" {
            if !(nStr.count > 0) {
                SVPMessageShow.showErro(infoStr: "请输入驳回原因")
                return
            }
        }
        request.pay_applysaveRequest(id: id, s: stateStr, n: nStr)

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
