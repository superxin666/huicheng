


//
//  ShareDetailViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/6/3.
//  Copyright © 2018年 lvxin. All rights reserved.
//  共享模板详情

import UIKit

class ShareDetailViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,WorkRequestVCDelegate,UITextViewDelegate {
    let mainTabelView : UITableView = UITableView()
    let requestVC = WorkRequestVC()
    var shareID : Int!

    var dataArr : [sharegetreplyModel] = []
    var dataModel : sharegetinfoModel = sharegetinfoModel()


    var comBtn : UIButton!

    let txtTextView : UITextView = UITextView()
    var txtTextViewBack : UIView!
    var txt : String = ""


    // MARK: - life
    override func viewWillLayoutSubviews() {
        mainTabelView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(0)
            make.left.right.equalTo(self.view).offset(0)
            make.height.equalTo(KSCREEN_HEIGHT - 45)
        }

        comBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view).offset(0)
            make.left.right.equalTo(self.view).offset(0)
            make.height.equalTo(45)
        
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        let userinfo: NSDictionary = notification.userInfo! as NSDictionary
        let nsValue = userinfo.object(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRec = nsValue.cgRectValue
        let height = keyboardRec.size.height
        if !(txtTextViewBack == nil) {
            var frame = self.txtTextViewBack.frame
            frame.origin.y = KSCREEN_HEIGHT - height - ip6(260)
            self.txtTextViewBack.frame = frame
            print("keybordShow:\(height)")
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        self.navigation_title_fontsize(name: "共享模板信息", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.creatUI()
        self.requestApi()
    }
    // MARK: - UI
    func creatUI() {
        mainTabelView.backgroundColor = viewBackColor
        mainTabelView.delegate = self;
        mainTabelView.dataSource = self;
        mainTabelView.tableFooterView = UIView()
        mainTabelView.separatorStyle = .none
        mainTabelView.showsVerticalScrollIndicator = false
        mainTabelView.showsHorizontalScrollIndicator = false
        mainTabelView.backgroundView?.backgroundColor = .clear
        mainTabelView.register(UINib.init(nibName: "Title6TableViewCell", bundle: nil), forCellReuseIdentifier: Title6TableViewCellID)
        mainTabelView.register(UINib.init(nibName: "Content2TableViewCell", bundle: nil), forCellReuseIdentifier: Content2TableViewCellID)
        mainTabelView.register(UINib.init(nibName: "FileTableViewCell", bundle: nil), forCellReuseIdentifier: FileTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "Title7TableViewCell", bundle: nil), forCellReuseIdentifier: Title7TableViewCellID)
        self.view.addSubview(mainTabelView)

        //添加按钮
        comBtn = UIButton(type: .custom)
        comBtn.setTitle("回复", for: .normal)
        comBtn.setTitleColor(darkblueColor, for: .normal)
        comBtn.backgroundColor = UIColor.white
        comBtn.addTarget(self, action: #selector(replayclick), for: .touchUpInside)
        self.view.addSubview(comBtn)

    }
    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return dataArr.count
        }

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell : Title6TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title6TableViewCellID, for: indexPath) as! Title6TableViewCell
                cell.setData_share(model: dataModel)
                return cell
            } else if indexPath.row == 1 {
                let cell : Content2TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Content2TableViewCellID, for: indexPath) as! Content2TableViewCell
                if let str = dataModel.content {
                    cell.setData_shareDetail(content: str)
                }
                return cell
            } else {
                let cell : FileTableViewCell  = tableView.dequeueReusableCell(withIdentifier: FileTableViewCellID, for: indexPath) as! FileTableViewCell
                cell.setData_fileName(fileName: "")
                return cell
            }
        } else {
            let cell : Title7TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title7TableViewCellID, for: indexPath) as! Title7TableViewCell
            if indexPath.row < self.dataArr.count {
                let model : sharegetreplyModel = self.dataArr[indexPath.row]
                cell.setData_share(model: model)
            }
            return cell

        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView()
        } else {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 20))
            view.backgroundColor = viewBackColor


            let label = UILabel(frame: CGRect(x: 10, y: 0, width: ip6(200), height: 20))
            label.text = "回复信息"
            label.textColor = UIColor.hc_colorFromRGB(rgbValue: 0x333333)
            label.font = hc_fontThin(13)
            
            view.addSubview(label)
            return view
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 20
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0{
                return Title6TableViewCellH
            } else if indexPath.row == 1 {
                return Content2TableViewCellH
            } else {
                return FileTableViewCellH
            }
        } else {
            return Title7TableViewCellH
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 2 {
                HCLog(message: "点击文件")
                
                let vc = ReadPdfViewController()
                vc.url = URL(string: base_imageOrFile_api + dataModel.path!)
                self.navigationController?.pushViewController(vc, animated: true)


            }
        }
    }

    //MARK:textView
    func textViewDidEndEditing(_ textView: UITextView) {
        txt = textView.text
    }

    // MARK: - net
    func requestApi() {
        SVPMessageShow.showLoad()
        requestVC.delegate = self
        requestVC.sharegetinfoRequest(id: shareID!)
    }

    func requestApi_sharegetreplyRequest() {
        self.requestVC.sharegetreplyRequest(id: self.shareID)
    }


    func requestSucceed_work(data: Any,type : WorkRequestVC_enum) {
        if type == .sharegetinfo {
            dataModel = data as! sharegetinfoModel
            self.requestApi_sharegetreplyRequest()

            mainTabelView.reloadSections([0], with: .automatic)

        } else if type == .sharegetreply{
            SVPMessageShow.dismissSVP()

            dataArr = data as! [sharegetreplyModel]
            mainTabelView.reloadSections([1], with: .automatic)

        } else if type == .sharereplysave {
            SVPMessageShow.showSucess(infoStr: "添加成功")
            self.dismissTxtView()
            if self.dataArr.count > 0 {
                self.dataArr.removeAll()
            }
            self.requestApi_sharegetreplyRequest()
        }
    }

    func requestFail_work() {

    }


    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func replayclick() {
        self.view.window?.addSubview(self.maskView)
        self.creatTxtUI()
        txtTextView.becomeFirstResponder()
    }


    func dismissTxtView() {
        self.txtTextViewBack.removeFromSuperview()
        txtTextView.resignFirstResponder()
        self.maskView.removeFromSuperview()
    }

    @objc func cancle_submitcomment() {
        self.dismissTxtView()
    }

    @objc func sure_submitcomment() {
        self.txtTextView.endEditing(true)
        requestVC.sharereplysaveRequest(id: self.shareID, n: txt)

    }

    //MARK:留言页面
    func creatTxtUI() {

        self.txtTextViewBack  = UIView(frame: CGRect(x: 0, y:  0, width: KSCREEN_WIDTH, height: ip6(260)))
        self.txtTextViewBack.backgroundColor = .white
        self.maskView.addSubview(self.txtTextViewBack)

        txtTextView.delegate = self
        txtTextView.text = ""
        txtTextView.frame = CGRect(x: ip6(20), y: ip6(20), width: KSCREEN_WIDTH - ip6(40), height: ip6(327/2))
        txtTextView.font = hc_fontThin(ip6(18))

        txtTextView.textColor = UIColor.hc_colorFromRGB(rgbValue: 0x333333)
        txtTextView.hc_makeBorderWithBorderWidth(width: 1, color: UIColor.hc_colorFromRGB(rgbValue: 0x666666))
        txtTextView.hc_makeRadius(radius: 7)
        self.txtTextViewBack.addSubview(txtTextView)

        //取消按钮
        let cancleBtn : UIButton = UIButton(frame: CGRect(x: ip6(20),y: txtTextView.frame.maxY + ip6(14), width: ip6(189/2),height: ip6(50)))
        cancleBtn.setTitle("取消", for: .normal)
        cancleBtn.backgroundColor = UIColor.hc_colorFromRGB(rgbValue: 0x8cd815)
        cancleBtn.setTitleColor( .white, for: .normal)
        cancleBtn.titleLabel?.font =  hc_fontThin(ip6(21))
        cancleBtn.hc_makeRadius(radius: 7)
        cancleBtn.addTarget(self, action:#selector(self.cancle_submitcomment), for: .touchUpInside)
        self.txtTextViewBack.addSubview(cancleBtn)
        //确定按钮

        let sureBtn : UIButton = UIButton(frame: CGRect(x: KSCREEN_WIDTH - ip6(20) - ip6(289/2),y: txtTextView.frame.maxY + ip6(14), width: ip6(289/2),height: ip6(50)))
        sureBtn.setTitle("发表评论", for: .normal)
        sureBtn.backgroundColor = UIColor.hc_colorFromRGB(rgbValue: 0x15a5ea)
        sureBtn.setTitleColor( .white, for: .normal)
        sureBtn.titleLabel?.font = hc_fontThin(ip6(21))
        sureBtn.hc_makeRadius(radius: 7)
        sureBtn.addTarget(self, action:#selector(self.sure_submitcomment), for: .touchUpInside)
        self.txtTextViewBack.addSubview(sureBtn)

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
