//
//  CaseCheckDetailViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/5/10.
//  Copyright © 2018年 lvxin. All rights reserved.
//  结案审核详情

import UIKit
typealias CaseCheckDetailViewControllerBlock = ()->()

class CaseCheckDetailViewController: BaseTableViewController,WorkRequestVCDelegate,SelectedTableViewCellDelegate,ContentTableViewCellDelegate  {

    var sucessBlock :CaseCheckDetailViewControllerBlock!

    let mainTabelView : UITableView = UITableView()
    let requestVC = WorkRequestVC()
    var dataArr : [dealGetlistModel] = []
    var dealID : Int!

    //    1-审核通过;2-审核驳回
    var stateStr = "1"
    /// 驳回原因
    var nStr = ""

    /// 委托人意见(纯文本)
    var pnStr = ""

    /// 律所负责人意见(纯文本)
    var rnStr = ""


    /// 数据模型
    var dealModel : getinfoDealModel!

    var section2titleArr = ["合同编号","案件类型","案件名称","案件自述","结案日期","案件组别"]
    var section2Content:[String] = []

    var section3titleArr = ["基本情况","委托人情况"]

    var alertController : UIAlertController!
    // MARK: - life
    override func viewWillLayoutSubviews() {

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor

        self.navigation_title_fontsize(name: "结案审核", fontsize: 18)
        self.navigationBar_rightBtn_title(name: "保存")
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.creatUI()
        requestVC.delegate = self
        requestVC.dealgetoverinfoRequest(id: "\(dealID!)")
    }
    // MARK: - UI
    func creatUI() {
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundView?.backgroundColor = .clear

        tableView.register(UINib.init(nibName: "SelectedTableViewCell", bundle: nil), forCellReuseIdentifier: SelectedTableViewCellID)
        tableView.register(UINib.init(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: ContentTableViewCellID)
        tableView.register(UINib.init(nibName: "Title4TableViewCell", bundle: nil), forCellReuseIdentifier: Title4TableViewCellID)
        tableView.register(UINib.init(nibName: "Title2TableViewCell", bundle: nil), forCellReuseIdentifier: Title2TableViewCellID)

    }
    // MARK: - delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if stateStr == "1" {
                return 1
            } else {
                return 2
            }

        } else if section == 1 {
            return 2
        } else if section == 2 {
            return 6
        } else {
            return 2
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

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
            if indexPath.row == 0 {
                let cell : ContentTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
                cell.delegate = self
                cell.setData_casecheckDetail(title: "委托人意见", contentCase: pnStr, tag: 20)
                return cell
            } else {
                let cell : ContentTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
                cell.delegate = self
                cell.setData_casecheckDetail(title: "律师事务所负责人意见", contentCase: rnStr, tag: 200)
                return cell
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 3 {
                let cell : ContentTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
                var str = ""
                if indexPath.row < section2Content.count {
                    str = section2Content[indexPath.row]
                }
                cell.setData_dealcheckdetail(title: section2titleArr[indexPath.row], contentCase: str)
                return cell

            } else {
                let cell : Title4TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title4TableViewCellID, for: indexPath) as! Title4TableViewCell
                var str = ""
                if indexPath.row < section2Content.count {
                    str = section2Content[indexPath.row]
                }
                cell.setData_overCase(titleStr: section2titleArr[indexPath.row], contentStr: str)
                return cell
            }


        } else {
            let cell : Title2TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title2TableViewCellID, for: indexPath) as! Title2TableViewCell
            cell.setData(titleStr: section3titleArr[indexPath.row])
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            var arr : [String] = []
            var arr2 : [String] = []
            if indexPath.row == 0 {
                HCLog(message: "基本情况")
                let vc = BaseInfoViewController()

                arr.append(dealModel.rStr)
                arr.append(dealModel.rt)
                arr.append(dealModel.w1Str)
                arr.append(dealModel.w2Str)
                arr2.append(dealModel.ct)
                arr2.append(dealModel.sj)

                vc.dataArr = arr
                vc.dataArr2 = arr2

                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                //委托人情况
                let vc = CasePersionViewController()
                vc.type =  .principal_detail
                arr.append(dealModel.pn)
                arr.append(dealModel.pc)
                arr.append(dealModel.pp)
                arr.append(dealModel.pz)
                arr.append(dealModel.pj)
                arr.append(dealModel.pd)
                arr.append(dealModel.pa)
                vc.dataArr = arr
                self.navigationController?.pushViewController(vc, animated: true)
            }

        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            return view
        } else if section == 1 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 40))
            view.backgroundColor = viewBackColor

            let label = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 20))
            view.addSubview(label)
            label.font = hc_fontThin(15)
            label.text = "意见处理"
            label.textColor = UIColor.hc_colorFromRGB(rgbValue: 0x333333)
            return view
        }else if section == 2 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 40))
            view.backgroundColor = viewBackColor

            let label = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 20))
            view.addSubview(label)
            label.font = hc_fontThin(15)
            label.text = "合同信息"
            label.textColor = UIColor.hc_colorFromRGB(rgbValue: 0x333333)
            return view
        }  else {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 20))
            view.backgroundColor = viewBackColor
            return view
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else if section == 1 || section == 2{
            return 40
        } else {
            return 20
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 50

            } else {
                return ContentTableViewCellH
            }
        }  else if indexPath.section == 1 {
            return ContentTableViewCellH
        } else if indexPath.section == 2{
            if indexPath.row == 3 {
                return ContentTableViewCellH
            } else {
                return 50
            }
        } else {
             return 50
        }

    }

    func selectedClickDelegate_type(tag: Int, type: String) {
        HCLog(message: type)
        if type == "0" {
            stateStr = "1"
        } else {
            stateStr = "2"
        }
        tableView.reloadSections([0], with: .automatic)

    }

    func endText_content(content: String,tagNum : Int) {
        if tagNum == 10 {
            self.nStr = content
        } else if tagNum == 20 {
            self.pnStr = content
        } else {
            self.rnStr = content
        }
        
    }

    // MARK: - net
    func requestApi() {
    }


    func requestSucceed_work(data: Any,type : WorkRequestVC_enum) {
        if type == .dealgetoverinfo {
            dealModel = data as! getinfoDealModel
            section2Content.append(dealModel.dealsnum)
            section2Content.append(dealModel.typeStr)
            section2Content.append(dealModel.n)
            section2Content.append(dealModel.ct)
            section2Content.append(dealModel.mt)
            section2Content.append(dealModel.dStr)

            self.tableView.reloadData()
        } else if type == .checkoversave{
            self.sucessBlock()
            self.navigationController?.popViewController(animated: true)
        }
    }

    func requestFail_work() {

    }


    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        HCLog(message: "保存")
        self.view.endEditing(true)
        if !(self.pnStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入委托人意见")
            return
        }
        if !(self.rnStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入律所负责人意见")
            return
        }
        if self.stateStr == "2" {
            if !(self.nStr.count > 0) {
                SVPMessageShow.showErro(infoStr: "请输入驳回意见")
                return
            }
        }

        alertController = UIAlertController(title: nil, message: "确定保存", preferredStyle: .alert)
        let actcion1 = UIAlertAction(title: "确定", style: .default) { (aciton) in
            self.requestVC.checkoversaveRewuest(id: "\(self.dealID!)", s: self.stateStr, n: self.nStr, pn: self.pnStr, rn: self.rnStr)
        }
        let actcion2 = UIAlertAction(title: "取消", style: .cancel) { (aciton) in
            self.alertController.dismiss(animated: true, completion: {

            })
        }
        alertController.addAction(actcion1)
        alertController.addAction(actcion2)
        self.present(alertController, animated: true, completion: nil)

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
