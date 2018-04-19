//
//  CaseDetailViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/4/13.
//  Copyright © 2018年 lvxin. All rights reserved.
//  案件详情--- 修改 删除 添加 生成合同

import UIKit
enum CaseDetailViewControllerType {
    case caseDetail,addCase,editeCase
}
class CaseDetailViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,WorkRequestVCDelegate,TitleTableViewCellDelegate,OptionViewDelgate,DatePickViewDelegate {
    let mainTabelView : UITableView = UITableView()
    let request : WorkRequestVC = WorkRequestVC()
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
    
    /// 当前选中的行
    var currectIndexpath : IndexPath!
    

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
        request.delegate = self
        if self.type == .caseDetail {
            self.navigation_title_fontsize(name: "案件详情", fontsize: 18)
            self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
            self.navigationBar_rightBtn_title(name: "操作")
            request.casegetinfoRerquest(id: caseId)
        } else if self.type == .addCase {
            self.navigation_title_fontsize(name: "案件登记", fontsize: 18)
            self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
            self.navigationBar_rightBtn_title(name: "确定")
            
        } else {

        }
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
        mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "Title2TableViewCell", bundle: nil), forCellReuseIdentifier: Title2TableViewCellID)
        mainTabelView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: ContentTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
        self.view.addSubview(mainTabelView)
    }
    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 7
        } else if section == 1 {
            return 2
        } else {
            return 2
        }

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6 {
                let cell : OptionTableViewCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                let titleStr = name1[indexPath.row]
                var contentStr = ""
                if content1.count > 0 {
                    contentStr = content1[indexPath.row]
                }
                if type == .caseDetail{
                    cell.isUserInteractionEnabled = false
                } else {
                    cell.isUserInteractionEnabled = true
                }
                cell.setData_caseDetail(titleStr: titleStr, contentStr: contentStr)
                return cell
            } else if indexPath.row == 1{
                let cell : TitleTableViewCell  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.delegate = self
                var contentStr = ""
                if content1.count > 0 {
                    contentStr = content1[indexPath.row]
                }
                cell.setData_caseDetail(titleStr: name1[indexPath.row], contentStr: contentStr,indexPath : indexPath)
                cell.tag = indexPath.row
                if type == .caseDetail{
                    cell.isUserInteractionEnabled = false
                } else {
                    cell.isUserInteractionEnabled = true
                }
                return cell
            }  else {
                //结束时间
                let endTimeCell : endTimeTableViewCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                var timeStr = ""
                if content1.count > 0 {
                    timeStr = content1[indexPath.row]
                }
                endTimeCell.setData_case(titleStr: "立案日期", timeStr: timeStr)
                if type == .caseDetail{
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
                var contentStr = ""
                if content3.count > 0 {
                    contentStr = content3[indexPath.row]
                }
                cell.setData_case(title: name3[indexPath.row], contentCase: contentStr)
                if type == .caseDetail{
                    cell.isUserInteractionEnabled = false
                } else {
                    cell.isUserInteractionEnabled = true
                }
                return cell

            } else {
                let cell : TitleTableViewCell  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                var contentStr = ""
                if content3.count > 0 {
                    contentStr = content3[indexPath.row]
                }
                cell.setData_caseDetail(titleStr: name3[indexPath.row], contentStr: contentStr, indexPath: indexPath)
                if type == .caseDetail{
                    cell.isUserInteractionEnabled = false
                } else {
                    cell.isUserInteractionEnabled = true
                }
                return cell
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0  {
            return 0
        } else if section == 1 {
            return 20
        } else {
            return 20
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 20))
        view.backgroundColor = viewBackColor
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currectIndexpath = indexPath

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
        }
    }
    // MARK: - 标题输入代理
    func endEdite(inputStr: String, tagNum: Int) {
        HCLog(message: inputStr)
        HCLog(message: tagNum)
    }

    // MARK: - net
    func caseTypeRequest() {
        
    }
    
    
    
    func requestSucceed_work(data: Any, type: WorkRequestVC_enum) {
        if type == .case_getinfo {
            caseDetailModel = data as! caseDetailModelMap
            //案件类型
            content1.append(caseDetailModel.data.typeStr)
            //名字
            content1.append(caseDetailModel.data.n)
            //时间
            content1.append(caseDetailModel.data.rt)
            //律师
            content1.append(caseDetailModel.data.rStr)
            //组别
            content1.append(caseDetailModel.data.dStr)
            //自述
            content1.append(caseDetailModel.data.ct)
            //标的
            content1.append(caseDetailModel.data.sj)

            content3.append(caseDetailModel.data.ct)
            content3.append(caseDetailModel.data.sj)
            self.mainTabelView.reloadData()
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
            } else if typeNum == 1 {
                HCLog(message: "修改")
            } else {
                HCLog(message: "删除")
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
    func optionSure(idStr: String, titleStr: String, pickTag: Int) {
        HCLog(message: titleStr)
        HCLog(message: idStr)
        HCLog(message: pickTag)
        
        let cell : OptionTableViewCell = self.mainTabelView.cellForRow(at: IndexPath(row: pickTag, section: 0)) as! OptionTableViewCell
        cell.setOptionData(contentStr: titleStr)
        
        self.optionView.removeFromSuperview()
        self.maskView.removeFromSuperview()
        
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
        let cell : endTimeTableViewCell  = self.mainTabelView.cellForRow(at: IndexPath(row: 2, section: 0)) as! endTimeTableViewCell
        cell.setTime(str: timeStr)
        self.dateView.removeFromSuperview()
        self.maskView.removeFromSuperview()
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
