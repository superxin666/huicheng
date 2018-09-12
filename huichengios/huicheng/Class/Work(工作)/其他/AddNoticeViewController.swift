//
//  AddNoticeViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/4/1.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
enum AddNoticeViewController_type {
//    添加  详情  编辑
    case addNotice,detail,edit
}
typealias AddNoticeViewControllerBlock = ()->()

class AddNoticeViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,WorkRequestVCDelegate,MessageRequestVCDelegate,OptionViewDelgate,TitleTableViewCellDelegate,ContentTableViewCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    let mainTabelView : UITableView = UITableView()
    let request : WorkRequestVC = WorkRequestVC()
    let messageRequest : MessageRequestVC = MessageRequestVC()
    
    /// 选项
    let optionView : OptionView = OptionView.loadNib()

    /// 类型
    var type : AddNoticeViewController_type!
    /// 详情id
    var detailId : Int!
    
    /// 详情数据模型
    var detailModel : newsdetialModel!

    /// 接受对象id
    var objectID  = ""
    var objectStr = ""


    /// 标题
    var titleStr = ""
    var contentStr = ""



    
    var titleCell : TitleTableViewCell!
    var contentCell : ContentTableViewCell!
    var fileCell : FileTableViewCell!
    var objectCell :OptionTableViewCell!
    var messageCell : MessageNeedTableViewCell!
    
    var alertController : UIAlertController!

    
    /// 操作 0撤回 1发布 2修改 3删除
    var actionNum : Int!
    
    var reflishBlock : AddNoticeViewControllerBlock!
    
    var rowNum = 5

    var fileArr : Array<String> = []


    var imageData : Data = Data()


    var objectArr : [getobjectlistModel] = []

    var fileName = ""



    
    
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
        request.delegate = self
        messageRequest.delegate = self
        request.getobjectlistRequest()

        if type == .addNotice{
            self.navigation_title_fontsize(name: "发布公告", fontsize: 18)
            self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
            self.navigationBar_rightBtn_title(name: "确定")
            rowNum = 5
            
            
        } else {
            self.navigation_title_fontsize(name: "公告查看", fontsize: 18)
            self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
            self.navigationBar_rightBtn_title(name: "操作")
            messageRequest.newsdetialRequest(id: detailId)
            rowNum = 4
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
        mainTabelView.register(UINib.init(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: OptionTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "MessageNeedTableViewCell", bundle: nil), forCellReuseIdentifier: MessageNeedTableViewCellID)
        self.view.addSubview(mainTabelView)
    }
    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if self.type == .detail {
//            return 4
//        } else {
//            return 5
//        }
         return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            titleCell  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell

            titleCell.setData_noticeDetail(titleStr: "公告标题", contentStr: titleStr)
            titleCell.delegate = self
            if type == .detail{
                titleCell.isUserInteractionEnabled = false
            } else {
                titleCell.isUserInteractionEnabled = true
            }

            return titleCell
        } else if indexPath.row == 1 {
            contentCell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCellID, for: indexPath) as! ContentTableViewCell
            contentCell.delegate =  self

            contentCell.setData_notice(contentStr: contentStr)
            if type == .detail{
                contentCell.isUserInteractionEnabled = false
            } else {
                contentCell.isUserInteractionEnabled = true
            }

            return contentCell
        } else if indexPath.row == 2{
            fileCell = tableView.dequeueReusableCell(withIdentifier: FileTableViewCellID, for: indexPath) as! FileTableViewCell
            if type == .detail{
                fileCell.setData_fileName(fileName: fileName)
            }
            return fileCell
        } else if indexPath.row == 3 {
            objectCell  = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCellID, for: indexPath) as! OptionTableViewCell

            objectCell.setDataObject(titleStr: "接受对象", contentStr: objectStr)
            if type == .detail{
                objectCell.isUserInteractionEnabled = false
            } else {
                objectCell.isUserInteractionEnabled = true
            }

            return objectCell
        } else {
            messageCell  = tableView.dequeueReusableCell(withIdentifier: MessageNeedTableViewCellID, for: indexPath) as! MessageNeedTableViewCell
            if type == .detail{
                messageCell.isUserInteractionEnabled = false
            } else {
                messageCell.isUserInteractionEnabled = true
            }
            return messageCell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.type == .addNotice || self.type == .edit {
            if indexPath.row == 2 {
                self.showAlert()
            } else if indexPath.row == 3 {
                
                self.showOptionView_state()
            }
        } else if type == .detail{
            if indexPath.row == 2 {
                if detailModel.attachment.count > 0 {
                    let vc : ReadPdfViewController = ReadPdfViewController()
                    vc.type = .other
                    vc.url = URL(string:base_imageOrFile_api + "/" + detailModel.attachment!)
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
        } else if indexPath.row == 2{
            return FileTableViewCellH
        } else if indexPath.row == 3 {
            return ObjectTableViewCellH
        } else {
            return MessageNeedTableViewCellH
        }
    }

    func endEdite(inputStr: String, tagNum: Int) {
        titleStr = inputStr
    }
    func endText_content(content: String, tagNum: Int) {
        contentStr = content
    }

    func showOptionView_state() {
        self.maskView.addSubview(self.optionView)
        self.view.window?.addSubview(self.maskView)
        self.optionView.setDataObject(dataArr: objectArr)

        self.optionView.delegate = self
        self.optionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(200)
        }
    }

    func optionSure(idStr: String, titleStr: String, noteStr: String, pickTag: Int) {
        objectID = idStr
        self.maskView.removeFromSuperview()
        self.optionView.removeFromSuperview()
        objectCell.setOptionData(contentStr: titleStr)

    }


    // MARK: - net

    func requestSucceed_work(data: Any, type: WorkRequestVC_enum) {
        SVPMessageShow.dismissSVP()
        if type == .getobjectlist {
            //获取对象
            let arr : [getobjectlistModel] = data as! [getobjectlistModel]
            objectArr = arr

            
        } else if type == .save || type == .newspublic || type == .del{
            //添加  发布 撤销 删除
            let model : CodeData = data as! CodeData
            if model.code == 1 {
              self.reflishBlock()
              self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func requestFail_work() {
        
    }
    
    
    func requestSucceed_message(data: Any) {

    //获取详情
        let model : newsdetialModel = data as! newsdetialModel
        detailModel = model

        titleStr = model.title
        contentStr = model.content

        objectID = "\(model.objectid!)"
        objectStr = model.object!

        fileName = model.attachment.components(separatedBy: "//").last!

        self.mainTabelView.reloadData()



    }
    
    func requestFail_message() {
        
    }
    
    
    
    func publishRequest()  {
        request.newspublicRequest(id: self.detailId, s: 1)
        
    }
    
    func recallRequest() {
        request.newspublicRequest(id: self.detailId, s: 2)

    }
    
    func deleRequest() {
        request.delRequest(id: self.detailId)
    }
    
    func editeRequest() {
        
        self.addRequest()
    }
    
    func addRequest()  {
        self.view.endEditing(true)
        
        if !(titleStr.count > 0 ){
            SVPMessageShow.showErro(infoStr: "请输入标题")
            return
        }
        if !(contentStr.count > 0 ){
            SVPMessageShow.showErro(infoStr: "请输入内容")
            return
        }
        if !(objectID.count > 0) {
            SVPMessageShow.showErro(infoStr: "请选择接受对象")
            return
        }
        //o: objectCell.cuurectID

        SVPMessageShow.showLoad(title:"发布中~~")
        if let id = detailId {
            request.saveRequest(id: "\(id)", t: titleStr, n: contentStr, o: objectID, s: 0, d: messageCell.need, f: fileName)
        } else {

            self.upLoad(type: "7", completion: { (data) in
                let str : String = data as! String
                if str.count > 0 {
                    self.request.saveRequest(id: "", t: self.titleCell.conTent, n: self.contentCell.conTent, o: self.objectID, s: 0, d: self.messageCell.need, f: str)
                } else {
                    HCLog(message: "上传失败")

                }

            }) { (erro) in
                self.request.saveRequest(id: "", t: self.titleCell.conTent, n: self.contentCell.conTent, o: self.objectID, s: 0, d: self.messageCell.need, f: "")
            }
        }
    }
    
    
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        if type == .addNotice{
 
            self.addRequest()
            
        } else if type == .edit{
            self.editeRequest()

        } else {
            HCLog(message: "操作")
            weak var weakself = self
            if detailModel.state == 1 {
                //已经发布 只有撤回
                alertController = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
                let sureAction = UIAlertAction(title: "撤回", style: .default) { (action) in
                    HCLog(message: "撤回")
                    weakself?.actionNum = 0
                    weakself?.showSure()
                    
                }
                let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
                    self.alertController.dismiss(animated: true, completion: {
                        
                    })
                }
                alertController.addAction(cancleAction)
                alertController.addAction(sureAction)
                self.present((alertController)!, animated: true, completion: nil)

                
            } else {
                //未发布 已经撤回  发布 修改 删除
                alertController = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
                
                
                let action1 = UIAlertAction(title: "发布", style: .default) { (action) in
                    HCLog(message: "发布")
                    weakself?.actionNum = 1
                    weakself?.showSure()
                    
                    
                }
                let action2 = UIAlertAction(title: "修改", style: .default) { (action) in
                    HCLog(message: "修改")
                    weakself?.actionNum = 2
                    weakself?.showSure()

                }
                let action3 = UIAlertAction(title: "删除", style: .default) { (action) in
                    HCLog(message: "删除")
                    weakself?.actionNum = 3
                    weakself?.showSure()
                }
                let action4 = UIAlertAction(title: "取消", style: .cancel) { (action) in
                    self.alertController.dismiss(animated: true, completion: {
                        
                    })

                }
                alertController.addAction(action1)
                alertController.addAction(action2)
                alertController.addAction(action3)
                alertController.addAction(action4)
                self.present((alertController)!, animated: true, completion: nil)

            }
            
            
        }
    }
    
    func showSure() {
        alertController =  UIAlertController(title: nil, message: "确定要操作吗", preferredStyle: .alert)
        let sureAction = UIAlertAction(title: "确定", style: .default) { (action) in
            HCLog(message: "确定")
            if self.actionNum == 0 {
                //撤回
                self.recallRequest()
                
            } else if self.actionNum == 1 {
                //发布
                self.publishRequest()
                
            } else if self.actionNum == 2 {
                //编辑
                self.rowNum = 5
                self.type = .edit
                self.navigationBar_rightBtn_title(name: "确定")
                self.mainTabelView.isUserInteractionEnabled = true


                self.mainTabelView.reloadData()
               
            } else {
                //删除
                self.deleRequest()
                
            }
            
        }
        let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            self.alertController.dismiss(animated: true, completion: {
                HCLog(message: "取消")
            })
        }
        alertController.addAction(cancleAction)
        alertController.addAction(sureAction)
        self.present((alertController)!, animated: true, completion: nil)
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
