


//
//  ReadPdfViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/8/5.
//  Copyright © 2018年 lvxin. All rights reserved.
//  web浏览pdf文件

import UIKit

enum ReadPdfViewControllerType {
    case tabIteam;
    case other
}

typealias ReadPdfViewControllerBlock = ()->()

class ReadPdfViewController: BaseViewController,UIPrintInteractionControllerDelegate,Work2RequestVCDelegate {

    var type : ReadPdfViewControllerType = .other
    
    var id : Int!

    var webView : UIWebView!

    var url : URL!

    var alertController : UIAlertController!

    ///  0-未审核;1-已审核;2-审核驳回;3-已盖章
    var pdfstate : Int!

    var requestVC : Work2RequestVC = Work2RequestVC()

    var delDocSucessBlock : ReadPdfViewControllerBlock!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.navigation_title_fontsize(name: "函件详情", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        if type == .tabIteam {
            self.navigationBar_rightBtn_title(name: "操作")
        }
        HCLog(message: url!)
        webView = UIWebView(frame: CGRect(x: 0, y:LNAVIGATION_HEIGHT, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT))
        webView.backgroundColor = .white

        webView.loadRequest(URLRequest(url: self.url))

        self.view.addSubview(webView)

    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }


    override func navigationRightBtnClick() {
        HCLog(message: "操作")
        if pdfstate == 3 {//3
            //已经盖章 可打印
            alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let delAction = UIAlertAction(title: "打印", style: .default) { (action) in
                HCLog(message: "打印")

                let printVC : UIPrintInteractionController = UIPrintInteractionController.shared
                printVC.delegate = self

//                let printInfo : UIPrintInfo = UIPrintInfo()
//                printInfo.outputType = .general

                printVC.showsPageRange = false
                printVC.printFormatter = self.webView.viewPrintFormatter()

                printVC.present(animated: true, completionHandler: { (printController, completed, erro) in
                    if !completed {
                        HCLog(message: "无法完成打印")

                    }
                })


            }


            let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
                self.alertController.dismiss(animated: true, completion: {

                })
            }
            alertController.addAction(cancleAction)
            alertController.addAction(delAction)
            self.present((alertController)!, animated: true, completion: nil)


        } else if pdfstate == 0 {//0
            //未审核 可删除
            alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let delAction = UIAlertAction(title: "删除", style: .default) { (action) in
                HCLog(message: "删除")
                self.requestVC.delegate = self
                self.requestVC.docdelRequset(id: "\(self.id!)")

            }


            let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
                self.alertController.dismiss(animated: true, completion: {

                })
            }
            alertController.addAction(cancleAction)
            alertController.addAction(delAction)
            self.present((alertController)!, animated: true, completion: nil)

        } else {
            alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let delAction = UIAlertAction(title: "盖章", style: .default) { (action) in
                HCLog(message: "盖章")
            }


            let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
                self.alertController.dismiss(animated: true, completion: {

                })
            }
            alertController.addAction(cancleAction)
            alertController.addAction(delAction)
            self.present((alertController)!, animated: true, completion: nil)

        }
    }

    func requestSucceed_work2(data: Any, type: Work2RequestVC_enum) {
        if type == .doc_del {
            self.delDocSucessBlock()
            self.navigationLeftBtnClick()
        }
    }

    func requestFail_work2() {

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
