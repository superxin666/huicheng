//
//  CaseDetailViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/4/13.
//  Copyright © 2018年 lvxin. All rights reserved.
//  案件详情--- 修改 删除 添加

import UIKit
enum CaseDetailViewControllerType {
    case caseDetail,addCase,editeCase,crtDetail,searchCseDetail
}
typealias CaseDetailViewControllerBlock = ()->()
class CaseDetailViewController: BaseTableViewController,WorkRequestVCDelegate,TitleTableViewCellDelegate,OptionViewDelgate,DatePickViewDelegate,ContentTableViewCellDelegate {
    let request : WorkRequestVC = WorkRequestVC()
    var successBlock : CaseDetailViewControllerBlock!

    var alertController : UIAlertController!
    let name1 = ["案件类型","案件名称","立案日期","立案律师","案件组别","承办律师","承办律师",]
    var content1 :[String] = []
    let name2 = ["委托人情况","对方当事人情况"]
    var content2 : [String] = []
    let name3 = ["案件自述","标的"]
    var content3 : [String] = []

    /// 详情数据模型
    var caseDetailModel : caseDetailModelMap =  caseDetailModelMap()

    /// 添加案件数据模型
    var addmodel : caseDetailModelMap = caseDetailModelMap()

    /// 案件类型
    var caseTypeArr : [casetypeModel] = []
    /// 律师
    var userList : [userlistModel] = []
    /// 组别
    var dep : [departmentModel] = []


    /// 选项
    let optionView : OptionView = OptionView.loadNib()
    
    /// 时间
    let dateView : DatePickView = DatePickView.loadNib()
    var caseId : Int!
    var type : CaseDetailViewControllerType!

    /// 非诉案件-2  刑事案件-3  法律顾问-4  其他-0
    var caseType : String = "0"

    
    /// 当前选中的行
    var currectIndexpath : IndexPath!

    //-------添加案件参数
    /// 案件类型
    var tStr : String = ""
    var tnameStr : String = ""




    var nStr : String = ""
    var rtStr : String = ""
    var pnStr : String = ""
    var pcStr : String = ""
    var ppStr : String = ""
    var pzStr : String = ""
    var pjStr : String = ""
    var pdStr : String = ""
    var paStr : String = ""
    var onStr : String = ""
    var ocStr : String = ""
    var opStr : String = ""
    var ozStr : String = ""
    var ojStr : String = ""
    var oaStr : String = ""
    var rStr : String = ""
    var rnameStr : String = ""

    var dStr : String = ""
    var dNameStr : String = ""

    var w1Str : String = ""
    var w1NameStr : String =  ""

    var w2Str : String = ""
    var w2NameStr : String =  ""

    var ctStr : String = ""
    var sjStr : String = ""
    

    // MARK: - life
    override func viewWillLayoutSubviews() {
//        mainTabelView.snp.makeConstraints { (make) in
//            make.top.equalTo(self.view).offset(0)
//            make.left.right.equalTo(self.view).offset(0)
//            make.bottom.equalTo(self.view).offset(0)
//        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        request.delegate = self
        if self.type == .caseDetail {
            self.navigation_title_fontsize(name: "案件详情", fontsize: 18)
            self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
            self.navigationBar_rightBtn_title(name: "操作")
            request.casegetinfoRerquest(id: caseId)

        } else if self.type == .searchCseDetail {
            self.navigation_title_fontsize(name: "案件详情", fontsize: 18)
            self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
            request.casegetinfoRerquest(id: caseId)

        } else if self.type == .addCase {
            self.navigation_title_fontsize(name: "案件登记", fontsize: 18)
            self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
            self.navigationBar_rightBtn_title(name: "确定")
            
        } else if self.type == .crtDetail {

            self.navigation_title_fontsize(name: "函件信息", fontsize: 18)
            self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
            self.navigationBar_rightBtn_title(name: "生成")
            request.casegetinfoRerquest(id: caseId)

        } else {

        }
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
        self.tableView .register(UINib.init(nibName: "Title2TableViewCell", bundle: nil), forCellReuseIdentifier: Title2TableViewCellID)
        self.tableView .register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)
        self.tableView .register(UINib.init(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: ContentTableViewCellID)
        self.tableView .register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
    }
    // MARK: - delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 7
        } else if section == 1 {
            if caseType == "2" || caseType == "4"{
                return 1
            } else {
                return 2
            }

        } else {
            if caseType == "2" || caseType == "4"{
                return 1
            } else {
                return 2
            }
        }

    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                //类型
                let cell : OptionTableViewCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                let titleStr = name1[indexPath.row]
                if type == .caseDetail || type == .crtDetail || type == .searchCseDetail{
                    cell.isUserInteractionEnabled = false
                } else {
                    cell.isUserInteractionEnabled = true
                }
                cell.setData_caseDetail(titleStr: titleStr, contentStr: tnameStr)
                return cell
            } else if indexPath.row == 3 {
                //立案律师
                let cell : OptionTableViewCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                let titleStr = name1[indexPath.row]

                if type == .caseDetail || type == .crtDetail || type == .searchCseDetail{
                    cell.isUserInteractionEnabled = false
                } else {
                    cell.isUserInteractionEnabled = true
                }
                cell.setData_caseDetail(titleStr: titleStr, contentStr: rnameStr)
                return cell



            } else if indexPath.row == 4 {
                //案件组别
                let cell : OptionTableViewCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                let titleStr = name1[indexPath.row]

                if type == .caseDetail || type == .crtDetail || type == .searchCseDetail{
                    cell.isUserInteractionEnabled = false
                } else {
                    cell.isUserInteractionEnabled = true
                }
                cell.setData_caseDetail(titleStr: titleStr, contentStr: dNameStr)
                return cell



            } else if indexPath.row == 5 {
                let cell : OptionTableViewCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                let titleStr = name1[indexPath.row]

                if type == .caseDetail || type == .crtDetail || type == .searchCseDetail{
                    cell.isUserInteractionEnabled = false
                } else {
                    cell.isUserInteractionEnabled = true
                }
                cell.setData_caseDetail(titleStr: titleStr, contentStr: w1NameStr)
                return cell

            } else if indexPath.row == 6{
                let cell : OptionTableViewCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                let titleStr = name1[indexPath.row]

                if type == .caseDetail || type == .crtDetail || type == .searchCseDetail{
                    cell.isUserInteractionEnabled = false
                } else {
                    cell.isUserInteractionEnabled = true
                }
                cell.setData_caseDetail(titleStr: titleStr, contentStr: w2NameStr)
                return cell



            } else if indexPath.row == 1{
                let cell : TitleTableViewCell  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.delegate = self


                cell.setData_caseDetail(titleStr: name1[indexPath.row], contentStr: nStr,indexPath : indexPath)
                cell.tag = indexPath.row
                if type == .caseDetail  || type == .crtDetail || type == .searchCseDetail{
                    cell.isUserInteractionEnabled = false
                } else {
                    cell.isUserInteractionEnabled = true
                }
                return cell
            }  else {
                //结束时间
                let endTimeCell : endTimeTableViewCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell

                endTimeCell.setData_case(titleStr: "立案日期", timeStr: rtStr)
                if type == .caseDetail  || type == .crtDetail || type == .searchCseDetail{
                    endTimeCell.isUserInteractionEnabled = false
                } else {
                    endTimeCell.isUserInteractionEnabled = true
                }
                return endTimeCell
            }
        } else if  indexPath.section == 1 {
            let cell : Title2TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title2TableViewCellID, for: indexPath) as! Title2TableViewCell
            cell.setData(titleStr: name2[indexPath.row])
            return cell
        } else {
            if indexPath.row == 0 {
                let cell : ContentTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell

                cell.delegate = self
                cell.setData_case(title: name3[indexPath.row], contentCase: ctStr)
                if type == .caseDetail  || type == .crtDetail || type == .searchCseDetail{
                    cell.isUserInteractionEnabled = false
                } else {
                    cell.isUserInteractionEnabled = true
                }
                return cell

            } else {
                let cell : TitleTableViewCell  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.delegate = self
                cell.setData_caseDetail(titleStr: name3[indexPath.row], contentStr: sjStr, indexPath: indexPath)
                if type == .caseDetail  || type == .crtDetail || type == .searchCseDetail{
                    cell.isUserInteractionEnabled = false
                } else {
                    cell.isUserInteractionEnabled = true
                }
                return cell
            }
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                return ContentTableViewCellH
            } else {
                return 50
            }
        } else {
            return 50
        }

    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0  {
            return 0
        } else if section == 1 {
            return 20
        } else {
            return 20
        }
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 20))
        view.backgroundColor = viewBackColor
        return view
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currectIndexpath = indexPath
        self.view.endEditing(true)

        if indexPath.section == 0 {
            if indexPath.row == 0 {
                //案件类型
                if caseTypeArr.count > 0 {
                    self.showOptionPickView(indexPath: currectIndexpath)
                } else {
                    request.casetypeRequest()
                }
            } else if indexPath.row == 2 {
                //立案日期
                self.showDate()
            } else if indexPath.row == 3 {
                //立案律师
                if userList.count > 0 {
                    self.showOptionPickView(indexPath: currectIndexpath)
                } else {
                    request.userlistRequest()
                }
                
            } else if indexPath.row == 4 {
                //案件组别
                if dep.count > 0 {
                    self.showOptionPickView(indexPath: currectIndexpath)

                } else {
                    request.departmentRequest()
                }
            } else if indexPath.row == 5 {
                //承办律师
                if userList.count > 0 {
                    self.showOptionPickView(indexPath: currectIndexpath)
                } else {
                    request.userlistRequest()
                }

            } else {
                //承办律师
                if userList.count > 0 {
                    self.showOptionPickView(indexPath: currectIndexpath)
                } else {
                    request.userlistRequest()
                }

            }

        } else if indexPath.section == 1 {
            let vc = CasePersionViewController()
            vc.caseType = caseType
            if self.type == .caseDetail || self.type == .searchCseDetail{
                var arr : [String] = []
                if indexPath.row == 0 {
                    vc.type =  .principal_detail
                    arr.append(caseDetailModel.data.pn)
                    arr.append(caseDetailModel.data.pc)
                    arr.append(caseDetailModel.data.pp)
                    arr.append(caseDetailModel.data.pz)
                    arr.append(caseDetailModel.data.pj)
                    arr.append(caseDetailModel.data.pd)
                    arr.append(caseDetailModel.data.pa)
                } else {
                    vc.type =  .opposite_detail
                    arr.append(caseDetailModel.data.on)
                    arr.append(caseDetailModel.data.oc)
                    arr.append(caseDetailModel.data.op)
                    arr.append(caseDetailModel.data.oz)
                    arr.append(caseDetailModel.data.oj)
                    arr.append(caseDetailModel.data.oa)
                }
                vc.dataArr = arr
                self.navigationController?.pushViewController(vc, animated: true)

            } else {
                weak var weekself = self
                if indexPath.row == 0 {
                    vc.type = . principal_add
                    vc.pnStr = self.pnStr
                    vc.pcStr = self.pcStr
                    vc.ppStr = self.ppStr
                    vc.pzStr = self.pzStr
                    vc.pjStr = self.pjStr
                    vc.pdStr = self.pdStr
                    vc.paStr = self.paStr
                    vc.sureBlock = {(pn:String,pc:String, pp:String, pz:String, pj:String, pd:String,  pa:String) in
                        weekself?.pnStr = pn
                        weekself?.pcStr = pc
                        weekself?.ppStr = pp
                        weekself?.pzStr = pz
                        weekself?.pjStr = pj
                        weekself?.pdStr = pd
                        weekself?.paStr = pa

                    }
                } else {
                    vc.type = . opposit_add
                    vc.pnStr = self.onStr
                    vc.pcStr = self.ocStr
                    vc.ppStr = self.opStr
                    vc.pzStr = self.ozStr
                    vc.pjStr = self.ojStr
                    vc.paStr = self.oaStr
                    vc.sureBlock = {(pn:String,pc:String, pp:String, pz:String, pj:String, pd:String,  pa:String) in
                        weekself?.onStr = pn
                        weekself?.ocStr = pc
                        weekself?.opStr = pp
                        weekself?.ozStr = pz
                        weekself?.ojStr = pj
                        weekself?.oaStr = pa

                    }
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    // MARK: - 标题输入代理
    func endEdite(inputStr: String, tagNum: Int) {
        HCLog(message: inputStr)
        HCLog(message: tagNum)
        if tagNum == 1 {
            //名字
            self.nStr = inputStr
        } else {
            //标的
            self.sjStr = inputStr
        }
    }
    func endText_content(content: String,tagNum : Int) {
        self.ctStr = content
    }

    // MARK: - net

    /// 添加案件
    func caseAddRequest() {
        //全部必填
        if !(self.tStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入案件名称")
            return
        }
        if caseType == "3" {
            if !(self.pdStr.count > 0) {
                SVPMessageShow.showErro(infoStr: "请输入委托方身份证号")
                return
            }
        }
    
        SVPMessageShow.showLoad(title: "正在发布")
        request.caseAdd(t: tStr, n: nStr, rt: rtStr, pn: pnStr, pc: pcStr, pp: ppStr, pz: pzStr, pj: pjStr, pd: pdStr, pa: paStr, on: onStr, oc: ocStr, op: opStr, oz: ozStr, oj: ojStr, oa: oaStr, r: rStr, d: dStr, w1: w1Str, w2: w2Str, ct: ctStr, sj: sjStr, id: "")
    }


    func editeRequest() {
        request.caseAdd(t: tStr, n: nStr, rt: rtStr, pn: pnStr, pc: pcStr, pp: ppStr, pz: pzStr, pj: pjStr, pd: pdStr, pa: paStr, on: onStr, oc: ocStr, op: opStr, oz: ozStr, oj: ojStr, oa: oaStr, r: rStr, d: dStr, w1: w1Str, w2: w2Str, ct: ctStr, sj: sjStr, id: "\(caseId!)")
    }
    
    
    
    func requestSucceed_work(data: Any, type: WorkRequestVC_enum) {
        if type == .case_getinfo {
            caseDetailModel = data as! caseDetailModelMap
            //案件类型
//            content1.append(caseDetailModel.data.typeStr)
            HCLog(message: caseDetailModel.data.typeStr)

            HCLog(message: caseDetailModel.data.type)


//            //名字
//            content1.append(caseDetailModel.data.n)
//
//            //时间
//            content1.append(caseDetailModel.data.rt)
//
//            //律师
//            content1.append(caseDetailModel.data.rStr)
//
//            //组别
//            content1.append(caseDetailModel.data.dStr)
//
//
//            content1.append(caseDetailModel.data.w1Str)
//
//
//            content1.append(caseDetailModel.data.w2Str)

            caseType = "\(caseDetailModel.data.type!)"


            //案件名称
            self.nStr = self.caseDetailModel.data.n
            //立案时间
            self.rtStr = self.caseDetailModel.data.rt
            //案件类型
            self.tStr = "\(self.caseDetailModel.data.type!)"
            self.tnameStr = self.caseDetailModel.data.typeStr


            //案件组别
            if let str = self.caseDetailModel.data.d {
                self.dStr = "\(str)"
            }
            self.dNameStr = self.caseDetailModel.data.dStr

            //立案律师
            if let str = self.caseDetailModel.data.r {
                self.rStr = "\(str)"
            }
            rnameStr = self.caseDetailModel.data.rStr



            //承办律师1
            if let str = self.caseDetailModel.data.w1 {
                self.w1Str = "\(str)"
            }
            self.w1NameStr = self.caseDetailModel.data.w1Str

            //承办律师2
            if let str = self.caseDetailModel.data.w2 {
                self.w2Str = "\(str)"
            }
            self.w2NameStr = self.caseDetailModel.data.w2Str



            self.ctStr = self.caseDetailModel.data.ct
            self.sjStr = self.caseDetailModel.data.sj



//             自述
//            content3.append(caseDetailModel.data.ct)
//            //标的
//            content3.append(caseDetailModel.data.sj)

            self.tableView.reloadData()
        } else if type == .casetype {
            //案件类型
            caseTypeArr = data as! [casetypeModel]
            self.showOptionPickView(indexPath: currectIndexpath)
        } else if type == .userlist {
            //律师
           userList = data as! [userlistModel]
           self.showOptionPickView(indexPath: currectIndexpath)

        } else if type == .department {
            //部门
            dep = data as! [departmentModel]
            self.showOptionPickView(indexPath: currectIndexpath)

        } else if type == .case_add{
            //添加案件
            SVPMessageShow.dismissSVP()
            if self.type == .editeCase {
                self.successBlock()
            }
            self.navigationController?.popViewController(animated: true)
        } else if type == .casedel{
            self.successBlock()
            self.navigationController?.popViewController(animated: true)
        }

    }
    func requestFail_work() {

    }

    // MARK: 事件点击
    override func navigationRightBtnClick() {
        if self.type == .caseDetail {
            HCLog(message: "操作")
            alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let actcion1 = UIAlertAction(title: "生成合同", style: .default) { (aciton) in
                self.showAlert(typeNum: 0)
            }
            let actcion2 = UIAlertAction(title: "修改", style: .default) { (aciton) in
                self.showAlert(typeNum: 1)
            }
            let actcion3 = UIAlertAction(title: "删除", style: .default) { (aciton) in
                self.showAlert(typeNum: 2)
            }
            let actcion4 = UIAlertAction(title: "取消", style: .cancel) { (aciton) in
                self.alertController.dismiss(animated: true, completion: {

                })

            }
            alertController.addAction(actcion1)
            alertController.addAction(actcion2)
            alertController.addAction(actcion3)
            alertController.addAction(actcion4)
            self.present(alertController, animated: true, completion: nil)
        } else if self.type == .addCase{
            HCLog(message: "添加案件")
            self.view.endEditing(true)
            self.caseAddRequest()
        } else if self.type == .editeCase{
            HCLog(message: "修改案件")
            self.view.endEditing(true)
            self.editeRequest()
        } else if self.type == .crtDetail {
            HCLog(message: "生成")
            let vc : CrtChooseViewController = CrtChooseViewController()
            vc.hidesBottomBarWhenPushed = true
            vc.id = self.caseId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }


    func showAlert(typeNum : Int) {
        var titleStr = ""

        if typeNum == 0 {
            titleStr = "是否确定生成合同"
        } else if typeNum == 1 {
            titleStr = "是否确定修改本条记录"
        } else {
            titleStr = "是否确定删除本条记录"
        }
        alertController = UIAlertController(title: nil, message: titleStr, preferredStyle: .alert)
        let actcion1 = UIAlertAction(title: "确定", style: .default) { (aciton) in
            if typeNum == 0 {
                HCLog(message: "生成")
                let vc = OverDealViewController()
                vc.dealId = self.caseId
                vc.dealNum = self.caseDetailModel.data.dealnum
                vc.caseType = "\(self.caseDetailModel.data.type!)"
                self.navigationController?.pushViewController(vc, animated: true)


            } else if typeNum == 1 {
                HCLog(message: "修改")
                self.navigationBar_rightBtn_title(name: "确定")
                self.type = .editeCase


                self.pnStr = self.caseDetailModel.data.pn
                self.pcStr = self.caseDetailModel.data.pc
                self.ppStr = self.caseDetailModel.data.pp
                self.pzStr = self.caseDetailModel.data.pz
                self.pjStr = self.caseDetailModel.data.pj
                self.pdStr = self.caseDetailModel.data.pd
                self.paStr = self.caseDetailModel.data.pa


                self.onStr = self.caseDetailModel.data.on
                self.ocStr = self.caseDetailModel.data.oc
                self.opStr = self.caseDetailModel.data.op
                self.ozStr = self.caseDetailModel.data.oz
                self.ojStr = self.caseDetailModel.data.oj
                self.oaStr = self.caseDetailModel.data.oa

                self.tableView.reloadData()
            } else {
                HCLog(message: "删除")
                self.request.casedelRequest(id: self.caseId)
            }
        }
        let actcion2 = UIAlertAction(title: "取消", style: .cancel) { (aciton) in
            self.alertController.dismiss(animated: true, completion: {

            })
        }
        alertController.addAction(actcion1)
        alertController.addAction(actcion2)
        self.present(alertController, animated: true, completion: nil)

    }


    func showOptionPickView(indexPath : IndexPath) {

        HCLog(message: indexPath.row)


        self.maskView.addSubview(self.optionView)
        self.view.window?.addSubview(self.maskView)
        if indexPath.row == 0 {
            self.optionView.setData_case(dataArr: self.caseTypeArr, indexPath: indexPath)
        } else if indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 6 {
            self.optionView.setData_case(dataArr: self.userList, indexPath: indexPath)
        } else if indexPath.row == 4 {
            self.optionView.setData_case(dataArr: self.dep, indexPath: indexPath)

        }
        self.optionView.delegate = self
        
        self.optionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(160)
        }
    }
    
    
    /// 选项代理
    ///
    /// - Parameters:
    ///   - idStr: <#idStr description#>
    ///   - titleStr: <#titleStr description#>
    ///   - pickTag: <#pickTag description#>
    func optionSure(idStr: String, titleStr: String,noteStr : String, pickTag: Int) {
        HCLog(message: titleStr)
        HCLog(message: idStr)
        HCLog(message: pickTag)

        if pickTag == 0 {
            //非诉案件-2  刑事案件-3  法律顾问-4

            //类型
            caseType = idStr
            self.tStr = idStr
            self.tnameStr = titleStr
        } else if pickTag == 3 {
            //立案律师
            self.rStr = idStr
            self.rnameStr = titleStr
        } else if pickTag == 4 {
            //案件
            self.dStr = idStr
            self.dNameStr = titleStr
        } else if pickTag == 5 {
            //承办律师
            self.w1Str = idStr
            self.w1NameStr = titleStr
        } else {
            //承办律师
            self.w2Str = idStr
            self.w2NameStr = titleStr
        }
//        let cell : OptionTableViewCell = self.tableView.cellForRow(at: IndexPath(row: pickTag, section: 0)) as! OptionTableViewCell
//        cell.setOptionData(contentStr: titleStr)

        self.optionView.removeFromSuperview()
        self.maskView.removeFromSuperview()

        self.tableView.reloadData()
        
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

    override func navigationLeftBtnClick() {
        if self.type == .addCase {
            alertController = UIAlertController(title: nil, message: "是否放弃本次记录", preferredStyle: .alert)
            let actcion1 = UIAlertAction(title: "确定", style: .default) { (aciton) in
                self.navigationController?.popViewController(animated: true)
            }
            let actcion2 = UIAlertAction(title: "取消", style: .cancel) { (aciton) in
                self.alertController.dismiss(animated: true, completion: {

                })
            }
            alertController.addAction(actcion1)
            alertController.addAction(actcion2)
            self.present(alertController, animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }


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
