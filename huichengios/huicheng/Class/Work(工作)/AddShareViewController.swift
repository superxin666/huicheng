
//
//  AddShareViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/6/6.
//  Copyright © 2018年 lvxin. All rights reserved.
//  添加共享模板

import UIKit

class AddShareViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,WorkRequestVCDelegate,ContentTableViewCellDelegate,OptionViewDelgate,TitleTableViewCellDelegate {
    var caseTypeArr : [casetypeModel] = []
    var sucessBlock : AddWorkViewControllerBlocl!
    /// 选项
    let optionView : OptionView = OptionView.loadNib()

    let requestVC = WorkRequestVC()
    var dStr : String = ""
    var nStr : String = ""
    var tStr : String = ""


    let mainTabelView : UITableView = UITableView()
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
        self.navigation_title_fontsize(name: "新增模板", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        requestVC.delegate = self
        self.navigationBar_rightBtn_title(name: "确定")
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
        mainTabelView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: ContentTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "FileTableViewCell", bundle: nil), forCellReuseIdentifier: FileTableViewCellID)
        self.view.addSubview(mainTabelView)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell : OptionTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell
                cell.setData_caseDetail(titleStr: "分类", contentStr: "")
            return cell
        } else if indexPath.row == 1 {
            let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
            cell.delegate = self
            cell.setData_work(titleStr: "标题", congtentStr: tStr)
            return cell

        } else if indexPath.row == 2 {
            let cell : ContentTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
            cell.delegate = self
            cell.setData_work(title: "内容", contentCase: nStr)
            return cell
        } else {
            fileCell = tableView.dequeueReusableCell(withIdentifier: FileTableViewCellID, for: indexPath) as! FileTableViewCell

            return fileCell
        }

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //案件类型
            if caseTypeArr.count > 0 {
                self.showOptionPickView()
            } else {
                requestVC.sharegettypeRequest()
            }

        } else if indexPath.row == 3 {
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
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return OptionTableViewCellH
        } else if indexPath.row == 1 {
            return TitleTableViewCellH
        } else if indexPath.row == 2 {
            return ContentTableViewCellH
        } else {
            return FileTableViewCellH
        }
    }
    func showOptionPickView() {

        self.maskView.addSubview(self.optionView)
        self.view.window?.addSubview(self.maskView)

        self.optionView.setData_share(dataArr: self.caseTypeArr)
        self.optionView.delegate = self
        self.optionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(160)
        }
    }


    func requestSucceed_work(data: Any, type: WorkRequestVC_enum) {
        if type == .sharegettype {
            caseTypeArr = data as! [casetypeModel]
            self.showOptionPickView()
        } else {
            self.navigationController?.popViewController(animated: true)
        }

    }

    func requestFail_work() {

    }
    func optionSure(idStr: String, titleStr: String,noteStr : String, pickTag: Int) {
        self.dStr = idStr
        let cell : OptionTableViewCell = mainTabelView.cellForRow(at: IndexPath(row: pickTag, section: 0)) as! OptionTableViewCell
        cell.setOptionData(contentStr: titleStr)

        self.optionView.removeFromSuperview()
        self.maskView.removeFromSuperview()

    }
    func endText_content(content: String, tagNum: Int) {
        self.nStr = content
    }
    func endEdite(inputStr: String, tagNum: Int) {
        self.tStr = inputStr
    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {

        HCLog(message: "确定")
        self.view.endEditing(true)
        if !(nStr.count > 0){
            SVPMessageShow.showErro(infoStr: "请输入内容名")
            return
        }
        if !(tStr.count > 0){
            SVPMessageShow.showErro(infoStr: "请输入标题")
            return
        }
        if self.fileArr.count > 0 {
            //上传文件
            SVPMessageShow.showLoad(title: "正在上传文件")
            weak var weakSelf = self

            BaseNetViewController.uploadfile(fileName: self.fileArr[0], t: "8", completion: { (data) in
                let model = data as! CodeData
                if model.code == 1 {
                    HCLog(message: model.msg)
                    SVPMessageShow.dismissSVP()
                    let file = base_imageOrFile_api + model.msg
                    weakSelf?.requestVC.sharesavequest(id: "", n: self.nStr, t: self.tStr, d: self.dStr, f: file)

                } else {
                    SVPMessageShow.dismissSVP()
                    SVPMessageShow.showErro(infoStr: "文件上传失败，请重新尝试")
                }
            }) { (erro) in
                SVPMessageShow.dismissSVP()
                SVPMessageShow.showErro(infoStr: "文件上传失败，请重新尝试")
            }
        } else {
               requestVC.sharesavequest(id: "", n: self.nStr, t: self.tStr, d: self.dStr, f: "")
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
