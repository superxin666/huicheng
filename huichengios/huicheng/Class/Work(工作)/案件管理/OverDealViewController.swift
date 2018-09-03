//
//  OverDealViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/4/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//  生成合同

import UIKit
enum OverDealViewControllerType {
    case overCase,
    editeDeal
}

class OverDealViewController:
BaseTableViewController,DatePickViewDelegate,OptionViewDelgate ,WorkRequestVCDelegate,SelectedTableViewCellDelegate,TitleTableViewCellDelegate,Title5TableViewCellDelegate,MineRequestVCDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{


    var type : OverDealViewControllerType = .overCase
    var caseType : String!


    /// 合同id
    var dealId : Int!
    /// 合同编号
    var dealNum : String = ""

    /// 合同付款期限
    var dStr : String = ""
    /// 合同有效期-起始时间
    var bStr : String = ""
    /// 合同有效期-终止时间
    var eStr : String = ""

    /// 总款
    var aStr : String = ""
    /// 发票 0-未开;1-已开
    var itStr : String = "0"
    /// 发票信息(整型)
    var itIdStr : String = ""
    var itNameStr : String = ""

    var imageStr : String = ""

    /// 发票号
    var pStr : String = ""
    /// 社会统一信用代码
    var ccStr : String = ""


    var fileStr : String = ""


    /// 时间
    let dateView : DatePickView = DatePickView.loadNib()
    /// 律师
    var userList : [expense_gettypeModel] = []

    /// 选项
    let optionView : OptionView = OptionView.loadNib()

    let request : WorkRequestVC = WorkRequestVC()

    let requestVc2 : MineRequestVC = MineRequestVC()

    var alertController : UIAlertController!

    var rowNum = 8

    var fileCell : FileTableViewCell!


    var fileArr : Array<String> = []
    var imageData : Data = Data()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        request.delegate = self
        if type == .overCase {
            self.navigation_title_fontsize(name: "生成合同", fontsize: 18)
            if !(caseType == "4") {
                rowNum = rowNum - 2
            }
        } else {
            self.navigation_title_fontsize(name: "合同信息", fontsize: 18)
            if itStr == "0" {
                rowNum = 8
            } else {
                rowNum = 10
            }
            if !(caseType == "4") {
                rowNum = rowNum - 2
            }
        }

        self.navigationBar_rightBtn_title(name: "确定")
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
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
        self.tableView .register(UINib.init(nibName: "Title4TableViewCell", bundle: nil), forCellReuseIdentifier: Title4TableViewCellID)
        self.tableView .register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
        self.tableView .register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
        self.tableView .register(UINib.init(nibName: "SelectedTableViewCell", bundle: nil), forCellReuseIdentifier: SelectedTableViewCellID)
        self.tableView .register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)
        self.tableView .register(UINib.init(nibName: "FileTableViewCell", bundle: nil), forCellReuseIdentifier: FileTableViewCellID)
        self.tableView .register(UINib.init(nibName: "Title5TableViewCell", bundle: nil), forCellReuseIdentifier: Title5TableViewCellID)




    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowNum
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if itStr == "0" {
            //未开
            if indexPath.row == 0 {
                let cell : Title4TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Title4TableViewCellID, for: indexPath) as! Title4TableViewCell
                cell.setData_overCase(titleStr: "合同编号", contentStr: dealNum)
                return cell
            } else if indexPath.row == 1  {
                let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.setData_overDeal(titleStr: "合同总款", contentStr: aStr, indexPath: indexPath)
                cell.delegate = self

                return cell
            } else if indexPath.row == 2 {
                let cell : endTimeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                cell.setData(titleStr: "合同付款期限", tag: indexPath.row)
                cell.setTime(str: dStr)

                return cell

            } else if indexPath.row == 3 {
                let cell : SelectedTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: SelectedTableViewCellID, for: indexPath) as! SelectedTableViewCell
                cell.delegate = self
                cell.setData_deal(type: itStr)
                return cell

            } else if indexPath.row == 4 {
                let cell : OptionTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                cell.setData_caseDetail(titleStr: "发票信息", contentStr: itNameStr)
                return cell
            } else if indexPath.row == 5 {
                fileCell = tableView.dequeueReusableCell(withIdentifier: FileTableViewCellID, for: indexPath) as! FileTableViewCell
                fileCell.setData_deal()
                if type == .editeDeal {
                    fileCell.setData_fileName(fileName: fileStr)
                }
                return fileCell
            }   else if indexPath.row == 6 {
                let cell : endTimeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                cell.setData(titleStr: "起始时间", tag: indexPath.row)
                cell.setTime(str: bStr)

                return cell

            } else  {
                let cell : endTimeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                cell.setData(titleStr: "结束时间", tag: indexPath.row)
                cell.setTime(str: eStr)

                return cell

            }



        } else {
            //已开
            if indexPath.row == 0 {
                let cell : Title4TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Title4TableViewCellID, for: indexPath) as! Title4TableViewCell
                cell.setData_overCase(titleStr: "合同编号", contentStr: dealNum)
                return cell
            } else if indexPath.row == 1  {
                let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                cell.delegate = self
                cell.setData_overDeal(titleStr: "合同总款", contentStr: aStr, indexPath: indexPath)

                return cell
            } else if indexPath.row == 2 {
                let cell : endTimeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                cell.setData(titleStr: "合同付款期限", tag: 2)
                cell.setTime(str: dStr)

                return cell

            }  else if indexPath.row == 3 {
                let cell : SelectedTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: SelectedTableViewCellID, for: indexPath) as! SelectedTableViewCell
                cell.delegate = self
                cell.setData_deal(type: itStr)
                return cell
            } else if indexPath.row == 4 {
                //发票号
                let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                HCLog(message: pStr)
                cell.delegate = self
                cell.setData_overDeal(titleStr: "发票号", contentStr: pStr, indexPath: indexPath)
                return cell
            } else if indexPath.row ==  5 {
                //信用代码
                let cell : Title5TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Title5TableViewCellID, for: indexPath) as! Title5TableViewCell
                cell.setData_overDeal(titleStr: "社会统一信用代码", contentStr: ccStr)
                cell.delegate = self
                return cell

            } else if indexPath.row == 6 {
                let cell : OptionTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                cell.setData_caseDetail(titleStr: "发票信息", contentStr: itNameStr)
                return cell
            } else if indexPath.row == 7 {
                fileCell  = tableView.dequeueReusableCell(withIdentifier: FileTableViewCellID, for: indexPath) as! FileTableViewCell
                fileCell.setData_deal()
                if type == .editeDeal {
                    fileCell.setData_fileName(fileName: fileStr)
                }

                return fileCell
            } else if indexPath.row == 8 {
                let cell : endTimeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                cell.setData(titleStr: "起始时间", tag: indexPath.row)
                cell.setTime(str: bStr)

                return cell

            } else {
                let cell : endTimeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                cell.setData(titleStr: "结束时间", tag: indexPath.row)
                cell.setTime(str: eStr)

                return cell
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        if itStr == "0" {
            //未开
            if indexPath.row == 4{
                //发票信息
                if userList.count > 0 {
                    self.showOptionPickView()
                } else {
                    requestVc2.delegate = self
                    requestVc2.invoice_gettypeRequest()
                }

            } else  if indexPath.row == 2 || indexPath.row == 6 || indexPath.row == 7 {
                //时间
                self.showDate(rowNum: indexPath.row)

            } else if indexPath.row == 5 {
                //合同扫描
                HCLog(message: "合同扫描")

                self.showAlert()


            }


        } else {
            //已开
            if indexPath.row == 6{
                //发票信息
                if userList.count > 0 {
                    self.showOptionPickView()
                } else {
                    requestVc2.delegate = self
                    requestVc2.invoice_gettypeRequest()
                }

            } else  if indexPath.row == 2 || indexPath.row == 8 || indexPath.row == 9{
                //时间
                self.showDate(rowNum: indexPath.row)
            } else if indexPath.row == 7 {
                //合同扫描
                HCLog(message: "合同扫描")
                self.showAlert()

            }

        }

    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if itStr == "0" {
            return 50
        } else {
            if indexPath.row == 5 {
                return Title5TableViewCellH
            } else {
                return 50

            }
        }

    }
    func showAlert() {
        alertController = UIAlertController(title: nil, message: "文件选择", preferredStyle: .actionSheet)
        let sureAction = UIAlertAction(title: "图片", style: .default) { (action) in
            self.openAlbum()
        }

        let sureAction2 = UIAlertAction(title: "文件", style: .default) { (action) in
            self.getFileClick()

        }

        let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (action) in

        }

        alertController.addAction(sureAction2)
        alertController.addAction(sureAction)
        alertController.addAction(cancleAction)

        self.present((alertController)!, animated: true, completion: nil)


    }

    /// 获取文件
    func getFileClick()  {

        weak  var weakSelf = self
        let vc = FileViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.fileArrBlock = {(fileArr) in
            if (weakSelf?.imageData.count)! > 0  {
                //清除图片数据
                weakSelf?.imageData = Data()
            }
            let nameStr = fileArr[0]
            self.fileCell.setData_fileName(fileName: nameStr)
            weakSelf?.fileArr = fileArr
        }
        self.navigationController?.pushViewController(vc, animated: true)

    }




    func openAlbum() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //初始化图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self
            //指定图片控制器类型
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //设置是否允许编辑
            picker.allowsEditing = true

            //弹出控制器，显示界面
            self.present(picker, animated: true, completion: {
                () -> Void in
            })
        }else{
            HCLog(message:  "读取相册错误")
        }

    }

    //选择图片成功后代理
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]) {
        //查看info对象
        HCLog(message: info)
        if self.fileArr.count > 0 {
            self.fileArr.removeAll()
        }
        //获取选择的编辑后的
        let  image = info[UIImagePickerControllerEditedImage] as! UIImage

        let nameStr = image.description
        HCLog(message: nameStr)


        self.fileCell.setData_fileName(fileName: "图片")


        imageData = UIImageJPEGRepresentation(image, 1.0)!

        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in

            //显示图片
        })
    }




    func endEdite(inputStr: String, tagNum: Int) {
        HCLog(message: tagNum)
        HCLog(message: inputStr)
        if tagNum == 1 {
            aStr = inputStr
        } else {
            HCLog(message: "12121212")
            pStr = inputStr
        }
    }

    func endText_title5(inputStr: String, tagNum: Int) {
        ccStr = inputStr
    }


    /// 显示时间
    func showDate(rowNum : Int) {
        self.maskView.addSubview(self.dateView)
        self.view.window?.addSubview(self.maskView)
        self.dateView.setData(type: rowNum)
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
        if type == 2 {
            self.dStr = timeStr
        } else if type == 6 || type == 8 {
            self.bStr = timeStr
        } else {
            self.eStr = timeStr
        }

        let cell : endTimeTableViewCell  = self.tableView.cellForRow(at: IndexPath(row: type, section: 0)) as! endTimeTableViewCell
        cell.setTime(str: timeStr)
        self.dateView.removeFromSuperview()
        self.maskView.removeFromSuperview()
    }

    func showOptionPickView() {

        self.maskView.addSubview(self.optionView)
        self.view.window?.addSubview(self.maskView)

        self.optionView.delegate = self
        self.optionView.setDataExpensive(dataArr: userList)
        self.optionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(160)
        }
    }

    func optionSure(idStr: String, titleStr: String,noteStr :String ,pickTag: Int) {
        var rowNum = 6

        if itStr == "0" {
            rowNum = 4
        } else {
            rowNum = 6
        }


        let cell : OptionTableViewCell = self.tableView.cellForRow(at: IndexPath(row: rowNum, section: 0)) as! OptionTableViewCell
        itIdStr = idStr
        itNameStr = titleStr
        cell.setOptionData(contentStr: titleStr)
        self.optionView.removeFromSuperview()
        self.maskView.removeFromSuperview()
    }

    func selectedClickDelegate_type(tag: Int, type: String) {
        self.view.endEditing(true)
        itStr = type
        if type == "0" {
            rowNum = 8
        } else {
            rowNum = 10
        }
        if !(caseType == "4") {
            rowNum = rowNum - 2
        }


        self.tableView.reloadData()

    }

    func requestSucceed_work(data: Any, type: WorkRequestVC_enum) {

        //

        self.navigationController?.popToRootViewController(animated: true)

    }

    func requestFail_work() {

    }

    func requestSucceed_mine(data: Any, type: MineRequestVC_enum) {
        userList = data as! [expense_gettypeModel]
        self.showOptionPickView()
    }

    func requestFail_mine() {

    }



    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        HCLog(message: "确定")
        self.view.endEditing(true)
        if type == .overCase{
            //生成合同
            self.overCaseRequest()
        } else {
            //修改合同
            self.editeDeal()
        }

    }

    func editeDeal() {


        if !(self.aStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入合同总款")
            return
        }
        if !(self.dStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请选择时间")
            return
        }
        if itStr == "1" {
            if !(self.pStr.count > 0) {
                SVPMessageShow.showErro(infoStr: "请输入发票号")
                return
            }
            if !(self.ccStr.count > 0) {
                SVPMessageShow.showErro(infoStr: "请输入社会统一信用代码")
                return
            }

        }

        self.upLoad(type: "2", completion: { (data) in
            let str : String = data as! String
            if str.count > 0 {
                self.request.dealSaveRequest(id: "\(self.dealId!)", a:self.aStr, m: "", b: self.bStr, e: self.eStr, d: self.dStr, i: self.itStr, pn: self.pStr, cc: self.ccStr, it: self.itIdStr, img: str)

            } else {
                HCLog(message: "上传失败")

            }


        }) { (erro) in
            self.request.dealSaveRequest(id: "\(self.dealId!)", a:self.aStr, m: "", b: self.bStr, e: self.eStr, d: self.dStr, i: self.itStr, pn: self.pStr, cc: self.ccStr, it: self.itIdStr, img: "")
        }


    }

    func overCaseRequest() {
        if !(self.aStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入合同总款")
            return
        }
        if !(self.dStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请选择时间")
            return
        }

        self.upLoad(type: "2", completion: { (data) in
            let str : String = data as! String
            if str.count > 0 {
                self.request.casecreatedeals(id: "\(self.dealId!)", a:self.aStr, m: "", b: self.bStr, e: self.eStr, d: self.dStr, i: self.itStr, pn: self.pStr, cc: self.ccStr, it: self.itIdStr, img: str)

            } else {
                HCLog(message: "上传失败")

            }


        }) { (erro) in
            self.request.casecreatedeals(id: "\(self.dealId!)", a:self.aStr, m: "", b: self.bStr, e: self.eStr, d: self.dStr, i: self.itStr, pn: self.pStr, cc: self.ccStr, it: self.itIdStr, img: "")
        }


    }


    func upLoad(type : String,completion : @escaping (_ data : Any) ->(), failure : @escaping (_ error : Any)->()) {

        if self.fileArr.count > 0 {
            //        上传文件
            SVPMessageShow.showLoad(title: "正在上传文件")
            BaseNetViewController.uploadfile(fileName: self.fileArr[0], t: type, completion: { (data) in
                let model = data as! CodeData
                if model.code == 1 {
                    HCLog(message: model.msg)
                    SVPMessageShow.dismissSVP()
                    let file =   model.msg
                    completion(file)
                } else {
                    SVPMessageShow.dismissSVP()
                    SVPMessageShow.showErro(infoStr: "文件上传失败，请重新尝试")
                }
            }) { (erro) in
                SVPMessageShow.dismissSVP()
                SVPMessageShow.showErro(infoStr: "文件上传失败，请重新尝试")
                completion("")
            }
        } else if imageData.count > 0 {

            BaseNetViewController.uploadfile(fileName: "", t: type,isFile: false,imageData: imageData, completion: { (data) in
                let model = data as! CodeData
                if model.code == 1 {
                    HCLog(message: model.msg)
                    SVPMessageShow.dismissSVP()
                    let file =   model.msg
                    completion(file)
                } else {
                    completion("")
                    SVPMessageShow.dismissSVP()
                    SVPMessageShow.showErro(infoStr: "文件上传失败，请重新尝试")
                }
            }) { (erro) in
                SVPMessageShow.dismissSVP()
                SVPMessageShow.showErro(infoStr: "文件上传失败，请重新尝试")
                completion("")
            }

        } else {
            failure("")
        }

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
