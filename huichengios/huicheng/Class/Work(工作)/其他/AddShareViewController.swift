
//
//  AddShareViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/6/6.
//  Copyright © 2018年 lvxin. All rights reserved.
//  添加共享模板

import UIKit
enum AddShareViewControllerType {
    case add,edite
}

class AddShareViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,WorkRequestVCDelegate,ContentTableViewCellDelegate,OptionViewDelgate,TitleTableViewCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var viewType : AddShareViewControllerType = .edite
    var id : String = ""


    var caseTypeArr : [casetypeModel] = []
    var sucessBlock : AddWorkViewControllerBlocl!
    /// 选项
    let optionView : OptionView = OptionView.loadNib()

    let requestVC = WorkRequestVC()
    var dStr : String = ""
    var nStr : String = ""
    var tStr : String = ""

    var tNameStr : String = ""

    var alertController : UIAlertController!

    var imageData : Data = Data()
    var imageStr : String = ""

    let mainTabelView : UITableView = UITableView()
    var fileArr : Array<String> = []
    var fileName : String = ""

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
                cell.setData_caseDetail(titleStr: "分类", contentStr: tNameStr)
            return cell
        } else if indexPath.row == 1 {
            let cell : TitleTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
            cell.delegate = self
            cell.setData_work(titleStr: "标题", congtentStr: nStr)
            return cell

        } else if indexPath.row == 2 {
            let cell : ContentTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
            cell.delegate = self
            cell.setData_work(title: "内容", contentCase: dStr)
            return cell
        } else {
            fileCell = tableView.dequeueReusableCell(withIdentifier: FileTableViewCellID, for: indexPath) as! FileTableViewCell
            fileCell.setData_fileName(fileName: fileName)
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

            self.showAlert()
            

//            let vc = FileViewController()
//            vc.hidesBottomBarWhenPushed = true
//            weak var weakself = self
//            vc.fileArrBlock = {(fileArr) in
//                let nameStr = fileArr[0]
//                weakself?.fileCell.setData_fileName(fileName: nameStr)
//                weakself?.fileArr = fileArr
//            }
//            self.navigationController?.pushViewController(vc, animated: true)
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
            make.height.equalTo(200)
        }
    }


    func requestSucceed_work(data: Any, type: WorkRequestVC_enum) {
        if type == .sharegettype {
            caseTypeArr = data as! [casetypeModel]
            self.showOptionPickView()
        } else {
            if viewType == .edite{
                let vc  = self.navigationController?.childViewControllers[1]
                self.navigationController?.popToViewController(vc!, animated: true)
            } else {
                self.sucessBlock()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    func requestFail_work() {

    }
    func optionSure(idStr: String, titleStr: String,noteStr : String, pickTag: Int) {
        self.tStr = idStr
        self.tNameStr = titleStr

        let cell : OptionTableViewCell = mainTabelView.cellForRow(at: IndexPath(row: 0, section: 0)) as! OptionTableViewCell
        cell.setOptionData(contentStr: titleStr)

        self.optionView.removeFromSuperview()
        self.maskView.removeFromSuperview()

    }
    func endText_content(content: String, tagNum: Int) {
        self.dStr = content
    }
    func endEdite(inputStr: String, tagNum: Int) {
        self.nStr = inputStr
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

        weak var weakSelf = self

        self.upLoad(type: "8", completion: { (data) in
            let str : String = data as! String
            if str.count > 0 {

                SVPMessageShow.dismissSVP()
                weakSelf?.requestVC.sharesavequest(id: self.id, n: self.nStr, t: self.tStr, d: self.dStr, f: str)
            } else {
                HCLog(message: "上传失败")
            }
        }) { (erro) in

            self.requestVC.sharesavequest(id: self.id, n: self.nStr, t: self.tStr, d: self.dStr, f: self.fileName)
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
