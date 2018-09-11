
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
    var dataModel : invoice_getinfoModel!
    var sucessBlock :InvoiceapplyDetailViewControllerBlock!

    let mainTabelView : UITableView = UITableView()
    let requestVC = WorkRequestVC()
    var dealID : Int!

    var optionCell : OptionTableViewCell!
    let sectionNameArr = ["公司名称","社会统一信用代码","发票内容","发票金额",]
    let sectionNameArr2 = ["公司名称","社会统一信用代码","纳税人识别号","地址","电话","银行","账号","发票内容","发票金额","相关附件",]
    let section3NameArr = ["收件人","联系电话","邮编","邮寄地址","付费方式",]


    //    1-审核通过;2-审核驳回
    var stateStr = "1"
    /// 驳回原因
    var nStr = ""


    /// 发票类型,INT 型;0-增值税普通发票;1-增值税专用发票;
    var typeStr : String = "0"

    /// 名称
    var titleStr : String = ""
    /// 社会统一信用代码
    var creditcodeStr : String = ""
    /// 纳税人识别号
    var identifierStr : String = ""
    /// 地址
    var eaddrStr : String = ""
    /// 电话
    var ephoneStr : String = ""
    /// 银行
    var ebankStr : String = ""
    /// 帐号
    var ecardStr : String = ""


    /// 发票内容
    var contentStr : String = ""

    /// 发票金额
    var moneyStr : String = ""


    /// 入帐时间
    var applytimeStr : String = ""

    /// 上门自取时间
    var mtimeStr : String = ""

    /// 收件人
    var nameStr : String = ""

    /// 收件人电话
    var phoneStr : String = ""

    /// 邮编
    var zipStr : String = ""

    /// 收件地址
    var addrStr : String = ""

    /// 备注
    var remarkStr : String = ""


    ///是否已入帐 0-未入帐;1-已入帐
    var isbooksStr = "0"

    /// 送达方式 0-上门自取;1-快递邮寄
    var sendtype = "0"

    /// 快递-付费方式 0-收件人付费;1-律师帐扣
    var paytype = "0"

    /// 第一组 行数
    var section1RowNum = 2

    /// 时间
    let dateView : DatePickView = DatePickView.loadNib()
    var imageArr : [String] = ["","","","",""]


    let section1HeadView = SelectedHeadView.loadNib()
    let section2HeadView = SelectedHeadView.loadNib()
    let section3HeadView = SelectedHeadView.loadNib()


    var section1rows = 4
    var section2rows = 0
    var section3rows = 0

    var isOK : Bool = false




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

        self.mainTabelView.register(UINib.init(nibName: "SelectedTableViewCell", bundle: nil), forCellReuseIdentifier: SelectedTableViewCellID)
        self.mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
        self.mainTabelView.register(UINib.init(nibName: "Title5TableViewCell", bundle: nil), forCellReuseIdentifier: Title5TableViewCellID)
        self.mainTabelView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)
        self.mainTabelView.register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
        self.mainTabelView.register(UINib.init(nibName: "Selected2TableViewCell", bundle: nil), forCellReuseIdentifier: Selected2TableViewCellID)
        self.mainTabelView.register(UINib.init(nibName: "NoticeTableViewCell", bundle: nil), forCellReuseIdentifier: NoticeTableViewCellID)
        self.mainTabelView.register(UINib.init(nibName: "FileTableViewCell", bundle: nil), forCellReuseIdentifier: FileTableViewCellID)
        self.mainTabelView.register(UINib.init(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: ContentTableViewCellID)
        self.view.addSubview(mainTabelView)
    }
    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            if stateStr == "1" {
                return 1
            } else {
                return 2
            }
        } else if section == 1 {
            return section1rows
        } else if section == 2{
            return 0
        } else if section == 3{
            return section2rows
        } else if section == 4 {
            return section3rows
        }   else  if section == 5 {
            return 2
        } else {
            return 1
        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell : SelectedTableViewCell  = tableView.dequeueReusableCell(withIdentifier: SelectedTableViewCellID, for: indexPath) as! SelectedTableViewCell
                    cell.setData_dealcheckdetail(state: stateStr)
                    cell.delegate = self
                return cell
            } else {

                let cell : ContentTableViewCell  = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
                    cell.setData_dealDetail(titleStr: "驳回原因",contentStr : nStr)
                return cell
            }
        } else if indexPath.section == 1 {
            if typeStr == "0" {
                if indexPath.row == 0 {
                    let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell

                    cell.setData_addinvoce(title: sectionNameArr[indexPath.row], content: titleStr,indexPath : indexPath)
                    cell.isUserInteractionEnabled = false
                    return cell
                } else if indexPath.row == 1 {
                    let cell : Title5TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Title5TableViewCellID, for: indexPath) as! Title5TableViewCell

                    cell.setData_overDeal(titleStr: sectionNameArr[indexPath.row], contentStr: creditcodeStr)
                    cell.isUserInteractionEnabled = false

                    return cell
                }else if indexPath.row == 2 {
                    //发票内容
                    optionCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell

                    optionCell.setDataObject(titleStr: sectionNameArr[indexPath.row], contentStr: contentStr)
                    optionCell.isUserInteractionEnabled = false
                    return optionCell
                } else {
                    let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell

                    cell.setData_addinvoce_mon(title: sectionNameArr[indexPath.row], content: moneyStr,indexPath : indexPath)
                    cell.isUserInteractionEnabled = false
                    return cell
                }


            } else {

                if indexPath.row == 1 {
                    let cell : Title5TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Title5TableViewCellID, for: indexPath) as! Title5TableViewCell

                    cell.setData_invoice(title:  sectionNameArr2[indexPath.row], contentStr: creditcodeStr, index: indexPath)
                    cell.isUserInteractionEnabled = false
                    return cell
                }else if indexPath.row == 2 {
                    let cell : Title5TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Title5TableViewCellID, for: indexPath) as! Title5TableViewCell
                    cell.setData_invoice(title:  sectionNameArr2[indexPath.row], contentStr: identifierStr, index: indexPath)

                    cell.isUserInteractionEnabled = false
                    return cell
                } else if indexPath.row == 7 {
                    //发票内容
                    optionCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                    optionCell.setDataObject(titleStr: sectionNameArr2[indexPath.row], contentStr: contentStr)

                    optionCell.isUserInteractionEnabled = false
                    return optionCell

                } else if indexPath.row == 8 {
                    let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell

                    cell.setData_addinvoce_mon(title: sectionNameArr2[indexPath.row], content: moneyStr,indexPath : indexPath)
                    cell.isUserInteractionEnabled = false
                    return cell
                } else if indexPath.row == 9 {
                    let cell : FileTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: FileTableViewCellID, for: indexPath) as! FileTableViewCell
                    cell.isUserInteractionEnabled = false
                    return cell
                } else {
                    let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell

                    var str = ""

                    switch indexPath.row {
                    case 0 :
                        str = titleStr
                    case 3 :
                        str = eaddrStr
                    case 4 :
                        str = ephoneStr
                    case 5 :
                        str = ebankStr
                    case 6 :
                        str = ecardStr


                    default:
                        HCLog(message: "暂无")
                    }
                    cell.setData_addinvoce(title: sectionNameArr2[indexPath.row], content: str,indexPath : indexPath)
                    cell.isUserInteractionEnabled = false
                    return cell
                }
            }


        } else if indexPath.section == 3 {
            //款项是否入账
            let cell : endTimeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
            cell.setData(titleStr: "入账时间", tag: 10)
            cell.setTime(str: applytimeStr)
            cell.isUserInteractionEnabled = false
            return cell

        } else if indexPath.section == 4 {
            //送达方式
            if indexPath.row == 0 {
                //收件人
                let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell

                cell.setData_addinvoce(title: section3NameArr[indexPath.row], content: nameStr,indexPath : indexPath)

                cell.isUserInteractionEnabled = false
                return cell


            } else if indexPath.row == 1 {
                //联系电话
                let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.setData_addinvoce(title: section3NameArr[indexPath.row], content: phoneStr,indexPath : indexPath)

                cell.isUserInteractionEnabled = false
                return cell


            } else if indexPath.row == 2 {
                //邮编
                let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell

                cell.setData_addinvoce(title: section3NameArr[indexPath.row], content: zipStr,indexPath : indexPath)
                cell.isUserInteractionEnabled = false
                return cell

            } else if indexPath.row == 3 {
                //邮寄地址
                let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                                cell.setData_addinvoce(title: section3NameArr[indexPath.row], content: addrStr,indexPath : indexPath)
                cell.isUserInteractionEnabled = false
                return cell

            } else {
                //付费方式
                let cell : Selected2TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Selected2TableViewCellID, for: indexPath) as! Selected2TableViewCell
                cell.setData(title: section3NameArr[indexPath.row], leftStr: "收件人付费", rightStr: "律师账扣", show: 2)
                cell.setSelected(selectedType: paytype)
                cell.isUserInteractionEnabled = false

                return cell
            }

        } else if indexPath.section == 5{
            if indexPath.row == 0 {
                // 收件时间 或者自取时间
                let cell : endTimeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                if sendtype == "0" {
                    cell.setData(titleStr: "自取时间", tag: 1)
                    cell.setTime(str: mtimeStr)


                } else {
                    cell.setData(titleStr: "收件时间", tag: 1)
                    cell.setTime(str: mtimeStr)

                }
                cell.isUserInteractionEnabled = false

                return cell
            } else {
                //备注
                let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.setData_addinvoce(title: "备注", content: remarkStr,indexPath : indexPath)
                cell.isUserInteractionEnabled = false
                return cell
            }

        } else if indexPath.section == 6 {

            //承诺
            let cell : NoticeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: NoticeTableViewCellID, for: indexPath) as! NoticeTableViewCell
            cell.setData(contentStr: "本人承诺于开票日期起一个月内收回款项，逾期未收回的，从其账上直接按发票金额扣减等额款项")
            cell.clickBlock = {isN in
                self.isOK = isN
            }
            cell.setSelcted(isSelected: isOK)
            cell.isUserInteractionEnabled = false
            return cell
        } else {
            let cell : UITableViewCell! = UITableViewCell()
            return cell
        }

    }



    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            //发票类型

            section1HeadView.setSelected(type: typeStr)
            section1HeadView.isUserInteractionEnabled = false
            return section1HeadView
        } else if section == 2 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 20))
            view.backgroundColor = viewBackColor
            return view

        }else if section == 3 {
            //是否入账

            section2HeadView.setBtnTitle_isbook()
            section2HeadView.setSelected(type: isbooksStr)
            section2HeadView.isUserInteractionEnabled = false

            return section2HeadView

        } else if section == 4  {
            //送达方式

            section3HeadView.setBtnTitle_sendtype()

            section3HeadView.setSelected(type: sendtype)
            section3HeadView.isUserInteractionEnabled = false
            return section3HeadView

        } else if section == 5 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 0))
            view.backgroundColor = viewBackColor
            return view
        } else {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 20))
            view.backgroundColor = viewBackColor
            return view

        }

    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if  section == 0 {
            return 0
        } else if section == 1  {
            return 50
        } else if section == 2 {
            return 20
        } else if section == 3 {
            return 50
        } else  if section == 4{
            return 50
        } else if section == 5 {
            return 0
        } else  {
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

        } else if indexPath.section == 1 {

            if typeStr == "0" {
                if indexPath.row == 1  {
                    return Title5TableViewCellH
                } else {
                    return 50
                }
            } else {
                if indexPath.row == 1 || indexPath.row == 2 {
                    return Title5TableViewCellH
                } else {
                    return 50
                }
            }
        } else if indexPath.section == 2 {
            return 0
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


            typeStr = "\(dataModel.type!)"
            if typeStr == "0" {
                //普通
                HCLog(message: "普通")
                section1rows = 4
            } else {
                //增值
                HCLog(message: "增值")
                section1rows = 10
            }

            isbooksStr = "\(dataModel.isbooks!)"
            if isbooksStr == "0" {
                //普通
                HCLog(message: "未入账")
                section2rows = 0
            } else {
                //增值
                HCLog(message: "已入账")
                section2rows = 1
            }

            sendtype = "\(dataModel.sendtype!)"

            if sendtype == "0" {
                //普通
                HCLog(message: "未入账")
                section3rows = 2
            } else {
                //增值
                HCLog(message: "已入账")
                section3rows = 5
            }

            //            if dataModel.paytype.count > 0 {
            paytype = "\(dataModel.paytype)"
            //            }

            titleStr = dataModel.title
            creditcodeStr = dataModel.creditcode
            identifierStr = dataModel.identifier
            eaddrStr = dataModel.eaddr
            ephoneStr = dataModel.ephone
            ebankStr = dataModel.ebank
            ecardStr = dataModel.ecard
            contentStr = dataModel.content
            moneyStr = "\(dataModel.money!)"
            applytimeStr = dataModel.applytime
            mtimeStr = dataModel.mtime
            nameStr = dataModel.name
            phoneStr = dataModel.phone
            zipStr = dataModel.zip
            addrStr = dataModel.addr
            remarkStr = dataModel.remark

            self.mainTabelView.reloadData()
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
