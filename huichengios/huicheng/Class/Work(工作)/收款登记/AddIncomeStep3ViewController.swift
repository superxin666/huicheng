//
//  AddIncomeStep3ViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/7/20.
//  Copyright © 2018年 lvxin. All rights reserved.
//  收款详情

import UIKit

class AddIncomeStep3ViewController:BaseViewController ,UITableViewDataSource,UITableViewDelegate,Work2RequestVCDelegate {
    let mainTabelView : UITableView = UITableView()
    let requestVC = Work2RequestVC()
    var nameArr = ["合同编号","立案时间","立案律师","委托人","案件组别","合同金额","已付金额","收款历史"]
    var contenArr : [String] = []

    var nameArr1 = ["现金收款","银行转账收款","刷卡收款","刷卡手续费",]
    var contenArr1 : [String] = ["","","","",]


    var nameArr2 = ["收款金额","实收金额","收款日期","交款人","发票","发票号","社会统一信用",]
    var contenArr2 : [String] = ["","","","","","","",]

    var dataModel : income_getinfoModel!

    /// 收款金额
    var amountStr = ""

    /// 实际收入
    var moneyStr = ""

    /// 收款日期
    var addtimeStr = ""

    /// 交款人
    var user = ""

    /// 发票状态，INT 型:0-未开;1-已开
    var ispaper = ""

    /// 发票号，ispaper 为 0 时可不传
    var papernum = ""

    /// 发票信息
    var invoicetype = ""

    /// 社会统一信息用代码，ispaper 为 0 时可不传
    var creditcode = ""

    /// 保存状态，INT 型:0-存为草稿;1-正式提交
    var issubmit = ""

    /// 合同 ID
    var idStr : Int!

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

        self.navigation_title_fontsize(name: "收款详情", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.navigationBar_rightBtn_title(name: "保存")
        self.creatUI()
        self.requestApi()
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
        mainTabelView.register(UINib.init(nibName: "Title2TableViewCell", bundle: nil), forCellReuseIdentifier: Title2TableViewCellID)
        mainTabelView.register(UINib.init(nibName: "Title4TableViewCell", bundle: nil), forCellReuseIdentifier: Title4TableViewCellID)

        mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)

        mainTabelView.register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)

        mainTabelView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)

        mainTabelView.register(UINib.init(nibName: "Title5TableViewCell", bundle: nil), forCellReuseIdentifier: Title5TableViewCellID)

        self.view.addSubview(mainTabelView)
    }
    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.nameArr.count
        } else if section == 1 {
            return self.nameArr1.count
        } else {
            return self.nameArr2.count
        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 7 {
                let cell : Title2TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title2TableViewCellID, for: indexPath) as! Title2TableViewCell
                cell.setData(titleStr: nameArr[indexPath.row])
                return cell

            } else {
                let cell : Title4TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title4TableViewCellID, for: indexPath) as! Title4TableViewCell
                var str = ""
                if contenArr.count > 0 {
                    str = contenArr[indexPath.row]
                }
                cell.setData_overCase(titleStr: nameArr[indexPath.row], contentStr: str)
                return cell
            }

        } else if indexPath.section == 1 {
            let cell : TitleTableViewCell  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
            cell.setData_AddIncomeStep3(titleStr: nameArr1[indexPath.row], contentStr: "", tagNum: indexPath)
            return cell
        } else {
            if indexPath.row == 0 {
                let cell : TitleTableViewCell  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.setData_AddIncomeStep3(titleStr: nameArr2[indexPath.row], contentStr: moneyStr, tagNum: indexPath)
                
                return cell

            } else if indexPath.row == 1 {
                let cell : TitleTableViewCell  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.setData_AddIncomeStep3(titleStr: nameArr2[indexPath.row], contentStr: moneyStr, tagNum: indexPath)
                return cell

            } else if indexPath.row == 2 {
                //时间
                let cell : endTimeTableViewCell  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                cell.setData(titleStr: "收款日期", tag: 0)
                return cell
            } else if indexPath.row == 3 {
                let cell : TitleTableViewCell  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.setData_AddIncomeStep3(titleStr: nameArr2[indexPath.row], contentStr: user, tagNum: indexPath)
                return cell

            } else if indexPath.row == 4 {
                //发票
                let cell : OptionTableViewCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                cell.setDataOption(titleStr: "发票")
                return cell

            } else if indexPath.row == 5 {

                let cell : TitleTableViewCell  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.setData_AddIncomeStep3(titleStr: nameArr2[indexPath.row], contentStr: "", tagNum: indexPath)
                return cell

            } else {
                //社会统一信用
                let cell : Title5TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title5TableViewCellID, for: indexPath) as! Title5TableViewCell
                return cell

            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 7 {
                return Title2TableViewCellH
            } else {
                return Title4TableViewCellH
            }
        } else if indexPath.section == 1 {
            return TitleTableViewCellH
        } else {
            if indexPath.row == 6 {
                return Title5TableViewCellH
            } else {
                return TitleTableViewCellH
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 7 {
                if self.dataModel.items.count > 0 {
//                    let vc = IncomeHistoryViewController()
//                    vc.hidesBottomBarWhenPushed = true
//                    vc.dataModelArr = dataModel.items
//                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 2{
                HCLog(message: "选择日期")
            } else if indexPath.row == 4 {
                HCLog(message: "选择发票")
            }
        }
    }
    // MARK: - net
    func requestApi() {
        requestVC.delegate = self
        requestVC.income_getinfoRequest(id: idStr)

    }

    func requestSucceed_work2(data: Any, type: Work2RequestVC_enum) {

        dataModel = data as! income_getinfoModel

        contenArr.append(dataModel.data.dealnum)
        contenArr.append(dataModel.data.regtime)
        contenArr.append(dataModel.data.reguser)
        contenArr.append(dataModel.data.principal)
        contenArr.append("暂无")
        contenArr.append("\(dataModel.data.dealamount!)元")
        contenArr.append("\(dataModel.data.dealmoney!)元")


        moneyStr = "\(dataModel.data.money!)"
        amountStr = "\(dataModel.data.amount!)"
        user = dataModel.data.payuser

        self.mainTabelView.reloadData()
    }

    func requestFail_work2() {


    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }

    override func navigationRightBtnClick() {
        HCLog(message: "保存")
    }


}
