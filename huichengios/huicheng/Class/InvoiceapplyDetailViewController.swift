
//
//  InvoiceapplyDetailViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/8/10.
//  Copyright © 2018年 lvxin. All rights reserved.
//  发票审核

import UIKit
typealias InvoiceapplyDetailViewControllerBlock = ()->()
class InvoiceapplyDetailViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,WorkRequestVCDelegate,SelectedTableViewCellDelegate,ContentTableViewCellDelegate {

    var sucessBlock :InvoiceapplyDetailViewControllerBlock!

    let mainTabelView : UITableView = UITableView()
    let requestVC = WorkRequestVC()
    var dealID : Int!

    //    1-审核通过;2-审核驳回
    var stateStr = "1"
    /// 驳回原因
    var nStr = ""


    /// 数据模型
    var dataModel : invoice_getinfoModel!
    //"纳税人识别号","地址","电话","银行","账号"
    var section1titleArr = ["发票类型","发票抬头","发票内容","发票金额","款项入账","送达方式","自取时间","备注","申请时间"]

    var section2titleArr = ["发票类型","发票抬头","发票内容","发票金额","纳税人识别号","地址","电话","银行","账号","款项入账","送达方式","自取时间","备注","申请时间"]


    


    var sectionContent:[String] = []

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

        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))


        let iteam1 = self.getUIBarButtonItem_title(title: "删除", action: #selector(deleClick), vc: self)
        let iteam2 = self.getUIBarButtonItem_title(title: "保存", action: #selector(saveClick), vc: self)
        self.navigationItem.rightBarButtonItems = [iteam2,iteam1]

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
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if stateStr == "1" {
                return 1
            } else {
                return 2
            }
        } else {
            if let model = dataModel {
                if model.type == 0 {
                    return section1titleArr.count
                } else {
                    return section2titleArr.count
                }
            } else {
                return 0
            }
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
        } else  {
            if let model = dataModel {
                if model.type == 0 {
                    //普通
                    if indexPath.row == 7 {
                        let cell : ContentTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
                        var str = ""
                        if indexPath.row < sectionContent.count {
                            str = sectionContent[indexPath.row]
                        }
                        cell.setData_dealcheckdetail(title: section1titleArr[indexPath.row], contentCase: str)
                        return cell
                    }  else {
                        let cell : Title4TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title4TableViewCellID, for: indexPath) as! Title4TableViewCell
                        var str = ""
                        var titleStr = ""
                        if indexPath.row < sectionContent.count {
                            str = sectionContent[indexPath.row]
                        }
                        if indexPath.row < section1titleArr.count {
                            titleStr = section1titleArr[indexPath.row]
                        }
                        cell.setData_overCase(titleStr: titleStr, contentStr: str)
                        return cell
                    }
                } else {
                    //专用

                    if indexPath.row == 12 {
                        let cell : ContentTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
                        var str = ""
                        if indexPath.row < sectionContent.count {
                            str = sectionContent[indexPath.row]
                        }
                        cell.setData_dealcheckdetail(title: section2titleArr[indexPath.row], contentCase: str)
                        return cell
                    }  else {
                        let cell : Title4TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title4TableViewCellID, for: indexPath) as! Title4TableViewCell
                        var str = ""
                        var titleStr = ""
                        if indexPath.row < sectionContent.count {
                            str = sectionContent[indexPath.row]
                        }
                        if indexPath.row < section2titleArr.count {
                            titleStr = section2titleArr[indexPath.row]
                        }
                        cell.setData_overCase(titleStr: titleStr, contentStr: str)
                        return cell
                    }

                }
            } else {
                let cell : UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: "")
                return cell
            }
        }
    }



    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


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
            label.text = "发票信息"
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
            if let model = dataModel {
                if model.type == 0 {
                    if indexPath.row == 7 {
                        return ContentTableViewCellH
                    } else {
                        return Title4TableViewCellH
                    }


                } else {
                    if indexPath.row == 12 {
                        return ContentTableViewCellH
                    } else {
                        return Title4TableViewCellH
                    }
                }

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
        mainTabelView.reloadSections([0], with: .automatic)

    }

    func endText_content(content: String,tagNum : Int) {
        self.nStr = content
    }

    // MARK: - net
    func requestApi() {
    }


    func requestSucceed_work(data: Any,type : WorkRequestVC_enum) {

        if type == .invoice_getinfo {
            dataModel = data as! invoice_getinfoModel


            if dataModel.type == 0 {
                //0-增值税普通发票
                dataModel = data as!invoice_getinfoModel
                sectionContent.append(dataModel.typeStr)
                sectionContent.append(dataModel.title)
                sectionContent.append(dataModel.content)
                sectionContent.append("\(dataModel.money!)元")
                sectionContent.append(dataModel.isbooksStr)
                sectionContent.append(dataModel.sendtypeStr)
                sectionContent.append(dataModel.mtime)
                sectionContent.append(dataModel.remark)
                sectionContent.append(dataModel.addtime)

            } else {
                //1-增值税专用发票
//                dataModel = data as!invoice_getinfoModel
                sectionContent.append(dataModel.typeStr)
                sectionContent.append(dataModel.title)
                sectionContent.append(dataModel.content)
                sectionContent.append("\(dataModel.money!)元")

                //5个 "纳税人识别号","地址","电话","银行","账号"
                sectionContent.append(dataModel.identifier)
                sectionContent.append(dataModel.eaddr)
                sectionContent.append(dataModel.ephone)
                sectionContent.append(dataModel.ebank)
                sectionContent.append(dataModel.ecard)



                sectionContent.append(dataModel.isbooksStr)
                sectionContent.append(dataModel.sendtypeStr)
                sectionContent.append(dataModel.mtime)
                sectionContent.append(dataModel.remark)
                sectionContent.append(dataModel.addtime)
            }


            self.mainTabelView.reloadData()




        } else if type == .invoice_applysave{
            self.sucessBlock()
            self.navigationLeftBtnClick()
        } else if type == .invoice_del {
            self.sucessBlock()
            self.navigationLeftBtnClick()
        }
    }

    func requestFail_work() {

    }


    @objc func saveClick()  {
        self.view.endEditing(true)
        if stateStr == "2" {
            if !(nStr.count > 0) {
                SVPMessageShow.showErro(infoStr: "请输入驳回原因")
                return
            }
        }
        requestVC.invoice_applysave(id: dealID!, s: stateStr, n: nStr)
    }

    @objc func deleClick() {
        requestVC.invoice_del(id: dealID!)
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
