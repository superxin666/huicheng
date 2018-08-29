//
//  AddIncomeStep3ViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/7/20.
//  Copyright © 2018年 lvxin. All rights reserved.
//  收款详情

import UIKit

class AddIncomeStep3ViewController:BaseViewController ,UITableViewDataSource,UITableViewDelegate,Work2RequestVCDelegate,TitleTableViewCellDelegate,Title5TableViewCellDelegate,OptionViewDelgate,DatePickViewDelegate,MineRequestVCDelegate {
    let mainTabelView : UITableView = UITableView()

    /// 选项
    let optionView : OptionView = OptionView.loadNib()
    /// 时间
    var timeView : DatePickView = DatePickView.loadNib()


    /// 发票信息
    var userList : [expense_gettypeModel] = []

    let requestVC = Work2RequestVC()
    let requestVc2 : MineRequestVC = MineRequestVC()


    var nameArr = ["合同编号","立案时间","立案律师","委托人","案件组别","合同金额","已付金额","收款历史"]
    var contenArr : [String] = []

    var nameArr1 = ["现金收款","银行转账","刷卡收款","刷卡手续费",]
    var contenArr1 : [String] = ["","","","",]


    var nameArr2 = ["收款金额","实收金额","收款日期","交款人","发票","发票号","发票信息","社会统一信用",]
    var contenArr2 : [String] = ["","","","","","","",]

    var dataModel : income_getdealsinfoModel!

    /// 收款金额
    var amountStr = ""

    /// 实际收入
    var moneyStr = ""

    /// 收款日期
    var addtimeStr = ""

    /// 交款人
    var user = ""

    /// 发票状态，INT 型:0-未开;1-已开
    var ispaper = "0"
    var isPapeStr = ""


    /// 发票号，ispaper 为 0 时可不传
    var papernum = ""

    /// 发票信息，INT 型，参见发票申请中的发票内容
    var invoicetype = ""
    var invoicetypeStr = ""


    /// 社会统一信息用代码，ispaper 为 0 时可不传
    var creditcode = ""

    /// 保存状态，INT 型:0-存为草稿;1-正式提交
    var issubmit = ""

    /// 合同 ID  新增时必传，修改时可不传
    var idStr : Int!


    /// 收款信息 ID 新增时可不传，修改时必传
    var IDstr : String!


    /// 收款方式，INT 型:0-现金;1-刷卡;2-银行转帐
    var tStr : String = ""

    /// 收款金额
    var mStr : String = ""

    var xinjinStr : String = ""
    var yinhangStr : String = ""
    var shuakaStr : String = ""
    var shouxuStr : String = ""


    /// 手续费  当 t 为 1 时才传;或可传值为 0;
    var oStr : String = ""

    var iteamNum : Int = 0
    var netIteamNum : Int = 0




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
            var str = ""
            if indexPath.row == 0 {
                str = xinjinStr
            } else if indexPath.row == 1 {
                str = yinhangStr
            } else if indexPath.row == 2 {
                str = shuakaStr
            } else {
                str = shouxuStr
            }
            cell.setData_AddIncomeStep3(titleStr: nameArr1[indexPath.row], contentStr: str, tagNum: indexPath)
            cell.delegate = self
            return cell
        } else {
            if indexPath.row == 0 {
                let cell : TitleTableViewCell  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.setData_AddIncomeStep3(titleStr: nameArr2[indexPath.row], contentStr: moneyStr, tagNum: indexPath)
                cell.delegate = self
                return cell

            } else if indexPath.row == 1 {
                let cell : TitleTableViewCell  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.setData_AddIncomeStep3(titleStr: nameArr2[indexPath.row], contentStr: moneyStr, tagNum: indexPath)
                cell.delegate = self
                return cell

            } else if indexPath.row == 2 {
                //时间
                let cell : endTimeTableViewCell  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                cell.setData(titleStr: "收款日期", tag: 0)
                return cell
            } else if indexPath.row == 3 {
                let cell : TitleTableViewCell  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.setData_AddIncomeStep3(titleStr: nameArr2[indexPath.row], contentStr: user, tagNum: indexPath)
                cell.delegate = self
                return cell

            } else if indexPath.row == 4 {
                //发票
                let cell : OptionTableViewCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                cell.setDataObject(titleStr: "发票", contentStr: isPapeStr)

                return cell

            } else if indexPath.row == 5 {

                let cell : TitleTableViewCell  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.setData_AddIncomeStep3(titleStr: nameArr2[indexPath.row], contentStr: papernum, tagNum: indexPath)
                cell.delegate = self
                return cell

            } else if indexPath.row == 6 {
                let cell : OptionTableViewCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                cell.setDataObject(titleStr: "发票信息", contentStr: invoicetypeStr)
                return cell

            } else {
                //社会统一信用
                let cell : Title5TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title5TableViewCellID, for: indexPath) as! Title5TableViewCell
                cell.delegate = self
                cell.setData_overDeal(titleStr: "社会统一信用代码", contentStr: creditcode)
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
            if indexPath.row == 7 {
                return Title5TableViewCellH
            } else {
                return TitleTableViewCellH
            }
        }
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        } else if section == 1 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 20))
            view.backgroundColor = UIColor.hc_colorFromRGB(rgbValue: 0xcccccc)
            return view
        } else {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 20))
            view.backgroundColor = UIColor.hc_colorFromRGB(rgbValue: 0xcccccc)
            return view
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 20
        }
    }



    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        if indexPath.section == 0 {
            if indexPath.row == 7 {
                if self.dataModel.income.count > 0 {
                    let vc = IncomeRecord_ViewController()
                    vc.hidesBottomBarWhenPushed = true
                    vc.type = .add_history
                    vc.dataModelArr2 = self.dataModel.income
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 2{
                HCLog(message: "选择日期")
                self.showTime_end()

            } else if indexPath.row == 4 {
                HCLog(message: "选择发票")
                self.showOptionView()
            } else if indexPath.row == 6 {
                HCLog(message: "发票信息")
                //发票信息
                if userList.count > 0 {
                    self.showOptionPickView_expen()
                } else {
                    requestVc2.delegate = self
                    requestVc2.invoice_gettypeRequest()
                }
            }
        }
    }


    func showOptionPickView_expen() {
        self.maskView.addSubview(self.optionView)
        self.view.window?.addSubview(self.maskView)

        self.optionView.delegate = self
        self.optionView.setDataExpensive_addInvoice(dataArr: userList)
        self.optionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(160)
        }
    }



    func showOptionView() {
        self.maskView.addSubview(self.optionView)
        self.view.window?.addSubview(self.maskView)
        self.optionView.setDatainvoiceState_add()

        self.optionView.delegate = self
        self.optionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(160)
        }
    }






    func optionSure(idStr: String, titleStr: String, noteStr: String, pickTag: Int) {
        if pickTag == 1 {
            //发票 是否开
            ispaper = idStr
            isPapeStr = titleStr
            if ispaper == "0" {
                //未开
                papernum = ""
                creditcode = ""

                invoicetype = ""
                invoicetypeStr = ""
            }

            let cell : OptionTableViewCell = self.mainTabelView.cellForRow(at: IndexPath(row: 4, section: 2)) as! OptionTableViewCell
            cell.setOptionData(contentStr: titleStr)

        } else {
            //发票信息
             invoicetype = idStr
             invoicetypeStr = titleStr

            let cell : OptionTableViewCell = self.mainTabelView.cellForRow(at: IndexPath(row: 6, section: 2)) as! OptionTableViewCell
            cell.setOptionData(contentStr: titleStr)

        }

        self.timeView.removeFromSuperview()
        self.maskView.removeFromSuperview()
    }


    /// 显示时间
    func showTime_end() {
        timeView.removeFromSuperview()
        self.maskView.addSubview(self.timeView)
        self.view.window?.addSubview(self.maskView)

        timeView.delegate = self
        timeView.setData(type: 1)
        timeView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(160)
        }
    }


    func datePickViewTime(timeStr: String, type: Int) {
        addtimeStr = timeStr
        self.timeView.removeFromSuperview()
        self.maskView.removeFromSuperview()

        let cell : endTimeTableViewCell = self.mainTabelView.cellForRow(at: IndexPath(row: 2, section: 2)) as! endTimeTableViewCell
        cell.setTime(str: timeStr)


    }


    func endEdite(inputStr: String, tagNum: Int) {

        HCLog(message: tagNum)
        HCLog(message: inputStr)

        if tagNum == 10 {
            self.xinjinStr = inputStr

        } else if tagNum == 11 {
            self.yinhangStr = inputStr


        } else if tagNum == 12 {

            self.shuakaStr = inputStr

        } else if tagNum == 13 {

            self.shouxuStr = inputStr

        } else if tagNum == 20 {
            amountStr = inputStr

        } else if tagNum == 21 {
            moneyStr = inputStr

        } else if tagNum == 23 {
            user = inputStr

        } else if tagNum == 25 {
            papernum = inputStr
        }

    }


    func endText_title5(inputStr: String, tagNum: Int) {
        creditcode = inputStr
    }



    // MARK: - net
    func requestApi() {
        requestVC.delegate = self
        requestVC.income_getdealsinfoRequest(id: idStr)

    }


    func additemRequest() {
        requestVC.delegate = self
        requestVC.income_additemRequest(d: "\(idStr!)", t: tStr, m: mStr, o: oStr)

    }


    func addRequest() {

        requestVC.delegate = self
        requestVC.income_save(id: "", dealid: "\(idStr!)", amount: amountStr, addtime: addtimeStr, user: user, ispaper: ispaper, papernum: papernum, money: moneyStr, invoicetype: invoicetype, creditcode: creditcode, issubmit: "0")
    }

    func requestSucceed_work2(data: Any, type: Work2RequestVC_enum) {
        if type == .income_getdealsinfo{
            dataModel = data as! income_getdealsinfoModel

            contenArr.append(dataModel.data.dealsnum)
            contenArr.append(dataModel.data.regtime)
            contenArr.append(dataModel.data.reguser)
            contenArr.append(dataModel.data.principal)
            contenArr.append(dataModel.data.branch)
            if let a = dataModel.data.amount {
                contenArr.append("\(a)")
            } else {
                contenArr.append("")
            }

            if let b = dataModel.data.money {
                contenArr.append("\(b)")
            } else {
                contenArr.append("")
            }

            moneyStr = ""
            amountStr = ""
            //        user = dataModel.data.payuser

        } else if type == .income_additem{
            //添加 金额
            netIteamNum = netIteamNum + 1
            HCLog(message: iteamNum)
            if netIteamNum == iteamNum {
                //开始添加 最后一步骤
                self.addRequest()
            }

        } else if type == .income_save{

            self.navigationController?.popToRootViewController(animated: true)
        }
        self.mainTabelView.reloadData()
    }

    func requestFail_work2() {


    }


    func requestSucceed_mine(data: Any, type: MineRequestVC_enum) {
        userList = data as! [expense_gettypeModel]
        self.showOptionPickView_expen()
    }

    func requestFail_mine() {

    }


    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }

    override func navigationRightBtnClick() {
        HCLog(message: "保存")
        self.view.endEditing(true)

        if !(user.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入交款人~")
            return
        }
        if !(addtimeStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入收款日期~")
            return
        }

        if ispaper == "1" {
            if !(papernum.count > 0) {
                SVPMessageShow.showErro(infoStr: "请输入发票号~")
                return
            }
            if !(creditcode.count > 0) {
                SVPMessageShow.showErro(infoStr: "请输入社会统一信息用代码~")
                return
            }

            if !(invoicetype.count > 0) {
                SVPMessageShow.showErro(infoStr: "请输入发票信息~")
                return
            }

        }
        if !(xinjinStr.count > 0) && !(yinhangStr.count > 0) && !(shuakaStr.count > 0) {
            self.addRequest()
        } else {
            if xinjinStr.count > 0 {
                iteamNum = iteamNum + 1
            }

            if yinhangStr.count > 0 {
                iteamNum = iteamNum + 1
            }

            if shuakaStr.count > 0 {
                if !(shouxuStr.count > 0) {
                    SVPMessageShow.showErro(infoStr: "请输入刷卡手续费")
                    return
                } else {
                    iteamNum = iteamNum + 1
                }
            }


            if xinjinStr.count > 0 {
                self.tStr = "0"
                self.mStr = xinjinStr
                self.additemRequest()
            }

            if yinhangStr.count > 0 {
                self.tStr = "2"
                self.mStr = yinhangStr
                self.additemRequest()
            }

            if shuakaStr.count > 0 {
                if !(shouxuStr.count > 0) {
                    SVPMessageShow.showErro(infoStr: "请输入刷卡手续费")
                    return
                } else {
                    self.tStr = "1"
                    self.mStr = shuakaStr
                    self.oStr = shouxuStr
                    self.additemRequest()
                }
            }
        }
    }

}
