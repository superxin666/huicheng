//
//  AddInvoiceViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/31.
//  Copyright © 2018年 lvxin. All rights reserved.
//  添加发票

import UIKit
typealias AddInvoiceViewControllerBlock = ()->()
enum AddInvoiceViewControllerType {
    case detial,add,edite
}

class AddInvoiceViewController: BaseTableViewController,MineRequestVCDelegate,TitleTableViewCellDelegate,Selected2TableViewCellDelegate,Title5TableViewCellDelegate,DatePickViewDelegate,SelectedHeadViewDelegate,OptionViewDelgate {

    let requestVC = MineRequestVC()
    var sucessBlock : AddInvoiceViewControllerBlock!

    var viewType : AddInvoiceViewControllerType = .detial
    var dataModel : invoice_getinfoModel!
    var id  : Int!

    /// 选项
    let optionView : OptionView = OptionView.loadNib()

    var optionCell : OptionTableViewCell!


    var userList : [expense_gettypeModel] = []

    let sectionNameArr = ["公司名称","社会统一信用代码","发票内容","发票金额",]
    let sectionNameArr2 = ["公司名称","社会统一信用代码","纳税人识别号","地址","电话","银行","账号","发票内容","发票金额","相关附件",]
    let section3NameArr = ["收件人","联系电话","邮编","邮寄地址","付费方式",]




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




    // MARK: - life
    override func viewWillLayoutSubviews() {

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        requestVC.delegate  = self
        self.navigation_title_fontsize(name: "发票申请", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))

        //默认 未入账  上门自取
        if viewType == .add {
            self.navigationBar_rightBtn_title(name: "确定")
        } else if viewType == .detial {
            requestVC.delegate = self
            requestVC.invoice_getinfoRequest(id: id!)
        }
        self.creatUI()



    }
    // MARK: - UI
    func creatUI() {
        self.tableView.backgroundColor = viewBackColor
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.backgroundView?.backgroundColor = .clear
        self.tableView.register(UINib.init(nibName: "SelectedTableViewCell", bundle: nil), forCellReuseIdentifier: SelectedTableViewCellID)
        self.tableView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
        self.tableView.register(UINib.init(nibName: "Title5TableViewCell", bundle: nil), forCellReuseIdentifier: Title5TableViewCellID)
        self.tableView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)
        self.tableView.register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
        self.tableView.register(UINib.init(nibName: "Selected2TableViewCell", bundle: nil), forCellReuseIdentifier: Selected2TableViewCellID)
        self.tableView.register(UINib.init(nibName: "NoticeTableViewCell", bundle: nil), forCellReuseIdentifier: NoticeTableViewCellID)
        self.tableView.register(UINib.init(nibName: "FileTableViewCell", bundle: nil), forCellReuseIdentifier: FileTableViewCellID)



    }
    // MARK: - delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return section1rows
        } else if section == 1 {
            return 0
        } else if section == 2{
            return section2rows
        } else if section == 3{
            return section3rows
        } else if section == 4 {
            return 2
        }   else  {
            return 1
        }

    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if typeStr == "0" {
                if indexPath.row == 0 {
                    let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    cell.delegate = self
                    cell.setData_addinvoce(title: sectionNameArr[indexPath.row], content: titleStr,indexPath : indexPath)
                    if viewType == .detial {
                        cell.isUserInteractionEnabled = false
                    } else {
                        cell.isUserInteractionEnabled = true
                    }

                    return cell
                } else if indexPath.row == 1 {
                    let cell : Title5TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Title5TableViewCellID, for: indexPath) as! Title5TableViewCell
                    cell.delegate = self
                    cell.setData_overDeal(titleStr: sectionNameArr[indexPath.row], contentStr: creditcodeStr)
                    if viewType == .detial {
                        cell.isUserInteractionEnabled = false
                    } else {
                        cell.isUserInteractionEnabled = true
                    }


                    return cell
                }else if indexPath.row == 2 {
                    //发票内容
                    optionCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell

                    optionCell.setDataObject(titleStr: sectionNameArr[indexPath.row], contentStr: contentStr)
                    if viewType == .detial {
                        optionCell.isUserInteractionEnabled = false
                    } else {
                        optionCell.isUserInteractionEnabled = true
                    }

                    return optionCell
                } else {
                    let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    cell.delegate = self
                    cell.setData_addinvoce_mon(title: sectionNameArr[indexPath.row], content: moneyStr,indexPath : indexPath)
                    if viewType == .detial {
                        cell.isUserInteractionEnabled = false
                    } else {
                        cell.isUserInteractionEnabled = true
                    }

                    return cell
                }


            } else {

                if indexPath.row == 1 {
                    let cell : Title5TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Title5TableViewCellID, for: indexPath) as! Title5TableViewCell
                    cell.delegate = self
                    cell.setData_invoice(title:  sectionNameArr2[indexPath.row], contentStr: creditcodeStr, index: indexPath)
                    
                    if viewType == .detial {
                        cell.isUserInteractionEnabled = false
                    } else {
                        cell.isUserInteractionEnabled = true
                    }

                    return cell
                }else if indexPath.row == 2 {
                    let cell : Title5TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Title5TableViewCellID, for: indexPath) as! Title5TableViewCell
                    cell.setData_invoice(title:  sectionNameArr2[indexPath.row], contentStr: identifierStr, index: indexPath)
                    cell.delegate = self
                    if viewType == .detial {
                        cell.isUserInteractionEnabled = false
                    } else {
                        cell.isUserInteractionEnabled = true
                    }

                    return cell
                } else if indexPath.row == 7 {
                    //发票内容
                    optionCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                    optionCell.setDataObject(titleStr: sectionNameArr2[indexPath.row], contentStr: contentStr)

                    if viewType == .detial {
                        optionCell.isUserInteractionEnabled = false
                    } else {
                        optionCell.isUserInteractionEnabled = true
                    }
                    return optionCell

                } else if indexPath.row == 8 {
                    let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    cell.delegate = self
                    cell.setData_addinvoce_mon(title: sectionNameArr2[indexPath.row], content: moneyStr,indexPath : indexPath)
                    if viewType == .detial {
                        cell.isUserInteractionEnabled = false
                    } else {
                        cell.isUserInteractionEnabled = true
                    }

                    return cell
                } else if indexPath.row == 9 {
                    let cell : FileTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: FileTableViewCellID, for: indexPath) as! FileTableViewCell
                    if viewType == .detial {
                        cell.isUserInteractionEnabled = false
                    } else {
                        cell.isUserInteractionEnabled = true
                    }

                    return cell
                } else {
                    let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    cell.delegate = self
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
                    if viewType == .detial {
                        cell.isUserInteractionEnabled = false
                    } else {
                        cell.isUserInteractionEnabled = true
                    }

                    return cell
                }
            }
        } else if indexPath.section == 2 {
            //款项是否入账
            let cell : endTimeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
            cell.setData(titleStr: "入账时间", tag: 10)
            cell.setTime(str: applytimeStr)
            if viewType == .detial {
                cell.isUserInteractionEnabled = false
            } else {
                cell.isUserInteractionEnabled = true
            }
            return cell
        } else if indexPath.section == 3 {
            //送达方式
            if indexPath.row == 0 {
                //收件人
                let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.delegate = self
                cell.setData_addinvoce(title: section3NameArr[indexPath.row], content: nameStr,indexPath : indexPath)
                if viewType == .detial {
                    cell.isUserInteractionEnabled = false
                } else {
                    cell.isUserInteractionEnabled = true
                }
                return cell


            } else if indexPath.row == 1 {
                //联系电话
                let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.delegate = self
                cell.setData_addinvoce(title: section3NameArr[indexPath.row], content: phoneStr,indexPath : indexPath)
                if viewType == .detial {
                    cell.isUserInteractionEnabled = false
                } else {
                    cell.isUserInteractionEnabled = true
                }
                return cell


            } else if indexPath.row == 2 {
                //邮编
                let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.delegate = self
                cell.setData_addinvoce(title: section3NameArr[indexPath.row], content: zipStr,indexPath : indexPath)
                if viewType == .detial {
                    cell.isUserInteractionEnabled = false
                } else {
                    cell.isUserInteractionEnabled = true
                }
                return cell

            } else if indexPath.row == 3 {
                //邮寄地址
                let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.delegate = self
                cell.setData_addinvoce(title: section3NameArr[indexPath.row], content: addrStr,indexPath : indexPath)
                if viewType == .detial {
                    cell.isUserInteractionEnabled = false
                } else {
                    cell.isUserInteractionEnabled = true
                }
                return cell

            } else {
                //付费方式
                let cell : Selected2TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Selected2TableViewCellID, for: indexPath) as! Selected2TableViewCell
                cell.delegate = self
                cell.setData(title: section3NameArr[indexPath.row], leftStr: "收件人付费", rightStr: "律师账扣", show: 2)
                cell.setSelected(selectedType: paytype)
                if viewType == .detial {
                    cell.isUserInteractionEnabled = false
                } else {
                    cell.isUserInteractionEnabled = true
                }
                return cell
            }
        } else if indexPath.section == 4 {
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
                if viewType == .detial {
                    cell.isUserInteractionEnabled = false
                } else {
                    cell.isUserInteractionEnabled = true
                }
                return cell
            } else {
                //备注
                let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.delegate = self
                cell.setData_addinvoce(title: "备注", content: remarkStr,indexPath : indexPath)
                if viewType == .detial {
                    cell.isUserInteractionEnabled = false
                } else {
                    cell.isUserInteractionEnabled = true
                }
                return cell
            }
        } else if indexPath.section == 5 {
            //承诺
            let cell : NoticeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: NoticeTableViewCellID, for: indexPath) as! NoticeTableViewCell
            cell.setData(contentStr: "本人承诺于开票日期起一个月内收回款项，逾期未收回的，从其账上直接按发票金额扣减等额款项")
            cell.clickBlock = {isN in
                self.isOK = isN
            }
            cell.setSelcted(isSelected: isOK)
            if viewType == .detial {
                cell.isUserInteractionEnabled = false
                self.isOK  = true
                cell.setSelcted(isSelected: true)
            }
            if viewType == .detial {
                cell.isUserInteractionEnabled = false
            } else {
                cell.isUserInteractionEnabled = true
            }
            return cell
        } else {
            let cell : UITableViewCell! = UITableViewCell()
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)

        if indexPath.section == 0 {
            if typeStr == "1" {
                if indexPath.row == 9 {
                    HCLog(message: "选择文件")
                    let vc = SelectedImagesViewController()
                    vc.hidesBottomBarWhenPushed = true

                    vc.sureBlock = {(arr : [String])in
                        HCLog(message: arr.count)
                        
                        self.imageArr = arr
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                } else if indexPath.row == 7 {
                    HCLog(message: "发票内容")
                    self.invoce_infoClick()
                }
            } else {
                if indexPath.row == 2 {
                    HCLog(message: "发票内容2")
                    self.invoce_infoClick()
                }
            }
        } else if  indexPath.section == 2 {
            if indexPath.row == 0 {
                //入账时间
                dateView.setData(type: 20)
                self.showDate()

            }

        } else if indexPath.section == 3{
            //送达方式


        } else if indexPath.section == 4 {
            if sendtype == "0" {
                //自取时间
                dateView.setData(type: 30)
                self.showDate()
            } else {
                //收件时间
                dateView.setData(type: 40)
                self.showDate()
            }

        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {

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
        } else if indexPath.section == 1 {
            return 0
        } else {
            return 50
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            //发票类型
            section1HeadView.delegate = self
            if viewType == .detial {
                section1HeadView.setSelected(type: typeStr)
                section1HeadView.isUserInteractionEnabled = false
            } else {
                section1HeadView.isUserInteractionEnabled = true
            }
            return section1HeadView
        } else if section == 1 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 20))
            view.backgroundColor = viewBackColor
            return view

        }else if section == 2 {
            //是否入账
            section2HeadView.delegate = self
            section2HeadView.setBtnTitle_isbook()

            if viewType == .detial {
                section2HeadView.setSelected(type: isbooksStr)
                section2HeadView.isUserInteractionEnabled = false
            } else {
                section2HeadView.isUserInteractionEnabled = true
            }
            return section2HeadView

        } else if section == 3  {
            //送达方式
            section3HeadView.delegate = self
            section3HeadView.setBtnTitle_sendtype()
            if viewType == .detial {
                section3HeadView.setSelected(type: sendtype)
                section3HeadView.isUserInteractionEnabled = false
            } else {
                section3HeadView.isUserInteractionEnabled = true
            }
            return section3HeadView

        } else if section == 4 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 0))
            view.backgroundColor = viewBackColor
            return view
        } else {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 20))
            view.backgroundColor = viewBackColor
            return view

        }
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }



    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0  {
            return 50
        } else if section == 1 {
            return 20
        } else if section == 2 {
            return 50
        } else  if section == 3{
            return 50
        } else if section == 4 {
            return 0
        } else  {
            return 20
        }
    }

    func getCell(row : Int) {


    }
    // MARK: - net
    func requestFail_mine() {

    }
    func requestSucceed_mine(data: Any, type: MineRequestVC_enum) {
        if type == .invoice_save {
            self.sucessBlock()
            self.navigationController?.popViewController(animated: true)
        } else if type == .invoice_getinfo {
            dataModel = data as! invoice_getinfoModel
            HCLog(message: dataModel.type)

            if dataModel.type == 0 {
                section1HeadView.lastBtn = section1HeadView.leftBtn

            } else {
                section1HeadView.lastBtn = section1HeadView.rightBtn

            }


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

            if dataModel.state == 1 {
                //已审核不能修改
            } else {
                self.navigationBar_rightBtn_title(name: "修改")
            }

            self.tableView.reloadData()
        } else if type == .invoice_gettype{
            userList = data as! [expense_gettypeModel]
            self.showOption()
        }

    }

    func endEdite(inputStr: String, tagNum: Int) {
        HCLog(message: "内容\(tagNum)" + inputStr)

        if typeStr == "0" {
            if tagNum == 0 {
                titleStr = inputStr
            } else if tagNum == 3 {
                moneyStr = inputStr
            }
        } else if typeStr == "1" {
            if tagNum == 0 {
                titleStr = inputStr
            } else if tagNum == 3 {
                //地址
                eaddrStr = inputStr
            } else if tagNum  == 4 {
                //电话
                ephoneStr = inputStr
            } else if tagNum == 5 {
                //银行
                ebankStr = inputStr
            } else if tagNum == 6 {
                //账号
                ecardStr = inputStr
            } else if tagNum == 8 {
                //金额
                moneyStr = inputStr
            }

        }


        if sendtype == "1" {
            if tagNum == 30{
                //收件人
                 nameStr = inputStr

            } else if tagNum == 31{
                //联系电话
                phoneStr = inputStr

            } else if tagNum == 32 {
                //邮编
                zipStr = inputStr

            } else if tagNum == 33 {
                //邮寄地址
                addrStr = inputStr

            }
        }

        if tagNum ==  41{
            remarkStr = inputStr
        }
    }

    func endText_title5(inputStr: String, tagNum: Int) {
        HCLog(message: inputStr)
        if typeStr == "0" {
            creditcodeStr = inputStr
        } else {
            if tagNum == 1 {
                creditcodeStr = inputStr
            } else {
                identifierStr = inputStr
            }
        }
    }

    func selectedClickDelegate(tag: Int, type: String) {
        self.view.endEditing(true)
        HCLog(message:"代理")
        if tag == 30 {
            paytype = "0"
        } else {
            paytype = "1"
        }
    }


    func selectedHeadViewDelegate_type(tag: Int, type: String) {
        HCLog(message: tag)
        HCLog(message: type)

        if tag == 0 {
            //
            typeStr = type
            if type == "0" {
                //普通
                HCLog(message: "普通")
                section1rows = 4
            } else {
                //增值
                HCLog(message: "增值")
                section1rows = 10
            }
            let set = IndexSet(integer: 0)
            self.tableView.reloadSections(set, with: .automatic)

        } else if tag == 10 {

            isbooksStr = type
            if type == "0" {
                //普通
                HCLog(message: "未入账")
                section2rows = 0
            } else {
                //增值
                HCLog(message: "已入账")
                section2rows = 1
            }
            let set = IndexSet(integer: 2)
            self.tableView.reloadSections(set, with: .automatic)




        } else if tag == 20 {

            sendtype = type
            if type == "0" {
                //普通
                HCLog(message: "上门自取")
                section3rows = 0
            } else {
                //增值
                HCLog(message: "快递邮寄")
                section3rows = 5
            }
            let set = IndexSet(integer: 3)
            let set2 = IndexSet(integer: 4)
            self.tableView.reloadSections(set, with: .automatic)
            self.tableView.reloadSections(set2, with: .automatic)
        } else {


        }
    }

    func invoce_infoClick() {
        //发票信息
        if userList.count > 0 {
            self.showOption()
        } else {
            requestVC.delegate = self
            requestVC.invoice_gettypeRequest()
        }
    }


    func showOption() {
        self.maskView.addSubview(self.optionView)
        self.view.window?.addSubview(self.maskView)
        self.optionView.setDataExpensive(dataArr: userList)
        self.optionView.delegate = self
        self.optionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(200)
        }
    }


    func optionSure(idStr: String, titleStr: String, noteStr: String, pickTag: Int) {
        self.maskView.removeFromSuperview()
        self.optionView.removeFromSuperview()
        contentStr = titleStr
        optionCell.setOptionData(contentStr: titleStr)


    }
    
    /// 显示时间
    func showDate() {
        self.maskView.addSubview(self.dateView)
        self.view.window?.addSubview(self.maskView)
        self.dateView.delegate = self
        self.dateView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(200)
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
        if type == 20 {
            let cell : endTimeTableViewCell  = self.tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as! endTimeTableViewCell
            cell.setTime(str: timeStr)

        } else if type == 30 {

            let cell : endTimeTableViewCell  = self.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as! endTimeTableViewCell
            cell.setTime(str: timeStr)
        } else if type == 40 {
            let cell : endTimeTableViewCell  = self.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as! endTimeTableViewCell
            cell.setTime(str: timeStr)
        }
        if type == 20 {
            //入账时间
            applytimeStr = timeStr
        }
        if type == 30 {
            //自取
            mtimeStr = timeStr
        }
        if type == 40  {
            //收件
            mtimeStr = timeStr

        }

        self.dateView.removeFromSuperview()
        self.maskView.removeFromSuperview()
    }
    override func navigationRightBtnClick() {
        self.view.endEditing(true)
        if !(remarkStr.count > 0) {
            HCLog(message: "请输入备注")
            return
        }

        if viewType == .add {
            HCLog(message: "确定")
                        if !isOK {
                SVPMessageShow.showErro(infoStr: "请勾选承诺")
                return
            }
            requestVC.invoice_saveRequest(id: "", typeStr: typeStr, title: titleStr, money: moneyStr, creditcode: creditcodeStr, sendtype: sendtype, content: contentStr, isbooks: isbooksStr, applytime: applytimeStr, identifier: self.identifierStr, eaddr: self.eaddrStr, ephone: ephoneStr, ebank: ebankStr, ecard: ecardStr, name: nameStr, phone: phoneStr, zip: zipStr, addr: addrStr, paytype: paytype, mtime: mtimeStr, remark: remarkStr, imageArr: imageArr)

        } else if viewType == .detial{
            HCLog(message: "修改")
            self.navigationBar_rightBtn_title(name: "确定")
            self.viewType = .edite
            self.tableView.reloadData()

        } else if viewType == .edite{
            self.view.endEditing(true)
            HCLog(message: "修改之后确定")
            requestVC.invoice_saveRequest(id: "\(id!)", typeStr: typeStr, title: titleStr, money: moneyStr, creditcode: creditcodeStr, sendtype: sendtype, content: contentStr, isbooks: isbooksStr, applytime: applytimeStr, identifier: self.identifierStr, eaddr: self.eaddrStr, ephone: ephoneStr, ebank: ebankStr, ecard: ecardStr, name: nameStr, phone: phoneStr, zip: zipStr, addr: addrStr, paytype: paytype, mtime: mtimeStr, remark: remarkStr, imageArr: imageArr)
        }
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
