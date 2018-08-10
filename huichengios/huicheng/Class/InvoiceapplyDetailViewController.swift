
//
//  InvoiceapplyDetailViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/8/10.
//  Copyright © 2018年 lvxin. All rights reserved.
//  发票审核

import UIKit

class InvoiceapplyDetailViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,WorkRequestVCDelegate,SelectedTableViewCellDelegate,ContentTableViewCellDelegate {

    var sucessBlock :DealCheckDetailViewControllerBlock!

    let mainTabelView : UITableView = UITableView()
    let requestVC = WorkRequestVC()
    var dataArr : [dealGetlistModel] = []
    var dealID : Int!

    //    1-审核通过;2-审核驳回
    var stateStr = "1"
    /// 驳回原因
    var nStr = ""


    /// 数据模型
    var dealModel : getinfoDealModel!

    var section1titleArr = ["合同编号","合同有效期","合同总款","发票情况","发票内容","案件类型","案件名称","案件自述","合同扫描件"]
    var sectionContent:[String] = []
    var section2titleArr = ["基本情况","委托人情况"]

    var alertController : UIAlertController!
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

        self.navigation_title_fontsize(name: "发票审核", fontsize: 18)
        self.navigationBar_rightBtn_title(name: "保存")
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.creatUI()
        requestVC.delegate = self
        requestVC.invoice_getinfoRequest(id: dealID)
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

        mainTabelView.register(UINib.init(nibName: "SelectedTableViewCell", bundle: nil), forCellReuseIdentifier: SelectedTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: ContentTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "Title4TableViewCell", bundle: nil), forCellReuseIdentifier: Title4TableViewCellID)
        mainTabelView.register(UINib.init(nibName: "Title2TableViewCell", bundle: nil), forCellReuseIdentifier: Title2TableViewCellID)
        self.view.addSubview(mainTabelView)
    }
    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if stateStr == "1" {
                return 1
            } else {
                return 2
            }

        } else if section == 1 {
            return 9
        } else {
            return 2
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell : SelectedTableViewCell  = tableView.dequeueReusableCell(withIdentifier: SelectedTableViewCellID, for: indexPath) as! SelectedTableViewCell
                cell.delegate = self
                cell.setData_dealcheckdetail(state: stateStr)
                return cell
            } else {

                let cell : ContentTableViewCell  = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
                cell.delegate = self
                cell.setData_dealDetail(titleStr: "驳回原因",contentStr : nStr)
                return cell
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 7 {

                let cell : ContentTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
                var str = ""
                if indexPath.row < sectionContent.count {
                    str = sectionContent[indexPath.row]
                }
                cell.setData_dealcheckdetail(title: section1titleArr[indexPath.row], contentCase: str)
                return cell

            } else if indexPath.row == 8 {
                let cell : Title2TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title2TableViewCellID, for: indexPath) as! Title2TableViewCell
                cell.setData(titleStr: section1titleArr[indexPath.row])
                return cell
            } else {
                let cell : Title4TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title4TableViewCellID, for: indexPath) as! Title4TableViewCell
                var str = ""
                if indexPath.row < sectionContent.count {
                    str = sectionContent[indexPath.row]
                }
                cell.setData_overCase(titleStr: section1titleArr[indexPath.row], contentStr: str)
                return cell
            }
        } else {
            let cell : Title2TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title2TableViewCellID, for: indexPath) as! Title2TableViewCell
            cell.setData(titleStr: section2titleArr[indexPath.row])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
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

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            return view
        } else if section == 1 {
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

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else if section == 1 {
            return 40
        } else {
            return 20
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                return ContentTableViewCellH
            } else {
                return 50
            }
        }  else if indexPath.section == 1 {
            if indexPath.row == 7 {
                return ContentTableViewCellH
            } else {
                return Title4TableViewCellH
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
        mainTabelView.reloadSections([0], with: .automatic)

    }

    func endText_content(content: String,tagNum : Int) {
        self.nStr = content
    }

    // MARK: - net
    func requestApi() {
    }


    func requestSucceed_work(data: Any,type : WorkRequestVC_enum) {
        if type == .getinfo {
            dealModel = data as! getinfoDealModel
            sectionContent.append(dealModel.dealsnum)
            sectionContent.append("\(dealModel.begintime!)~\(dealModel.endtime!)")
            sectionContent.append(dealModel.amount)
            sectionContent.append(dealModel.ispaperStr)
            sectionContent.append("")
            sectionContent.append(dealModel.typeStr)
            sectionContent.append(dealModel.n)
            sectionContent.append(dealModel.ct)

            self.mainTabelView.reloadData()
        } else {
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
        if self.stateStr == "2" {
            if !(self.nStr.count > 0){
                SVPMessageShow.showErro(infoStr: "请输入驳回原因")
                return
            }
        }
        alertController = UIAlertController(title: nil, message: "确定保存", preferredStyle: .alert)
        let actcion1 = UIAlertAction(title: "确定", style: .default) { (aciton) in
            self.requestVC.applysaveRequest(id: "\(self.dealID!)", s: self.stateStr, n: self.nStr)
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
