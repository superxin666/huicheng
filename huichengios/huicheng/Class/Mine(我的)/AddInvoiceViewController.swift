//
//  AddInvoiceViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/31.
//  Copyright © 2018年 lvxin. All rights reserved.
//  添加发票

import UIKit

class AddInvoiceViewController: BaseTableViewController,MineRequestVCDelegate,TitleTableViewCellDelegate,Selected2TableViewCellDelegate,Title5TableViewCellDelegate,DatePickViewDelegate,SelectedTableViewCellDelegate {

    let requestVC = MineRequestVC()


    let sectionNameArr = ["发票类型","名称","社会统一信用代码","发票内容","发票金额",]


    /// 0 1 2 3
    var section1Type : Int!

    /// 未入账 自取
    let section1NameArr = ["款项是否入账","送达方式","上门自取时间","备注"]

    /// 入账 自取
    let section1NameArr1 = ["款项是否入账","入账时间","送达方式","上门自取时间","备注"]

    /// 未入账 邮寄
    let section1NameArr2 = ["款项是否入账","送达方式","收件人","联系电话","邮编","邮寄地址","付费方式","收件时间","备注",]

    /// 入账 邮寄
    let section1NameArr3 = ["款项是否入账","入账时间","送达方式","收件人","联系电话","邮编","邮寄地址","付费方式","收件时间","备注",]

    var currectSectionArr : [String] = []


    /// 发票类型,INT 型;0-增值税普通发票;1-增值税专用发票;
    var typeStr : String = ""

    /// 名称
    var titleStr : String = ""

    /// 社会统一信用代码
    var creditcodeStr : String = ""

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
        self.navigationBar_rightBtn_title(name: "确定")
        //默认 未入账  上门自取
        currectSectionArr = section1NameArr
        section1Type = 0
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

    }
    // MARK: - delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        } else if section == 1 {
            return currectSectionArr.count
        } else {
            return 1
        }

    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0   {
                let cell : SelectedTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: SelectedTableViewCellID, for: indexPath) as! SelectedTableViewCell
                cell.setData_addinvoice()
                return cell
            } else if indexPath.row == 1 {
                let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.delegate = self
                cell.setData_addinvoce(title: sectionNameArr[indexPath.row], content: titleStr,indexPath : indexPath)
                return cell
            } else if indexPath.row == 2 {
                let cell : Title5TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Title5TableViewCellID, for: indexPath) as! Title5TableViewCell
                cell.delegate = self
                return cell
            }else if indexPath.row == 3 {
                let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.delegate = self
                cell.setData_addinvoce(title: sectionNameArr[indexPath.row], content: contentStr,indexPath : indexPath)
                return cell
            } else {
                let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.delegate = self
                cell.setData_addinvoce_mon(title: sectionNameArr[indexPath.row], content: moneyStr,indexPath : indexPath)
                return cell
            }
        } else if indexPath.section == 1 {
            //
            if section1Type == 0  {
                if indexPath.row == 0 {
                    let cell : Selected2TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Selected2TableViewCellID, for: indexPath) as! Selected2TableViewCell
                    cell.setData(title: section1NameArr[indexPath.row], leftStr: "未入账", rightStr: "已入账", show: 0)
                    cell.setSelected(selectedType: isbooksStr)
                    cell.delegate = self
                    return cell
                } else if indexPath.row == 1 {
                    let cell : Selected2TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Selected2TableViewCellID, for: indexPath) as! Selected2TableViewCell
                    cell.delegate = self
                    cell.setData(title: section1NameArr[indexPath.row], leftStr: "上门自取", rightStr: "快递邮寄", show: 1)
                    cell.setSelected(selectedType: sendtype)
                    return cell
                } else if indexPath.row == 2 {
                    let cell : endTimeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    cell.setData(titleStr: "自取时间", tag: 1)
                    cell.setTime(str: mtimeStr)
                    return cell
                } else {
                    let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    cell.delegate = self
                    cell.setData_addinvoce(title: section1NameArr[indexPath.row], content: remarkStr,indexPath : indexPath)
                    return cell
                }
            } else if section1Type == 1 {

                if indexPath.row == 0 {
                    let cell : Selected2TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Selected2TableViewCellID, for: indexPath) as! Selected2TableViewCell
                    cell.delegate = self
                    cell.setData(title: section1NameArr1[indexPath.row], leftStr: "未入账", rightStr: "已入账", show: 0)
                    cell.setSelected(selectedType: isbooksStr)
                    return cell
                } else if indexPath.row == 1 {
                    let cell : endTimeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    cell.setData(titleStr: "入账时间", tag: 10)
                    cell.setTime(str: applytimeStr)
                    return cell

                } else if indexPath.row == 2 {
                    let cell : Selected2TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Selected2TableViewCellID, for: indexPath) as! Selected2TableViewCell
                       cell.setData(title: section1NameArr1[indexPath.row], leftStr: "上门自取", rightStr: "快递邮寄", show: 1)
                    cell.setSelected(selectedType: sendtype)
                    cell.delegate = self
                    return cell

                } else if indexPath.row == 3{
                    let cell : endTimeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    cell.setData(titleStr: "自取时间", tag: 1)
                    cell.setTime(str: mtimeStr)
                    return cell

                } else {
                    let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    cell.delegate = self
                    cell.setData_addinvoce(title: section1NameArr1[indexPath.row], content: remarkStr,indexPath : indexPath)
                    return cell
                }
            } else if section1Type == 2 {
                if indexPath.row == 0 {
                    let cell : Selected2TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Selected2TableViewCellID, for: indexPath) as! Selected2TableViewCell
                    cell.delegate = self
                    cell.setData(title: section1NameArr2[indexPath.row], leftStr: "未入账", rightStr: "已入账", show: 0)
                    cell.setSelected(selectedType: isbooksStr)
                    return cell
                } else if indexPath.row == 1 {
                    let cell : Selected2TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Selected2TableViewCellID, for: indexPath) as! Selected2TableViewCell
                    cell.setData(title: section1NameArr2[indexPath.row], leftStr: "上门自取", rightStr: "快递邮寄", show: 1)
                    cell.setSelected(selectedType: sendtype)
                    cell.delegate = self
                    return cell

                } else if indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5{
                    let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    cell.delegate = self
                    cell.setData_addinvoce(title: section1NameArr2[indexPath.row], content: remarkStr,indexPath : indexPath)
                    return cell

                } else if indexPath.row == 6{
                    let cell : Selected2TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Selected2TableViewCellID, for: indexPath) as! Selected2TableViewCell
                    cell.delegate = self
                    cell.setData(title: section1NameArr2[indexPath.row], leftStr: "收件人付费", rightStr: "律师账扣", show: 2)
                    cell.setSelected(selectedType: applytimeStr)
                    return cell

                }else if indexPath.row == 7{
                    let cell : endTimeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    cell.setData(titleStr: "收件时间", tag: 3)
                    return cell

                } else {
                    let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    cell.delegate = self
                    cell.setData_addinvoce(title: section1NameArr2[indexPath.row], content: remarkStr,indexPath : indexPath)
                    return cell
                }
            } else {
                if indexPath.row == 0 {
                    let cell : Selected2TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Selected2TableViewCellID, for: indexPath) as! Selected2TableViewCell
                    cell.delegate = self
                    cell.setData(title: section1NameArr3[indexPath.row], leftStr: "未入账", rightStr: "已入账", show: 0)
                    cell.setSelected(selectedType: isbooksStr)
                    return cell
                } else if indexPath.row == 1 {
                    let cell : endTimeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    cell.setData(titleStr: "入账时间", tag: 1)
                    cell.setTime(str: applytimeStr)
                    return cell


                } else if indexPath.row == 2 {

                    let cell : Selected2TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Selected2TableViewCellID, for: indexPath) as! Selected2TableViewCell

                    cell.setData(title: section1NameArr3[indexPath.row], leftStr: "上门自取", rightStr: "快递邮寄", show: 1)
                    cell.setSelected(selectedType: sendtype)
                    cell.delegate = self
                    return cell
                } else if indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6{
                    let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    cell.delegate = self
                    cell.setData_addinvoce(title: section1NameArr3[indexPath.row], content: remarkStr,indexPath : indexPath)
                    return cell

                } else if indexPath.row == 7{
                    let cell : Selected2TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Selected2TableViewCellID, for: indexPath) as! Selected2TableViewCell
                    cell.delegate = self
                    cell.setData(title: section1NameArr3[indexPath.row], leftStr: "收件人付费", rightStr: "律师账扣", show: 2)
                    cell.setSelected(selectedType: paytype)
                    return cell

                }else if indexPath.row == 8{
                    let cell : endTimeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                    cell.setData(titleStr: "收件时间", tag: 3)
                    return cell

                } else {
                    let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                    cell.delegate = self
                    cell.setData_addinvoce(title: section1NameArr3[indexPath.row], content: remarkStr,indexPath : indexPath)
                    return cell
                }
            }

        } else {
            let cell : NoticeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: NoticeTableViewCellID, for: indexPath) as! NoticeTableViewCell
            cell.setData(contentStr: "本人承诺于开票日期起一个月内收回款项，逾期未收回的，从其账上直接按发票金额扣减等额款项")
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        if indexPath.section == 1 {
            if section1Type == 0  {
                if indexPath.row == 2 {
                    //自取时间
                    dateView.setData(type: 10)
                    self.showDate()
                }
            } else if section1Type == 1 {
                if indexPath.row == 1 {
                    //入账时间
                    dateView.setData(type: 20)
                    self.showDate()
                } else if indexPath.row == 3 {
                    //自取时间
                    dateView.setData(type: 30)
                    self.showDate()
                }

            } else if section1Type == 2 {
                if indexPath.row == 7 {
                    //收件时间
                    dateView.setData(type: 40)
                    self.showDate()
                }
            } else {
                if indexPath.row == 1 {
                    //入账时间
                     dateView.setData(type: 50)
                     self.showDate()
                } else if indexPath.row == 8 {
                    //收件时间
                    dateView.setData(type: 60)
                    self.showDate()
                }
            }
        }

    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 2 {
                return Title5TableViewCellH
            } else {
                return 50
            }
        } else if indexPath.section == 1 {
            return 50
        } else {
            return 50
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 20))
        view.backgroundColor = viewBackColor
        return view

    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 || section == 2 {
            return 20
        } else {
            return 0
        }
    }

    func getCell(row : Int) {


    }
    // MARK: - net
    func requestFail_mine() {

    }
    func requestSucceed_mine(data: Any, type: MineRequestVC_enum) {
        self.navigationController?.popViewController(animated: true)
    }

    func endEdite(inputStr: String, tagNum: Int) {
        HCLog(message: "内容\(tagNum)" + inputStr)

        if tagNum == 1 {
            self.titleStr = inputStr
        } else if tagNum == 3 {
            self.contentStr = inputStr
        }  else if tagNum == 4{
            self.moneyStr = inputStr
        } else {
            if section1Type == 2 {
                if tagNum == 12{
                    nameStr = inputStr
                }else if tagNum == 13{
                    phoneStr = inputStr
                }else if tagNum == 14{
                    zipStr = inputStr
                }else if tagNum == 15{
                    addrStr = inputStr
                } else {
                    remarkStr = inputStr
                }
            } else {
                if tagNum == 13{
                    nameStr = inputStr
                }else if tagNum == 14{
                    phoneStr = inputStr
                }else if tagNum == 15{
                    zipStr = inputStr
                }else if tagNum == 16{
                    addrStr = inputStr
                } else {
                    remarkStr = inputStr
                }

            }
        }
    }

    func endText_title5(inputStr: String, tagNum: Int) {
        HCLog(message: inputStr)
        creditcodeStr = inputStr
    }

    func selectedClickDelegate(tag: Int, type: String) {
        self.view.endEditing(true)

        HCLog(message:"代理")
        if tag == 10 {
            //是否入账
            isbooksStr = "0"
//            str = isbooksStr
        } else if tag == 100 {
            isbooksStr = "1"
//            str = isbooksStr
        } else if tag == 20{
            // 送达方式
            sendtype = "0"
//            str = sendtype
        } else if tag == 200 {
            sendtype = "1"
//            str = sendtype
        } else if tag == 30 {
            paytype = "0"
        } else {
            paytype = "1"
        }
        if isbooksStr == "0" && sendtype == "0" {
            section1Type = 0
            currectSectionArr = section1NameArr
        } else if isbooksStr == "1" && sendtype == "0" {
            section1Type = 1
            currectSectionArr = section1NameArr1
        } else if isbooksStr == "0" && sendtype == "1" {
            section1Type = 2
            currectSectionArr = section1NameArr2
        } else if isbooksStr == "1" && sendtype == "1" {
            section1Type = 3
            currectSectionArr = section1NameArr3
        }

        self.tableView.reloadSections([1], with: .automatic)
    }

    func selectedClickDelegate_type(tag: Int, type: String) {
        typeStr = type
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
        if type == 10 {
            let cell : endTimeTableViewCell  = self.tableView.cellForRow(at: IndexPath(row: 2, section: 1)) as! endTimeTableViewCell
            cell.setTime(str: timeStr)
        } else if type == 20 {
            let cell : endTimeTableViewCell  = self.tableView.cellForRow(at: IndexPath(row: 1, section: 1)) as! endTimeTableViewCell
            cell.setTime(str: timeStr)
        } else if type == 30 {
            let cell : endTimeTableViewCell  = self.tableView.cellForRow(at: IndexPath(row: 3, section: 1)) as! endTimeTableViewCell
            cell.setTime(str: timeStr)
        } else if type == 40 {
            let cell : endTimeTableViewCell  = self.tableView.cellForRow(at: IndexPath(row: 7, section: 1)) as! endTimeTableViewCell
            cell.setTime(str: timeStr)
        } else if type == 50 {
            let cell : endTimeTableViewCell  = self.tableView.cellForRow(at: IndexPath(row: 1, section: 1)) as! endTimeTableViewCell
            cell.setTime(str: timeStr)
        } else if type == 60 {
            let cell : endTimeTableViewCell  = self.tableView.cellForRow(at: IndexPath(row: 8, section: 1)) as! endTimeTableViewCell
            cell.setTime(str: timeStr)
        }
        if type == 10 || type == 30 {
            //自取
            mtimeStr = timeStr
        }
        if type == 20 || type == 50 {
            //入账
            applytimeStr = timeStr
        }
        if type == 40 || type == 60 {
            //收件
        }

        self.dateView.removeFromSuperview()
        self.maskView.removeFromSuperview()
    }
    override func navigationRightBtnClick() {
        HCLog(message: "确定")
        self.view.endEditing(true)
        let cell : NoticeTableViewCell  = self.tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as! NoticeTableViewCell
        if !cell.isNotice {
            SVPMessageShow.showErro(infoStr: "请勾选承诺")
            return
        }

        requestVC.invoice_saveRequest(typeStr: typeStr, title: titleStr, money: moneyStr, creditcode: creditcodeStr, sendtype: sendtype, content: contentStr, isbooks: isbooksStr, applytime: applytimeStr, identifier: "", eaddr: "", ephone: phoneStr, ebank: "", ecard: "", name: nameStr, phone: phoneStr, zip: zipStr, addr: addrStr, paytype: paytype, mtime: mtimeStr, remark: remarkStr)
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
