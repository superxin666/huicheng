//
//  AddIncomeDetailViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/7/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//  收款详情

import UIKit

class AddIncomeDetailViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,TitleTableViewCellDelegate,Title5TableViewCellDelegate,DatePickViewDelegate,OptionViewDelgate,Work2RequestVCDelegate {

    let requestVC = Work2RequestVC()

    let mainTabelView : UITableView = UITableView()
    var dataModelArr : [Income_getlistModel] = []
    let nameArr = ["共收金额","实收金额","收款日期","交款人","发票","发票号","社会统一信用",]
    /// 时间
    var timeView : DatePickView = DatePickView.loadNib()

    /// 选项
    let optionView : OptionView = OptionView.loadNib()

    var endTimeCell : endTimeTableViewCell!

    var endTimeStr : String = ""

    /// 收款信息 ID，INT 型。新增时可不传，修改时必传
    var id = ""
    /// 合同 ID，INT 型。新增时必传，修改时可不传
    var dealid = ""
    /// 收款金额，浮点型
    var amount = ""
    ///收款日期，格式:2018-03-15
    var addtime = ""
    ///交款人，字符串
    var user = ""
    ///发票状态，INT 型:0-未开;1-已开
    var ispaper = "0"
    ///发票号，ispaper 为 0 时可不传
    var papernum = ""
    ///实际收入
    var money = ""
    ///交款人，字符串
    var invoicetype = ""
    /// 社会统一信息用代码，ispaper 为 0 时可不传
    var creditcode = ""
    /// 保存状态，INT 型:0-存为草稿;1-正式提交
    var issubmit = "0"




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
        self.navigationBar_rightBtn_title(name: "保存")
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.creatUI()
        requestVC.delegate = self


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
        mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
        mainTabelView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "Title5TableViewCell", bundle: nil), forCellReuseIdentifier: Title5TableViewCellID)



        self.view.addSubview(mainTabelView)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 2 {
            //时间
            endTimeCell  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
            endTimeCell.setData(titleStr: nameArr[indexPath.row], tag: 0)
            return endTimeCell

        } else if indexPath.row == 4 {
            //发票
            let cell : OptionTableViewCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
            cell.setData_caseDetail(titleStr: nameArr[indexPath.row], contentStr: "")
            return cell


        } else if indexPath.row == 6{
            //信用
            let cell : Title5TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title5TableViewCellID, for: indexPath) as! Title5TableViewCell
            cell.delegate = self
            cell.setData(titleStr: nameArr[indexPath.row])
            return cell

        } else {
            let cell : TitleTableViewCell  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
            cell.delegate = self
            cell.setData_ovewdeal(titleStr: nameArr[indexPath.row], indexPath: indexPath)
            return cell

        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return OptionTableViewCellH
        } else if indexPath.row == 4 {
            return OptionTableViewCellH
        } else if indexPath.row == 6 {
            return Title5TableViewCellH
        } else {
            return TitleTableViewCellH
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        if  indexPath.row == 2  {
            //时间
            self.showTime_end()
        } else if indexPath.row == 4 {
            //发票号
            self.showOptionView_state()
        }
    }

    func endEdite(inputStr: String, tagNum: Int) {
        if tagNum == 0 {
            //共收
            self.amount = inputStr
        } else if tagNum == 1 {
            //实际
            self.money = inputStr
        } else if tagNum == 3 {
            //交款人
            self.user = inputStr
        } else if tagNum == 4 {
            //发票号
            self.papernum = inputStr
        }
    }

    func endText_title5(inputStr: String, tagNum: Int) {
        self.creditcode = inputStr
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
        self.timeView.removeFromSuperview()
        self.maskView.removeFromSuperview()
        endTimeStr = timeStr
        endTimeCell.setTime(str: endTimeStr)

    }




    //显示发票状态
    func showOptionView_state() {
        self.maskView.addSubview(self.optionView)
        self.view.window?.addSubview(self.maskView)
        self.optionView.setData()
        self.optionView.delegate = self
        self.optionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(160)
        }
    }

    func optionSure(idStr: String, titleStr: String, pickTag: Int) {

        let cell : OptionTableViewCell = self.mainTabelView.cellForRow(at: IndexPath(row: 5, section: 0)) as! OptionTableViewCell
        cell.setOptionData(contentStr: titleStr)
        self.optionView.removeFromSuperview()
        self.maskView.removeFromSuperview()
        self.ispaper = idStr

    }

    func requestSucceed_work2(data: Any, type: Work2RequestVC_enum) {
        SVPMessageShow.showSucess(infoStr: "保存成功")
    }

    func requestFail_work2() {

    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        //
        HCLog(message: "保存")
        requestVC.income_save(id: self.id, dealid: self.dealid, amount: self.amount, addtime: self.endTimeStr, user: self.user, ispaper: self.ispaper, papernum: self.papernum, money: self.money, invoicetype: self.invoicetype, creditcode: self.creditcode, issubmit: self.issubmit)

    }

}
