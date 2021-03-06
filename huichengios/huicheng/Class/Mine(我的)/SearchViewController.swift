//
//  SearchViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/30.
//  Copyright © 2018年 lvxin. All rights reserved.
//  搜索

import UIKit
typealias SearchViewControllerBlock_expense = (_ stateId : String)->()

typealias SubViewControllerBlock = (_ subId : String)->()

typealias ExpenseapplyViewControllerBlock_expense = (_ stateId : String,_ branchId : String,_ prStr : String)->()

typealias SearchViewControllerBlock_work = (_ subStr : String,_ titleStr : String,_ personStr : String,_ StartTimeStr : String,_ endTimeStr : String)->()
typealias SearchViewControllerBlock_dealcheck = (_ bidStr : String,_ nStr : String,_ StartTimeStr : String,_ endTimeStr : String,_ uStr : String,_ prStr : String)->()

typealias SearchViewControllerBlock_deal2 = (_ bidStr : String,_ titleStr : String,_ StartTimeStr : String,_ endTimeStr : String)->()


typealias SearchViewControllerBlock_finance = (_ bidStr : String,_ noStr : String,_ nStr : String,_ sStr : String,_ stStr : String,_ etStr : String)->()
typealias SearchViewControllerBlock_caselsit = (_ bidStr : String,_ stStr : String,_ etStr : String)->()
typealias SearchViewControllerBlock_deal = (_ bidStr : String,_ contentStr : String)->()
typealias SearchViewControllerBlock_bank = (_ subStr : String,_ personStr : String,_ dStr : String)->()

typealias SearchViewControllerBlock_docSearch = (_ nStr : String,_ dnStr : String,_ kwStr : String,_ uStr : String,_ cnStr : String,_ bidStr : String,_ startTimeStr : String,_ endTimeStr : String)->()
enum SearchViewController_type {

    //发票申请           收款记录       工作日志      发票列表         案件查询        合同查询   姓名    部门 人员姓名     收款登记
    case expense_type, finance_type , work_type ,invoice_getlist,caselsit_type,deal_type,person,departAndPerson,Income_list,doc_search,shareType,conven_type,deal2_type,workbook_type,dealcheck,dealsearch,PayApplylist,PayCheck,Expenseapply,Statistics

}
let Searchcell_finance_typeID = "Searchcell_finance_type_id"
class SearchViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate,DatePickViewDelegate,OptionViewDelgate,WorkRequestVCDelegate,TitleTableViewCellDelegate {
    /// 列表
    let mainTabelView : UITableView = UITableView()
//    类型
    var type : SearchViewController_type!
//选项
    var typeSub : Int = 0
//默认没有 0 没有权限 1 有权限
    var isHaveSub : Int = 0

//   行数
    var rowNum : Int!

    var sectionNum : Int!


    var subBlock : SubViewControllerBlock!


    /// 选择类型 block
    var sureStateBlock : SearchViewControllerBlock_expense!
    
    /// 工作日志
    var sureWorkBlock : SearchViewControllerBlock_work!
    
    /// 我都收款
    var sureFinanceBlock : SearchViewControllerBlock_finance!
    
    /// 案件查询
    var sureCaselsitBlock : SearchViewControllerBlock_caselsit!

    /// 案件查询
    var sureDealBlock : SearchViewControllerBlock_deal!

    var sureBankBlock : SearchViewControllerBlock_bank!

    var sureDocSearchSure : SearchViewControllerBlock_docSearch!

    var deal2SureBlock : SearchViewControllerBlock_deal2!

    var dealcheckBlock : SearchViewControllerBlock_dealcheck!

    var expenBlock : ExpenseapplyViewControllerBlock_expense!


    var StatisticsBlock : SearchViewControllerBlock_dealcheck!

    /// 状态cell
    var stateCell : SearchStateTableViewCell!

    var optionCell :  OptionTableViewCell!
    /// 标题
    var titleCell : TitleTableViewCell!
    
    /// 发布人
    var persionCell : SearchPersionTableViewCell!
    
    
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

    /// 组别
    var dep : [departmentModel] = []

    var branch : [branchModel] = []


    let request : WorkRequestVC = WorkRequestVC()

    /// 当前选中的行
    var currectIndexpath : IndexPath!

    var dStr : String = ""

    let doc_searchNameArr = ["合同编号","函件编号","申请人","律师名称","案件名称"]
    let dealcheckNameArr = ["合同编号","开始时间","结束时间","立案律师","委托人"]
    /// 合同编号
    var nStr = ""
    /// 函件编号
    var dnStr = ""
    /// 申请人
    var kwStr = ""
    /// 律师名称
    var uStr = ""
    /// 案件名称
    var cnStr = ""
    ///
    var bidStr = ""



    var branchID = ""

    var payId = ""


    /// 委托人
    var prStr = ""

    /// 分所id
    var subStr = ""

    var currectRow = 0

    var userDataModel : LoginModel!

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


        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        if type == .expense_type {
            self.navigation_title_fontsize(name: "报销查询", fontsize: 18)
            rowNum = 1
        } else if  type == .finance_type{
            self.navigation_title_fontsize(name: "收款查询", fontsize: 18)
            rowNum = 5
        } else if type == .work_type{
            self.navigation_title_fontsize(name: "公告查询", fontsize: 18)
            rowNum = 4
        } else if type == .invoice_getlist{
            self.navigation_title_fontsize(name: "发票查询", fontsize: 18)
            rowNum = 1
        }else if type == .caselsit_type{
            self.navigation_title_fontsize(name: "案件查询", fontsize: 18)
            rowNum = 2
        } else if type == .workbook_type{
            self.navigation_title_fontsize(name: "工作日志查询", fontsize: 18)
            rowNum = 2
        } else if type == .deal_type {
            self.navigation_title_fontsize(name: "编号查询", fontsize: 18)
            rowNum = 1

        } else if type == .deal2_type {
            self.navigation_title_fontsize(name: "合同查询", fontsize: 18)
            rowNum = 3

        } else if type == .person{
            self.navigation_title_fontsize(name: "信息查询", fontsize: 18)
            rowNum = 1
        } else if type == .departAndPerson{
            self.navigation_title_fontsize(name: "银行信息查询", fontsize: 18)
            request.delegate = self

            rowNum = 2
        } else if type == .Income_list{
            self.navigation_title_fontsize(name: "收款登记查询", fontsize: 18)
            request.delegate = self
            rowNum = 5
        } else if type == .doc_search{
            self.navigation_title_fontsize(name: "函件查询", fontsize: 18)
            rowNum = 7
        } else if type == .shareType{
            self.navigation_title_fontsize(name: "共享模板查询", fontsize: 18)
            rowNum = 2
        } else if type == .conven_type{
            self.navigation_title_fontsize(name: "便捷查询", fontsize: 18)
            rowNum = 1

        } else if type == .dealcheck{
            self.navigation_title_fontsize(name: "合同查询", fontsize: 18)
            rowNum = 5
        } else if type == .dealsearch{
            self.navigation_title_fontsize(name: "合同查询", fontsize: 18)
            rowNum = 10
        } else if type == .PayApplylist{
            self.navigation_title_fontsize(name: "线下支付查询", fontsize: 18)
            rowNum = 5

        } else if type == .PayCheck{
            self.navigation_title_fontsize(name: "支付审核查询", fontsize: 18)
            rowNum = 4

        } else if type == .Expenseapply{

            self.navigation_title_fontsize(name: "报销审批查询", fontsize: 18)
            rowNum = 2

        } else if type == .Statistics{
            self.navigation_title_fontsize(name: "统计报表查询", fontsize: 18)
            rowNum = 5

        }
        userDataModel = UserInfoLoaclManger.getsetUserWorkData()
        if typeSub < userDataModel.searchpower.count {
            isHaveSub = userDataModel.searchpower[typeSub]
//            isHaveSub = 1
//            let arr = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]

//            isHaveSub = arr[typeSub]

            if isHaveSub == 1 {
//                rowNum = rowNum + 1
                sectionNum = 2
            } else {
                sectionNum = 1
            }
        }


        request.delegate = self
        self.navigationBar_rightBtn_title(name: "确定")
        self.creatUI()
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

        mainTabelView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)

        if type == .expense_type || type == .invoice_getlist {

            mainTabelView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)

        } else if type == .finance_type {
            
            mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
            mainTabelView.register(UINib.init(nibName: "SearchPersionTableViewCell", bundle: nil), forCellReuseIdentifier: SearchPersionTableViewCellID)
            mainTabelView.register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
            mainTabelView.register(UINib.init(nibName: "SearchStateTableViewCell", bundle: nil), forCellReuseIdentifier: SearchStateTableViewCellID)
        } else if type == .work_type {
            mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
            mainTabelView.register(UINib.init(nibName: "SearchPersionTableViewCell", bundle: nil), forCellReuseIdentifier: SearchPersionTableViewCellID)
            mainTabelView.register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
            
            
        }else if type == .caselsit_type {
            mainTabelView.register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
        } else if type == .workbook_type {
            mainTabelView.register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)

        } else if type == .deal_type || type == .person || type == .conven_type{
            mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)

        } else if type == .deal2_type{
            mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
            mainTabelView.register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)

        } else if type == .departAndPerson{

            mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)

            mainTabelView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)

        } else if type == .Income_list{
            mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
            mainTabelView.register(UINib.init(nibName: "SearchPersionTableViewCell", bundle: nil), forCellReuseIdentifier: SearchPersionTableViewCellID)
            mainTabelView.register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
            mainTabelView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)
        } else if type == .doc_search{
            mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
            mainTabelView.register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
            mainTabelView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)
        } else if type == .shareType {
            mainTabelView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)
            mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)

        }else if type == .dealcheck {
            mainTabelView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)
            mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
            mainTabelView.register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
        } else if type == .PayApplylist{
            mainTabelView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)
            mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
            mainTabelView.register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
        } else if type == .PayCheck{
            mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
            mainTabelView.register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)

        } else if type == .Expenseapply{

            mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
            mainTabelView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)
        } else if type == .Statistics{
            mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
            mainTabelView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)
            mainTabelView.register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
        }
        self.view.addSubview(mainTabelView)
    }
    
    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNum
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isHaveSub ==  1 {
            if section == 0 {
                return 1
            } else {
                return rowNum
            }
        } else {
            return rowNum
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isHaveSub == 1 && indexPath.section == 0 {
            optionCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
            optionCell.setData_caseDetail(titleStr: "分所", contentStr: "")
            return optionCell

        } else {

            if type == .expense_type {
                optionCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                optionCell.setData_caseDetail(titleStr: "状态", contentStr: "")
                return optionCell
            } else if type == .invoice_getlist{
                optionCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                optionCell.setData_caseDetail(titleStr: "状态", contentStr: "")
                return optionCell

            } else if type == .finance_type{
                //我都收款

                if indexPath.row == 0 {

                    titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    //交款人
                    titleCell.setData_search(titleStr: "交款人")
                    return titleCell
                } else if indexPath.row == 1 {

                    //合同编号
                    persionCell = tableView.dequeueReusableCell(withIdentifier: SearchPersionTableViewCellID, for: indexPath) as! SearchPersionTableViewCell
                    persionCell.setData(titleStr: "合同编号", fieldTag: 1)
                    return persionCell

                } else if indexPath.row == 2 {
                    //开始时间
                    startTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    startTimeCell.setData(titleStr: "开始时间", tag: 0)

                    return startTimeCell
                } else if indexPath.row == 3 {
                    //结束时间
                    endTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    endTimeCell.setData(titleStr: "结束时间", tag: 1)
                    return endTimeCell
                } else {
                    //状态
                    stateCell  = tableView.dequeueReusableCell(withIdentifier: SearchStateTableViewCellID, for: indexPath) as! SearchStateTableViewCell
                    stateCell.type = .finance
                    stateCell.setData_searchState(titleStr: "状态")
                    return stateCell
                }


            } else if type == .work_type{
                //公告搜索
                if indexPath.row == 0 {
                    titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    //标题
                    titleCell.setData_search(titleStr: "标题")
                    return titleCell

                } else if indexPath.row == 1 {
                    //发布人
                    persionCell = tableView.dequeueReusableCell(withIdentifier: SearchPersionTableViewCellID, for: indexPath) as! SearchPersionTableViewCell
                    persionCell.setData(titleStr: "发布人", fieldTag: 1)
                    return persionCell

                } else if indexPath.row == 2 {
                    //开始时间
                    startTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    startTimeCell.setData(titleStr: "开始时间", tag: 0)

                    return startTimeCell

                } else {
                    //结束时间
                    endTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    endTimeCell.setData(titleStr: "结束时间", tag: 1)
                    return endTimeCell
                }

            }else if type == .caselsit_type{
                //公告搜索
                if indexPath.row == 0 {
                    //开始时间
                    startTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    startTimeCell.setData(titleStr: "开始时间", tag: 0)
                    return startTimeCell

                } else {
                    //结束时间
                    endTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    endTimeCell.setData(titleStr: "结束时间", tag: 1)
                    return endTimeCell

                }

            } else if type == .workbook_type {
                if indexPath.row == 0 {
                    //开始时间
                    startTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    startTimeCell.setData(titleStr: "开始时间", tag: 0)
                    return startTimeCell

                } else {
                    //结束时间
                    endTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    endTimeCell.setData(titleStr: "结束时间", tag: 1)
                    return endTimeCell

                }

            } else if type == .deal_type{
                titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                //标题
                titleCell.setData_search(titleStr: "合同编号")
                return titleCell

            } else if type == .deal2_type{
                if indexPath.row == 0{
                    titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    //标题
                    titleCell.setData_search(titleStr: "合同编号")
                    return titleCell


                } else if indexPath.row == 1 {
                    //开始时间
                    startTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    startTimeCell.setData(titleStr: "开始时间", tag: 0)
                    return startTimeCell



                } else {
                    //结束时间
                    endTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    endTimeCell.setData(titleStr: "结束时间", tag: 1)
                    return endTimeCell


                }
            } else if type == .person{
                titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                //标题
                titleCell.setData_search(titleStr: "姓名")
                return titleCell

            }  else if type == .conven_type{
                titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                //标题
                titleCell.setData_search(titleStr: "关键字")
                return titleCell

            } else if type == .departAndPerson{
                if indexPath.row == 0 {
                    titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    //标题
                    titleCell.setData_search(titleStr: "姓名")
                    return titleCell
                } else {
                    optionCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                    optionCell.setData_caseDetail(titleStr: "部门", contentStr: "")
                    return optionCell
                }


            } else if type == .Income_list{

                if indexPath.row == 0 {
                    //合同编号
                    persionCell = tableView.dequeueReusableCell(withIdentifier: SearchPersionTableViewCellID, for: indexPath) as! SearchPersionTableViewCell
                    persionCell.setData(titleStr: "合同编号", fieldTag: 1)
                    return persionCell

                } else if indexPath.row == 1 {
                    titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    //交款人
                    titleCell.setData_search(titleStr: "交款人")
                    return titleCell

                } else if indexPath.row == 2 {
                    //开始时间
                    startTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    startTimeCell.setData(titleStr: "开始时间", tag: 0)

                    return startTimeCell
                } else if indexPath.row == 3 {
                    //结束时间
                    endTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    endTimeCell.setData(titleStr: "结束时间", tag: 1)
                    return endTimeCell
                } else {
                    //状态
                    optionCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                    optionCell.setData_caseDetail(titleStr: "状态", contentStr: "")
                    return optionCell
                }


            } else if type == .doc_search{

                if indexPath.row == 5  {

                    //开始时间
                    startTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    startTimeCell.setData(titleStr: "开始时间", tag: 0)
                    startTimeCell.timeLabel.text = "请选择"
                    return startTimeCell

                }   else if indexPath.row == 6 {
                    endTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    endTimeCell.setData(titleStr: "结束时间", tag: 1)
                    endTimeCell.timeLabel.text = "请选择"
                    return endTimeCell

                } else {

                    titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    //交款人
                    titleCell.setData_ovewdeal(titleStr: doc_searchNameArr[indexPath.row], indexPath: indexPath)
                    titleCell.delegate = self

                    return titleCell
                }
            } else if type == .shareType{
                if indexPath.row == 0 {
                    optionCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                    optionCell.setData_caseDetail(titleStr: "分类", contentStr: "")
                    return optionCell
                } else {
                    titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    //标题
                    titleCell.setData_search(titleStr: "关键字")
                    return titleCell

                }

            } else if type == .dealcheck{
                if indexPath.row == 1 {
                    startTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    startTimeCell.setData(titleStr: "开始时间", tag: 0)
                    return startTimeCell
                } else if indexPath.row == 2 {
                    endTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    endTimeCell.setData(titleStr: "结束时间", tag: 1)
                    return endTimeCell

                } else {
                    titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    //标题
                    titleCell.setData_dealcheck(titleStr: dealcheckNameArr[indexPath.row], tagNum: indexPath.row)

                    titleCell.delegate = self
                    return titleCell
                }

            } else if type == .PayApplylist{
                if indexPath.row == 0 {
                    titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    //合同编号
                    titleCell.setData_ovewdeal(titleStr: "合同编号", indexPath: indexPath)
                    titleCell.delegate = self
                    return titleCell

                } else if indexPath.row == 1 {
                    titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    //交款人
                    titleCell.setData_ovewdeal(titleStr: "交款人", indexPath: indexPath)
                    titleCell.delegate = self
                    return titleCell

                }     else  if indexPath.row == 2 {
                    startTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    startTimeCell.setData(titleStr: "开始时间", tag: 0)

                    return startTimeCell
                } else if indexPath.row == 3 {
                    endTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    endTimeCell.setData(titleStr: "结束时间", tag: 1)
                    return endTimeCell

                } else {
                    optionCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                    optionCell.setData_caseDetail(titleStr: "状态", contentStr: "")
                    return optionCell
                }

            } else if type == .PayCheck{

                if indexPath.row == 0 {
                    titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    //合同编号
                    titleCell.setData_ovewdeal(titleStr: "合同编号", indexPath: indexPath)
                    titleCell.delegate = self
                    return titleCell

                } else if indexPath.row == 1 {
                    titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    //交款人
                    titleCell.setData_ovewdeal(titleStr: "交款人", indexPath: indexPath)
                    titleCell.delegate = self
                    return titleCell

                }   else  if indexPath.row == 2 {
                    startTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    startTimeCell.setData(titleStr: "开始时间", tag: 0)
                    return startTimeCell
                } else  {
                    endTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    endTimeCell.setData(titleStr: "结束时间", tag: 1)
                    return endTimeCell

                }


            } else if type == .Expenseapply{
                if indexPath.row == 0 {
                    titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    //交款人
                    titleCell.setData_ovewdeal(titleStr: "申请人", indexPath: indexPath)
                    titleCell.delegate = self
                    return titleCell

                } else {
                    optionCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                    optionCell.setData_caseDetail(titleStr: "状态", contentStr: "")
                    return optionCell
                }
            } else if type == .Statistics{
                if indexPath.row == 0 {
                    titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    //交款人
                    titleCell.setData_ovewdeal(titleStr: "律师", indexPath: indexPath)
                    titleCell.delegate = self
                    return titleCell

                } else if indexPath.row == 1 {
                    optionCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                    optionCell.setData_caseDetail(titleStr: "部门", contentStr: "")
                    return optionCell
                } else if indexPath.row == 2 {
                    startTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    startTimeCell.setData(titleStr: "开始时间", tag: 0)
                    return startTimeCell
                } else if indexPath.row == 3 {
                    endTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    endTimeCell.setData(titleStr: "结束时间", tag: 1)
                    return endTimeCell

                } else {
                    let cell :OptionTableViewCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                    cell.setData_caseDetail(titleStr: "支付情况", contentStr: "")
                    return cell
                }


            } else {
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        currectIndexpath = indexPath

        if isHaveSub == 1 && indexPath.section == 0 {
            //案件组别

            if dep.count > 0 {
                self.showOption_branch()
            } else {
                request.branchRequest()
            }

        } else {
            if type == .finance_type {
                //收款
                if indexPath.row == 2 {
                    //开始时间
                    self.showTime_start()
                } else if indexPath.row == 3{
                    //结束时间
                    self.showTime_end()

                }
            } else if type == .caselsit_type{

                if indexPath.row == 0 {
                    //开始时间
                    self.showTime_start()
                } else if indexPath.row == 1 {
                    //结束时间
                    self.showTime_end()
                }
            } else if type == .workbook_type{
                if indexPath.row == 0 {
                    //开始时间
                    self.showTime_start()
                } else if indexPath.row == 1 {
                    //结束时间
                    self.showTime_end()
                }
            } else if type == .deal2_type{

                if indexPath.row == 1 {
                    //开始时间
                    self.showTime_start()
                } else if indexPath.row == 2 {
                    //结束时间
                    self.showTime_end()
                }
            } else if type == .work_type {
                if indexPath.row == 2 {
                    //开始时间
                    self.showTime_start()
                } else if indexPath.row == 3{
                    //结束时间
                    self.showTime_end()
                }


            } else if type == .departAndPerson{
                currectIndexpath = indexPath
                //部门
                //案件组别
                if dep.count > 0 {
                    self.showOption(indexPath: indexPath)
                } else {
                    request.departmentRequest()
                }

            } else if type == .Income_list {
                //收款
                if indexPath.row == 2 {
                    //开始时间
                    self.showTime_start()
                } else if indexPath.row == 3{
                    //结束时间
                    self.showTime_end()

                } else if indexPath.row == 4 {
                    //状态
                    self.showOptionView_state()
                }
            } else if type == .doc_search {
                currectIndexpath = indexPath
                if indexPath.row == 5 {
                    //开始时间
                    self.showTime_start()
                } else if indexPath.row == 6 {
                    //结束时间
                    self.showTime_end()
                }
            }else if type == .shareType{
                currectIndexpath = indexPath
                //模板
                self.showOptionView_share()
            } else if type == .dealcheck{
                if indexPath.row == 1 {
                    //开始时间
                    self.showTime_start()
                } else if indexPath.row == 2{
                    //结束时间
                    self.showTime_end()
                }
            } else if type == .invoice_getlist || type == .expense_type{

                self.showOptionView_state()
            } else if type == .PayApplylist {
                if indexPath.row == 2 {
                    //开始时间
                    self.showTime_start()
                } else if indexPath.row == 3{
                    //结束时间
                    self.showTime_end()
                } else {
                    //                self.showOptionView_state()
                    self.showOption_finance()
                }
            } else if type == .PayCheck{
                if indexPath.row == 2 {
                    //开始时间
                    self.showTime_start()
                } else if indexPath.row == 3{
                    //结束时间
                    self.showTime_end()
                }
            } else if type == .Expenseapply{
                if indexPath.row == 1 {
                    //状态
                    self.showOptionView_state()
                }

            } else if type == .Statistics{
                currectIndexpath = indexPath
                currectRow = indexPath.row
                if indexPath.row == 1 {
                    //部门
                    if dep.count > 0 {
                        self.showOption(indexPath: indexPath)
                    } else {
                        request.departmentRequest()
                    }
                } else if indexPath.row == 2 {
                    self.showTime_start()

                } else if indexPath.row == 3 {
                    self.showTime_end()
                } else if indexPath.row == 4 {
                    //支付情况
                    self.showOption_finance()


                }
            }


        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if type == .expense_type {
            return CGFloat(50)
        } else {
            return CGFloat(50)
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


    func showOption(indexPath : IndexPath) {
        self.maskView.addSubview(self.optionView)
        self.view.window?.addSubview(self.maskView)
        self.optionView.setData_bank(dataArr: self.dep)
        self.optionView.delegate = self
        self.optionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(200)
        }
    }


    func showOption_finance() {

        self.maskView.addSubview(self.optionView)
        self.view.window?.addSubview(self.maskView)
        self.optionView.setData_finance()

        self.optionView.delegate = self
        self.optionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(200)
        }


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

    func showOptionView_state() {
        self.maskView.addSubview(self.optionView)
        self.view.window?.addSubview(self.maskView)
        self.optionView.setData()

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
        self.optionView.setData_share()
        self.optionView.delegate = self
        self.optionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(200)
        }
    }

    func optionSure(idStr: String, titleStr: String,noteStr : String, pickTag: Int) {
        HCLog(message: titleStr)
        HCLog(message: idStr)
        HCLog(message: pickTag)



        if isHaveSub == 1 && sectionNum > 1 && currectIndexpath.section == 0 {
            let cell : OptionTableViewCell = self.mainTabelView.cellForRow(at: IndexPath(row: 0, section: 0)) as! OptionTableViewCell
            cell.setOptionData(contentStr: titleStr)
            subStr = idStr
            HCLog(message: "分所id\(subStr)")
        } else {
            dStr = idStr
            bidStr = idStr
            HCLog(message: "其余id\(subStr)")
            if type == .Income_list {
                let cell : OptionTableViewCell = self.mainTabelView.cellForRow(at: IndexPath(row: 4, section: sectionNum - 1)) as! OptionTableViewCell
                cell.setOptionData(contentStr: titleStr)
            } else if type == .doc_search {
                let cell : OptionTableViewCell = self.mainTabelView.cellForRow(at: IndexPath(row: 5, section: sectionNum - 1)) as! OptionTableViewCell
                cell.setOptionData(contentStr: titleStr)
            } else if type == .shareType {
                let cell : OptionTableViewCell = self.mainTabelView.cellForRow(at: IndexPath(row: 0, section: sectionNum - 1)) as! OptionTableViewCell
                cell.setOptionData(contentStr: titleStr)
            } else if type == .PayApplylist{

                let cell : OptionTableViewCell = self.mainTabelView.cellForRow(at: IndexPath(row: 4, section: sectionNum - 1)) as! OptionTableViewCell
                cell.setOptionData(contentStr: titleStr)

            } else if type == .Expenseapply{
                //状态
                dStr = idStr
                let cell : OptionTableViewCell = self.mainTabelView.cellForRow(at: IndexPath(row: 1, section: sectionNum - 1)) as! OptionTableViewCell
                cell.setOptionData(contentStr: titleStr)


            } else if type == .departAndPerson{
                let cell : OptionTableViewCell = self.mainTabelView.cellForRow(at: IndexPath(row: 1, section: sectionNum - 1)) as! OptionTableViewCell
                cell.setOptionData(contentStr: titleStr)

            } else if type == .Statistics {
                let cell : OptionTableViewCell = self.mainTabelView.cellForRow(at: IndexPath(row: currectRow, section: sectionNum - 1)) as! OptionTableViewCell
                cell.setOptionData(contentStr: titleStr)
                if currectRow == 1 {
                    //部门
                    bidStr = idStr
                } else {
                    //支付
                    payId = idStr
                }
            } else {
                let cell : OptionTableViewCell = self.mainTabelView.cellForRow(at: IndexPath(row: 0, section: sectionNum - 1)) as! OptionTableViewCell
                cell.setOptionData(contentStr: titleStr)
            }

        }

        self.optionView.removeFromSuperview()
        self.maskView.removeFromSuperview()
    }

    func endEdite(inputStr: String, tagNum: Int) {
        if self.type == .doc_search {
            if tagNum == 0 {
                nStr = inputStr
            } else if tagNum == 1 {
                dnStr = inputStr
            } else if tagNum == 2 {
                kwStr = inputStr
            } else if tagNum == 3 {
                uStr = inputStr
            } else {
                cnStr = inputStr
            }
        } else if type == .dealcheck{

            if tagNum == 0 {
                nStr = inputStr
            } else if tagNum == 3 {
                uStr = inputStr
            } else if tagNum == 4 {
                prStr = inputStr

            }
        } else if type == .PayApplylist{
            if tagNum == 0 {
                nStr = inputStr
            } else if tagNum == 1 {
                prStr = inputStr
            }
        } else if type == .PayCheck{
            if tagNum == 0 {
                nStr = inputStr
            } else if tagNum == 1 {
                prStr = inputStr
            }
        } else if type == .Expenseapply{
            prStr = inputStr
        } else if type == .departAndPerson{
            prStr = inputStr
        } else if type == .Statistics{
            nStr = inputStr
        }
    }

    func requestSucceed_work(data: Any, type: WorkRequestVC_enum) {
        if type == .department {
            //部门
            dep = data as! [departmentModel]
            self.showOption(indexPath: currectIndexpath)

        } else if type == .branch {
            branch = data as! [branchModel]
            self.showOption_branch()
        }
    }

    func requestFail_work() {

    }
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        self.view.endEditing(true)
        if self.type == .expense_type || self.type == .invoice_getlist {
            self.sureStateBlock(self.bidStr)
        } else if self.type == .work_type  {
            if titleCell.textField.isFirstResponder {
                titleCell.textField.resignFirstResponder()
            }
            if persionCell.textField.isFirstResponder {
                persionCell.textField.resignFirstResponder()
            }
            self.sureWorkBlock(subStr,titleCell.conTent,persionCell.contentStr,startTimeStr,endTimeStr)

        } else if self.type == .finance_type || self.type == .Income_list{
            self.view.endEditing(true)
            self.sureFinanceBlock(subStr,titleCell.conTent,persionCell.contentStr,bidStr,startTimeStr,endTimeStr)
            
        } else if self.type == .caselsit_type {

            self.sureCaselsitBlock(subStr,startTimeStr,endTimeStr)

        } else if type == .workbook_type{
            self.sureCaselsitBlock(subStr,startTimeStr,endTimeStr)
        } else if type == .deal_type || type == .person || type == .conven_type {
            if titleCell.textField.isFirstResponder {
                titleCell.textField.resignFirstResponder()
            }
            self.sureDealBlock(subStr,titleCell.conTent)
        } else if type == .departAndPerson{
            if titleCell.textField.isFirstResponder {
                titleCell.textField.resignFirstResponder()
            }
            self.sureBankBlock(self.subStr,titleCell.conTent,self.dStr)
        }  else if type == .shareType{
            self.view.endEditing(true)

            self.sureBankBlock("",titleCell.conTent,self.dStr)

        }  else if type == .doc_search {
            self.view.endEditing(true)

            self.sureDocSearchSure(nStr,dnStr,kwStr,uStr,cnStr,subStr,startTimeStr,endTimeStr)

        } else if type == .deal2_type {
            self.view.endEditing(true)
            self.deal2SureBlock(subStr,titleCell.conTent,startTimeStr,endTimeStr)
        } else if type == .dealcheck {

            dealcheckBlock(subStr,nStr,startTimeStr,endTimeStr,uStr,prStr)
        } else if type == .PayApplylist {
             dealcheckBlock("",nStr,startTimeStr,endTimeStr,bidStr,prStr)
        } else if type == .PayCheck{
            dealcheckBlock(subStr,nStr,startTimeStr,endTimeStr,"",prStr)

        } else if type == .Expenseapply{

            expenBlock(dStr,subStr,prStr)
        } else if type == .departAndPerson {
            sureBankBlock(subStr,prStr,dStr)

        } else if type == .Statistics {
            StatisticsBlock("",nStr,bidStr,startTimeStr,endTimeStr,payId)
        }
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
