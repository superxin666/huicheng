//
//  OverCaseViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/4/20.
//  Copyright © 2018年 lvxin. All rights reserved.
// 申请结案

import UIKit

class OverCaseViewController: BaseTableViewController,ContentTableViewCellDelegate,DatePickViewDelegate,OptionViewDelgate,WorkRequestVCDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{


    

    /// 合同id
    var dealId : Int!
    /// 合同编号
    var dealNum : String = ""

    /// 时间
    var rtStr : String = ""

    /// 律师
    var nStr : String = ""
    /// 结案总结
    var dStr : String = ""


    /// 时间
    let dateView : DatePickView = DatePickView.loadNib()
    /// 律师
    var userList : [userlistModel] = []

    /// 选项
    let optionView : OptionView = OptionView.loadNib()

    let request : WorkRequestVC = WorkRequestVC()


    var fileArr : Array<String> = []
    var imageData : Data = Data()

    var alertController : UIAlertController!

    var fileCell : FileTableViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        request.delegate = self
        self.navigation_title_fontsize(name: "申请结案", fontsize: 18)
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
        self.tableView .register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)
        self.tableView .register(UINib.init(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: ContentTableViewCellID)
        self.tableView .register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
        self.tableView .register(UINib.init(nibName: "FileTableViewCell", bundle: nil), forCellReuseIdentifier: FileTableViewCellID)

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell : Title4TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Title4TableViewCellID, for: indexPath) as! Title4TableViewCell
            cell.setData_overCase(titleStr: "合同编号", contentStr: dealNum)
            return cell
        } else if indexPath.row == 1  {
            let cell : OptionTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
            cell.setData_caseDetail(titleStr: "律师姓名", contentStr: "")
            return cell
        } else if indexPath.row == 2 {
            let cell : endTimeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
            cell.setData(titleStr: "结案日期", tag: 2)
            return cell

        } else if indexPath.row == 3 {
            let cell : ContentTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
            cell.setData_overdeal(titleStr: "结案总结")
            cell.delegate = self
            return cell
        } else {
            fileCell  = tableView.dequeueReusableCell(withIdentifier: FileTableViewCellID, for: indexPath) as! FileTableViewCell
            return fileCell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        if indexPath.row == 1{
            //律师
            //立案律师
            if userList.count > 0 {
                self.showOptionPickView()
            } else {
                request.userlistRequest()
            }

        } else  if indexPath.row == 2 {
            //时间
            self.showDate()
        } else if indexPath.row == 4 {
            //选择文件

            self.showAlert()


        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return ContentTableViewCellH
        } else {
            return 50
        }
    }

    func endText_content(content: String,tagNum : Int) {
        dStr = content
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
            picker.allowsEditing = false

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
        let  image = info[UIImagePickerControllerOriginalImage] as! UIImage

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

    func showOptionPickView() {

        self.maskView.addSubview(self.optionView)
        self.view.window?.addSubview(self.maskView)
        self.optionView.setData_deal(dataArr: self.userList)
        self.optionView.delegate = self

        self.optionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(160)
        }
    }

    func optionSure(idStr: String, titleStr: String,noteStr : String, pickTag: Int) {
        let cell : OptionTableViewCell = self.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! OptionTableViewCell
        nStr = idStr
        cell.setOptionData(contentStr: titleStr)
        self.optionView.removeFromSuperview()
        self.maskView.removeFromSuperview()
    }

    func requestSucceed_work(data: Any, type: WorkRequestVC_enum) {
        if type == .userlist {
            //律师
            userList = data as! [userlistModel]
            self.showOptionPickView()
        } else if type == .oversave{
            //申请完结
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

    func requestFail_work() {

    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        HCLog(message: "确定")
        self.view.endEditing(true)
        if !(self.nStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请选择律师")
            return
        }
        if !(self.rtStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请选择时间")
            return
        }
        if !(self.dStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入总结")
            return
        }

        self.upLoad(type: "1", completion: { (data) in
            let str : String = data as! String
            if str.count > 0 {

                self.request.dealoversave(id: self.dealId, n: self.nStr, t: self.rtStr, d: self.dStr, i: str)

            } else {
                HCLog(message: "上传失败")

            }
        }) { (erro) in

            self.request.dealoversave(id: self.dealId, n: self.nStr, t: self.rtStr, d: self.dStr, i: "")
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
                    let file =  model.msg
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
