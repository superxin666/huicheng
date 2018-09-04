//
//  FileViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/5/11.
//  Copyright © 2018年 lvxin. All rights reserved.
//  文件列表

import UIKit
typealias FileViewControllerBlock = ([String])->()

class FileViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    var fileArrBlock : FileViewControllerBlock!

    let mainTabelView : UITableView = UITableView()

    var alertController : UIAlertController!

    var fileManager = FileManager.default
    var fileArr :[String]  = Array()
    var selectedFileArr : [String] = Array()

    var fileTage : Int!



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

        self.navigation_title_fontsize(name: "文件列表", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.navigationBar_rightBtn_title(name: "确定")
        self.getFileData()
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
        mainTabelView.register(UINib.init(nibName: "FileListTableViewCell", bundle: nil), forCellReuseIdentifier: FileListTableViewCellID)
        self.view.addSubview(mainTabelView)
    }
    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fileArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : FileListTableViewCell  = tableView.dequeueReusableCell(withIdentifier: FileListTableViewCellID, for: indexPath) as! FileListTableViewCell
        if indexPath.row < self.fileArr.count {
            let name  = self.fileArr[indexPath.row]

            cell.setData(titleStr: name)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row  < self.fileArr.count {
            fileTage = indexPath.row
            let str = self.fileArr[indexPath.row]
            let urlStr : String = filePath + "/" + str
            let vc = ReadFileViewController()
            vc.fileUrl = urlStr
            vc.jump(vc: self)
        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FileListTableViewCellH
    }


    func getFileData() {


        if fileManager.fileExists(atPath: filePath) {
            let contentsOfPath = try? fileManager.contentsOfDirectory(atPath: filePath)
            self.fileArr = contentsOfPath!
            self.mainTabelView.reloadData()
        } else {
            HCLog(message: "文件夹不存在")
        }
    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        var  arr : [String] = []
        if let tag = fileTage {
            arr.append(fileArr[tag])
            self.fileArrBlock(arr)
            self.navigationController?.popViewController(animated: true)
        } else {
            SVPMessageShow.showErro(infoStr: "请选择文件")
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
