//
//  SelectedImagesViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/8/27.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
typealias SelectedImagesViewControllerBlock = (_ imageNameArr : [String]) ->()
class SelectedImagesViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    /// 列表
    let mainTabelView : UITableView = UITableView()

    let nameArr : [String] = ["税务登记证","组织机构代码（副本）","开户许可证","营业执照（副本）","一般纳税人资格认定书",]
    let imageArr : [String] = ["请选择","请选择","请选择","请选择","请选择",]


    var image1Data : Data = Data()
    var image1Str : String = ""

    var image2Data : Data = Data()
    var image2Str : String = ""

    var image3Data : Data = Data()
    var image3Str : String = ""

    var image4Data : Data = Data()
    var image4Str : String = ""

    var image5Data : Data = Data()
    var image5Str : String = ""



    var currectIndex : Int = 0

    var sureBlock : SelectedImagesViewControllerBlock!



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

        self.navigation_title_fontsize(name: "相关附件", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
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
        mainTabelView.register(UINib.init(nibName: "Title8TableViewCell", bundle: nil), forCellReuseIdentifier: Title8TableViewCellID)
        self.view.addSubview(mainTabelView)
    }

    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : Title8TableViewCell!  = tableView.dequeueReusableCell(withIdentifier: Title8TableViewCellID, for: indexPath) as! Title8TableViewCell
        cell.setData(titleStr: nameArr[indexPath.row], contentSTr: imageArr[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currectIndex = indexPath.row
        self.openAlbum()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Title8TableViewCellH
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
//        if self.fileArr.count > 0 {
//            self.fileArr.removeAll()
//        }
        //获取选择的编辑后的
        let  image = info[UIImagePickerControllerOriginalImage] as! UIImage

        let nameStr = image.description
        HCLog(message: nameStr)
        if currectIndex == 0 {
            image1Data = UIImageJPEGRepresentation(image, 1.0)!

            self.uploadimage(imageData: image1Data, completion: { (data) in
                self.image1Str = data as! String
            }) { (erro) in

            }
        } else if currectIndex == 1 {
            image2Data = UIImageJPEGRepresentation(image, 1.0)!
            self.uploadimage(imageData: image2Data, completion: { (data) in
                self.image2Str = data as! String
            }) { (erro) in

            }

        } else if currectIndex == 2 {
            image3Data = UIImageJPEGRepresentation(image, 1.0)!
            self.uploadimage(imageData: image3Data, completion: { (data) in
                self.image3Str = data as! String
            }) { (erro) in

            }

        } else if currectIndex == 3 {
            image4Data = UIImageJPEGRepresentation(image, 1.0)!
            self.uploadimage(imageData: image4Data, completion: { (data) in
                self.image4Str = data as! String
            }) { (erro) in

            }
        } else {
            image5Data = UIImageJPEGRepresentation(image, 1.0)!
            self.uploadimage(imageData: image5Data, completion: { (data) in
                self.image5Str = data as! String
            }) { (erro) in

            }

        }

        let cell : Title8TableViewCell = self.mainTabelView.cellForRow(at: IndexPath(row: currectIndex, section: 0)) as! Title8TableViewCell
        cell.setData(titleStr: nameArr[currectIndex], contentSTr: "图片\(currectIndex + 1)")

        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in

            //显示图片
        })
    }



    // MARK: - event response
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }

    override func navigationRightBtnClick() {
        HCLog(message: "确定")
//        self.sureClick()
        self.sureBlock([self.image1Str,self.image2Str,self.image3Str,self.image4Str,self.image5Str])
        self.navigationLeftBtnClick()
    }

    func uploadimage(imageData : Data,completion : @escaping (_ data : Any) ->(), failure : @escaping (_ error : Any)->())  {
        SVPMessageShow.showLoad(title: "上传中")
        BaseNetViewController.uploadfile(fileName: "", t: "6",isFile: false,imageData: imageData, completion: { (data) in
            let model = data as! CodeData
            if model.code == 1 {
                HCLog(message: model.msg)
                SVPMessageShow.dismissSVP()
                SVPMessageShow.showSucess(infoStr: "上传成功~")
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
    }


    func sureClick() {
        SVPMessageShow.showLoad(title: "正在上传~~")
        let workItem1:DispatchWorkItem = DispatchWorkItem.init {
            if self.image1Data.count > 0 {
                self.uploadimage(imageData: self.image1Data, completion: { (data) in
                    self.image1Str = data as! String
                    HCLog(message: "第一个有数据上传完毕")
                }) { (erro) in

                }
            } else {
                HCLog(message: "第一个没有数据")
            }
        }
        let workItem2:DispatchWorkItem = DispatchWorkItem.init {
            if self.image2Data.count > 0 {
                self.uploadimage(imageData: self.image2Data, completion: { (data) in
                    self.image2Str = data as! String
                    HCLog(message: "第2个有数据上传完毕")
                }) { (erro) in

                }
            } else {
                HCLog(message: "第2个没有数据")
            }
        }

        let workItem3:DispatchWorkItem = DispatchWorkItem.init {
            if self.image3Data.count > 0 {
                self.uploadimage(imageData: self.image3Data, completion: { (data) in
                    self.image3Str = data as! String
                    HCLog(message: "第3个有数据上传完毕")
                }) { (erro) in

                }
            } else {
                HCLog(message: "第3个没有数据")
            }
        }

        let workItem4:DispatchWorkItem = DispatchWorkItem.init {
            if self.image4Data.count > 0 {
                self.uploadimage(imageData: self.image4Data, completion: { (data) in
                    self.image4Str = data as! String
                    HCLog(message: "第4个有数据上传完毕")
                }) { (erro) in

                }
            } else {
                HCLog(message: "第4个没有数据")
            }
        }
        let workItem5:DispatchWorkItem = DispatchWorkItem.init {
            if self.image5Data.count > 0 {
                self.uploadimage(imageData: self.image5Data, completion: { (data) in
                    self.image5Str = data as! String
                    HCLog(message: "第5个有数据上传完毕")
                }) { (erro) in

                }
            } else {
                HCLog(message: "第5个没有数据")
            }
        }


        let queue:DispatchQueue = DispatchQueue(label: "processQueueName", attributes: .concurrent)
        let group:DispatchGroup = DispatchGroup.init()
        queue.async(group: group, execute: workItem1)
        queue.async(group: group, execute: workItem2)
        queue.async(group: group, execute: workItem3)
        queue.async(group: group, execute: workItem4)
        queue.async(group: group, execute: workItem5)

        group.notify(queue: queue) {


            DispatchQueue.main.async{
                HCLog(message: "任务全部完成")
                SVPMessageShow.dismissSVP()
                self.sureBlock([self.image1Str,self.image2Str,self.image3Str,self.image4Str,self.image5Str])

                self.navigationLeftBtnClick()

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
