//
//  DealSearch2ViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/8/23.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit


typealias DealSearch2ViewControllerBlock =  (_ numStr : String,_ dStr : String,_ bStr : String,_ eStr : String,_ kwStr : String,_ uStr : String,_ tStr : String,_ wuStr : String,_ icStr : String,_ ioStr : String)->()


class DealSearch2ViewController: BaseTableViewController,WorkRequestVCDelegate ,DatePickViewDelegate,TitleTableViewCellDelegate,OptionViewDelgate{
    let mainTabelView : UITableView = UITableView()


    var sucessBlock : DealSearch2ViewControllerBlock!

    /// 组别
    var dep : [departmentModel] = []

    /// 案件类型
    var casetype : [casetypeModel] = []

    let nameArr = ["合同编号","部门","案件类型","开始时间","结束时间","关键字","立案律师","承办律师","收费状态","案件状态"]

    var titleCell : TitleTableViewCell!

    /// 时间
    var startTimeCell : endTimeTableViewCell!
    var endTimeCell : endTimeTableViewCell!
    /// 开始时间
    var startTimeStr : String = ""
    /// 结束时间
    var endTimeStr : String = ""
    /// 时间
    var timeView : DatePickView = DatePickView.loadNib()

    /// 选项
    let optionView : OptionView = OptionView.loadNib()


    let request : WorkRequestVC = WorkRequestVC()

    var incomeCell : SelectedTableViewCell!

    var caseCell : SelectedTableViewCell!



    /// 合同编号
    var numStr = ""
    var dStr = ""
    var dNameStr = ""


    var bStr = ""
    var eStr = ""
    var kwStr = ""
    var uStr = ""
    var tStr = ""
    var tNameStr = ""

    var wuStr = ""
    var icStr = ""
    var ioStr = ""






    // MARK: - life
    override func viewWillLayoutSubviews() {

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        request.delegate = self
        self.navigation_title_fontsize(name: "合同查询", fontsize: 18)
        self.navigationBar_rightBtn_title(name: "确定")
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.creatUI()
    }

    // MARK: - UI
    func creatUI() {
//        mainTabelView.backgroundColor = viewBackColor
        mainTabelView.delegate = self;
        mainTabelView.dataSource = self;
        mainTabelView.tableFooterView = UIView()
        mainTabelView.separatorStyle = .none
        mainTabelView.showsVerticalScrollIndicator = false
        mainTabelView.showsHorizontalScrollIndicator = false
        mainTabelView.backgroundView?.backgroundColor = .clear
        mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
        mainTabelView.register(UINib.init(nibName: "SelectedTableViewCell", bundle: nil), forCellReuseIdentifier: SelectedTableViewCellID)


        self.tableView = mainTabelView

    }
    // MARK: - delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nameArr.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 1  {
            let cell : OptionTableViewCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
            cell.setData_caseDetail(titleStr: nameArr[indexPath.row], contentStr: dNameStr)

            return cell

        } else if indexPath.row == 2 {

            let cell : OptionTableViewCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
            cell.setData_caseDetail(titleStr: nameArr[indexPath.row], contentStr: tNameStr)
            return cell


        } else if indexPath.row == 3 {
            startTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
            startTimeCell.setData(titleStr: "开始时间", tag: 0)

            return startTimeCell


        } else if indexPath.row == 4 {
            endTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
            endTimeCell.setData(titleStr: "结束时间", tag: 1)
            return endTimeCell


            
        } else if indexPath.row == 8 {
            incomeCell  = tableView.dequeueReusableCell(withIdentifier: SelectedTableViewCellID, for: indexPath) as! SelectedTableViewCell
            incomeCell.setIncomeState()
            return incomeCell


        } else if indexPath.row == 9 {
            caseCell  = tableView.dequeueReusableCell(withIdentifier: SelectedTableViewCellID, for: indexPath) as! SelectedTableViewCell
            caseCell.setOverCase()
            return caseCell

        } else {
            titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
            //标题
            titleCell.setData_dealcheck(titleStr: nameArr[indexPath.row], tagNum: indexPath.row)
            titleCell.delegate = self
            return titleCell
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        if indexPath.row == 1 {
            //部门

            if dep.count > 0 {
                self.showOptionView_part()
            } else {
                request.departmentRequest()
            }

        } else if indexPath.row == 2 {
            //案件
            if casetype.count > 0 {
                self.showOptionView_share()
            } else {
                request.casetypeRequest()
            }

        } else if indexPath.row == 3 {
            //开始时间
            self.showTime_start()

        } else if indexPath.row == 4 {
            //结束时间
            self.showTime_end()

        }


    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TitleTableViewCellH
    }

    func endEdite(inputStr: String, tagNum: Int) {
        if tagNum == 0 {
            
            numStr = inputStr
        } else if tagNum == 5 {
            kwStr = inputStr
        } else if tagNum == 6 {
            uStr = inputStr
        } else if tagNum == 7 {
            wuStr = inputStr
        }
    }

    func requestSucceed_work(data: Any, type: WorkRequestVC_enum) {
        if type == .department {
            //部门
            dep = data as! [departmentModel]
            self.showOptionView_part()
        } else if type == .casetype {
            casetype = data as! [casetypeModel]
            self.showOptionView_share()


        }
    }

    func requestFail_work(){


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
            make.height.equalTo(200)
        }
    }
    func showTime_start() {
        timeView.removeFromSuperview()
        self.maskView.addSubview(self.timeView)
        self.view.window?.addSubview(self.maskView)
        timeView.delegate = self
        timeView.setData(type: 0)
        timeView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(200)
        }
    }

    func datePickViewTime(timeStr: String,type : Int) {

        self.timeView.removeFromSuperview()
        self.maskView.removeFromSuperview()
        if type == 0 {
            startTimeStr = timeStr
            startTimeCell.setTime(str: startTimeStr)
        } else {
            endTimeStr = timeStr
            endTimeCell.setTime(str: endTimeStr)
        }
    }


    func showOptionView_part() {
        self.maskView.addSubview(self.optionView)
        self.view.window?.addSubview(self.maskView)
        self.optionView.setData_dep(dataArr: dep, tagNum: 1)
        self.optionView.delegate = self
        self.optionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(200)
        }
    }

    func showOptionView_share() {
        self.maskView.addSubview(self.optionView)
        self.view.window?.addSubview(self.maskView)
        self.optionView.setData_casetypeonly(dataArr: casetype, tagNum: 2)

        self.optionView.delegate = self
        self.optionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(200)
        }
    }

    func optionSure(idStr: String, titleStr: String,noteStr : String, pickTag: Int) {

        HCLog(message: idStr)
        HCLog(message: titleStr)
        HCLog(message: noteStr)
        HCLog(message: pickTag)
        
        if pickTag == 1 {
            dStr = idStr
            dNameStr = titleStr
        } else if pickTag == 2 {
            self.tStr = idStr
            tNameStr = titleStr
        }

        let cell : OptionTableViewCell = self.mainTabelView.cellForRow(at: IndexPath(row: pickTag, section: 0)) as! OptionTableViewCell
        cell.setOptionData(contentStr: titleStr)

        self.optionView.removeFromSuperview()
        self.maskView.removeFromSuperview()
    }

    override func navigationRightBtnClick() {
        HCLog(message: numStr)
        self.view.endEditing(true)
        if incomeCell.normalBtn.isSelected {
            icStr = "1"
        } else if incomeCell.specialBtn.isSelected {
            icStr = "2"
        }

        if caseCell.normalBtn.isSelected {
            ioStr = "1"
        } else if caseCell.specialBtn.isSelected {
            ioStr = "2"
        }

        self.sucessBlock(numStr,dStr,startTimeStr,endTimeStr,kwStr,uStr,tStr,wuStr,icStr,ioStr)
        
        self.navigationController?.popViewController(animated: true)
    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
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
