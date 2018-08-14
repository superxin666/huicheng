//
//  AddWorkViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/31.
//  Copyright © 2018年 lvxin. All rights reserved.
//  添加工作日志  工作日志只能上传一个文件 参照web

import UIKit
enum AddWorkViewControllerType {
    case add,detail
}
typealias AddWorkViewControllerBlocl = ()->()
class AddWorkViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,MineRequestVCDelegate,TitleTableViewCellDelegate,ContentTableViewCellDelegate {
    var sucessBlock : AddWorkViewControllerBlocl!

    let requestVC = MineRequestVC()

    var type : AddWorkViewControllerType!

    let mainTabelView : UITableView = UITableView()

    var workID : Int!

    var workDetailModel : work_getinfoModel!

    var tStr = ""

    var nStr = ""

    var fileNameStr = ""


    var fileArr : Array<String> = []
    var fileCell : FileTableViewCell!
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
        self.navigation_title_fontsize(name: "工作日志", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        requestVC.delegate = self
        if type == .add {
            self.navigationBar_rightBtn_title(name: "确定",textColour: darkblueColor)
        } else {
            requestVC.work_getinfoRequest(id: self.workID!)
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
        mainTabelView.register(UINib.init(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: ContentTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "FileTableViewCell", bundle: nil), forCellReuseIdentifier: FileTableViewCellID)
        self.view.addSubview(mainTabelView)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
            cell.delegate = self
            cell.setData_work(titleStr: "标题", congtentStr: tStr)
            if type == .add{
                cell.isUserInteractionEnabled = true
            } else {
                cell.isUserInteractionEnabled = false
            }
            return cell
        } else if indexPath.row == 1 {
            let cell : ContentTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
            cell.delegate = self
            cell.setData_work(title: "内容", contentCase: nStr)
            if type == .add{
                cell.isUserInteractionEnabled = true
            } else {
                cell.isUserInteractionEnabled = false
            }
            return cell
        } else {
            fileCell = tableView.dequeueReusableCell(withIdentifier: FileTableViewCellID, for: indexPath) as! FileTableViewCell
            
            fileCell.setData_fileName(fileName: fileNameStr)
            return fileCell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if type == .add {
            if indexPath.row == 2 {
                let vc = FileViewController()
                vc.hidesBottomBarWhenPushed = true
                weak var weakself = self
                vc.fileArrBlock = {(fileArr) in
                    let nameStr = fileArr[0]
                    weakself?.fileCell.setData_fileName(fileName: nameStr)
                    weakself?.fileArr = fileArr
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }

        } else {
            if indexPath.row == 2 {
                HCLog(message: "查看文件")
                if self.workDetailModel.attachment.count > 0 {
                    let vc = ReadPdfViewController()
                    HCLog(message:  self.workDetailModel.attachment!)
                    let str = self.workDetailModel.attachment.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!

                    HCLog(message: self.workDetailModel.attachment.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)
                    vc.url = URL(string: base_imageOrFile_api + str)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return TitleTableViewCellH
        } else if indexPath.row == 1 {
            return ContentTableViewCellH
        } else {
            return FileTableViewCellH
        }
    }

    func requestSucceed_mine(data: Any, type: MineRequestVC_enum) {
        if type == .work_getinfo {
            //获取详情
            workDetailModel = data as! work_getinfoModel
            tStr = workDetailModel.title
            nStr = workDetailModel.content
            HCLog(message:  workDetailModel.attachment)


            if workDetailModel.attachment.count > 0 {
                let arr = workDetailModel.attachment.components(separatedBy: "/")
                fileNameStr = arr.last!
            }


            self.mainTabelView.reloadData()
        } else if type == .work_save{
            //保存
            self.sucessBlock()
            self.navigationController?.popViewController(animated: true)
        }
    }

    func requestFail_mine() {

    }
    func endEdite(inputStr: String, tagNum: Int) {
        self.tStr = inputStr
    }
    func endText_content(content: String, tagNum: Int) {
        self.nStr = content
    }
    
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        if self.type == .add {
            HCLog(message: "确定")
            self.view.endEditing(true)
            if !(tStr.count > 0){
                SVPMessageShow.showErro(infoStr: "请输入标题")
                return
            }
            if !(nStr.count > 0){
                SVPMessageShow.showErro(infoStr: "请输入内容名")
                return
            }
            if self.fileArr.count > 0 {
                //上传文件
                SVPMessageShow.showLoad(title: "正在上传文件")
                weak var weakSelf = self

                BaseNetViewController.uploadfile(fileName: self.fileArr[0], t: "12", completion: { (data) in
                    let model = data as! CodeData
                    if model.code == 1 {
                        HCLog(message: model.msg)
                        SVPMessageShow.dismissSVP()
                        let file = base_imageOrFile_api + model.msg
                        weakSelf?.requestVC.work_save_apiRequest(t: (weakSelf?.tStr)!, n:(weakSelf?.nStr)!, a: file)

                    } else {
                        SVPMessageShow.dismissSVP()
                        SVPMessageShow.showErro(infoStr: "文件上传失败，请重新尝试")
                    }
                }) { (erro) in
                    SVPMessageShow.dismissSVP()
                    SVPMessageShow.showErro(infoStr: "文件上传失败，请重新尝试")
                }
            } else {
                requestVC.work_save_apiRequest(t: tStr, n:nStr, a: "")
            }

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
