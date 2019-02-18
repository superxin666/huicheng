
//
//  PersionSearchViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/10/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
typealias PersionSearchViewControllerBlock = (_ subStr : String,_ bidStr : String,_ uStr : String,_ nStr : String,_ dStr : String,_ caStr : String,_ dpStr : String,_ sStr : String,_ bdStr : String,_ edStr : String) ->()

class PersionSearchViewController: BaseTableViewController,WorkRequestVCDelegate ,DatePickViewDelegate,TitleTableViewCellDelegate,OptionViewDelgate{
    let mainTabelView : UITableView = UITableView()
    var sucessBlock : PersionSearchViewControllerBlock!
    var dataModel : getoptionsModle!


    let nameArr = ["账号","姓名","部门","类别","学历","状态","入职时间","至"]
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

    var optionCell :  OptionTableViewCell!

    /// 当前选中的行
    var currectIndexpath : IndexPath!

    /// 分所
    var bidStr = ""
    /// 帐号
    var uStr = ""
    /// 姓名
    var nStr = ""
    /// 部门
    var dStr = ""
    ///类别
    var caStr = ""
    ///学历
    var dpStr = ""
    ///状态
    var sStr = ""
    ///入职时间
    var bdStr = ""
    ///离职
    var edStr = ""

    var subStr = ""

    //选项
    var typeSub : Int = 0
    //默认没有 0 没有权限 1 有权限
    var isHaveSub : Int = 0

    var userDataModel : LoginModel!

    var sectionNum : Int!

    var branch : [branchModel] = []

    var showNum = 0

    var showArr : [getoptionsModle_content] = []



    // MARK: - life
    override func viewWillLayoutSubviews() {

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        request.delegate = self
        self.navigation_title_fontsize(name: "人员查询", fontsize: 18)
        self.navigationBar_rightBtn_title(name: "确定")
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        request.usermanageRequest()
        userDataModel = UserInfoLoaclManger.getsetUserWorkData()
        if typeSub < userDataModel.searchpower.count {
            isHaveSub = userDataModel.searchpower[typeSub]
            isHaveSub = 1
            if isHaveSub == 1 {
                //                rowNum = rowNum + 1
                sectionNum = 2
            } else {
                sectionNum = 1
            }
        }

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
        self.tableView = mainTabelView

    }
    // MARK: - delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNum
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isHaveSub ==  1 {
            if section == 0 {
                return 1
            } else {
                return self.nameArr.count
            }
        } else {
            return self.nameArr.count
        }

    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if isHaveSub == 1 && indexPath.section == 0 {
            optionCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
            optionCell.setData_caseDetail(titleStr: "分所", contentStr: "")
            return optionCell

        } else {


            if  indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                //账号
                cell.setData_dealcheck(titleStr: nameArr[indexPath.row], tagNum: indexPath.row)
                cell.delegate = self
                return cell


            } else if indexPath.row == 1  {
                //账号
                let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.setData_dealcheck(titleStr: nameArr[indexPath.row], tagNum: indexPath.row)
                cell.delegate = self
                return cell

            } else if indexPath.row == 2 {
                //部门
                let cell : OptionTableViewCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                cell.setData_caseDetail(titleStr: nameArr[indexPath.row], contentStr: dStr)
                cell.contentLabel.text = "请选择"
                return cell
            }else if indexPath.row == 3 {
                //类别
                let cell : OptionTableViewCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                cell.setData_caseDetail(titleStr: nameArr[indexPath.row], contentStr: caStr)
                cell.contentLabel.text = "请选择"
                return cell
            }else if indexPath.row == 4 {
                //学历
                let cell : OptionTableViewCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                cell.setData_caseDetail(titleStr: nameArr[indexPath.row], contentStr: dpStr)
                cell.contentLabel.text = "请选择"
                return cell
            }else if indexPath.row == 5 {
                //状态
                let cell : OptionTableViewCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                cell.setData_caseDetail(titleStr: nameArr[indexPath.row], contentStr: sStr)
                cell.contentLabel.text = "请选择"
                return cell
            } else if indexPath.row == 6 {
                //入职时间
                startTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                startTimeCell.setData(titleStr: "开始时间", tag: 0)
                startTimeCell.timeLabel.text = "请选择"
                return startTimeCell
            } else{
                //至
                endTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                endTimeCell.setData(titleStr: "至", tag: 1)
                endTimeCell.timeLabel.text = "请选择"
                return endTimeCell
            }
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        showNum = indexPath.row
        currectIndexpath = indexPath

        if isHaveSub == 1 && indexPath.section == 0 {
            //案件组别

            if branch.count > 0 {
                self.showOption_branch()
            } else {
                request.branchRequest()
            }

        } else {


            if indexPath.row == 2 {
                //部门
                showArr = self.dataModel.department
                self.showOptionView_part()

            } else if indexPath.row == 3 {
                //类别
                showArr = self.dataModel.category
                self.showOptionView_part()

            } else if indexPath.row == 4 {
                //学历
                showArr = self.dataModel.diploma

                self.showOptionView_part()


            } else if indexPath.row == 5 {
                //状态
                showArr = self.dataModel.state

                self.showOptionView_part()


            } else if indexPath.row == 6 {
                //入职时间
                self.showTime_start()
            } else if indexPath.row == 7  {
                //至
                self.showTime_end()

            }
        }

    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TitleTableViewCellH
    }

    func endEdite(inputStr: String, tagNum: Int) {
        if tagNum == 0 {
            uStr = inputStr
        } else {
            nStr = inputStr
        }

    }

    func requestSucceed_work(data: Any, type: WorkRequestVC_enum) {
        if type == .branch {
            branch = data as! [branchModel]
            self.showOption_branch()
        } else {

            dataModel  = data as! getoptionsModle

            let model : getoptionsModle_content = getoptionsModle_content()
            model.id = 0
            model.name = "禁用"

            let model2 : getoptionsModle_content = getoptionsModle_content()
            model2.id = 1
            model2.name = "可用"

            dataModel.state.append(model)
            dataModel.state.append(model2)

        }
    }

    func requestFail_work(){


    }

    func showOption_branch() {
        self.maskView.addSubview(self.optionView)
        self.view.window?.addSubview(self.maskView)
        self.optionView.setData_branch(arr: branch)

        self.optionView.delegate = self
        self.optionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(200)
        }


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
        self.optionView.setData_getoptions(dataArr: showArr, index: showNum)
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
        if isHaveSub == 1 && sectionNum > 1  && currectIndexpath.section == 0 {
            let cell : OptionTableViewCell = self.mainTabelView.cellForRow(at: IndexPath(row: 0, section: 0)) as! OptionTableViewCell
            cell.setOptionData(contentStr: titleStr)
            subStr = idStr
        } else {

            if pickTag == 2 {
                //部门
                dStr = idStr
            } else if pickTag == 3 {
                //类别
                caStr = idStr
            } else if pickTag == 4 {
                //学历
                dpStr = idStr
            } else if pickTag == 5 {
                //状态
                sStr = idStr
            }

            let cell : OptionTableViewCell = self.mainTabelView.cellForRow(at: IndexPath(row: pickTag, section: sectionNum - 1)) as! OptionTableViewCell
            cell.setOptionData(contentStr: titleStr)
        }
        self.optionView.removeFromSuperview()
        self.maskView.removeFromSuperview()
    }

    override func navigationRightBtnClick() {
        self.sucessBlock(subStr,bidStr,uStr,nStr,dStr, caStr, dpStr ,sStr , startTimeStr , endTimeStr)
        self.navigationController?.popViewController(animated: true)
    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
