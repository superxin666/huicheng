


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
    case other;
    case save
}

typealias ReadPdfViewControllerBlock = ()->()

class ReadPdfViewController: BaseViewController,UIPrintInteractionControllerDelegate,Work2RequestVCDelegate,UIWebViewDelegate,UIScrollViewDelegate {

    var type : ReadPdfViewControllerType = .other
    
    var id : Int!

    var webView : UIWebView!

    var url : URL!

    var zhang : String!

    var zhangImageView : UIImageView!


    var alertController : UIAlertController!

    ///  0-未审核;1-已审核;2-审核驳回;3-已盖章
    var pdfstate : Int!

    var requestVC : Work2RequestVC = Work2RequestVC()

    var delDocSucessBlock : ReadPdfViewControllerBlock!

    var titleStr = "函件详情"

    var imageSize : CGSize!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.navigation_title_fontsize(name: titleStr, fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        if type == .tabIteam {
            self.navigationBar_rightBtn_title(name: "操作")
        }
        HCLog(message: url!)
        webView = UIWebView(frame: CGRect(x: 0, y:LNAVIGATION_HEIGHT, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT))
        webView.backgroundColor = .white
        webView.scrollView.delegate = self
        webView.delegate = self
        webView.loadRequest(URLRequest(url: self.url))
        self.view.addSubview(webView)

    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }


    override func navigationRightBtnClick() {
        HCLog(message: "操作")
        if type == .save {
            HCLog(message: "保存印章")
            if  zhangImageView != nil {
                let teampX = KSCREEN_WIDTH/imageSize.width
                let xNum  = zhangImageView.frame.origin.x * teampX


                let yNum = zhangImageView.frame.origin.y * teampX
                requestVC.delegate = self
                requestVC.doc_applysave(id: id, s: "", n: "", x: Int(xNum) * 2, y:Int(yNum) * 2)
            }
            

        } else {
            if pdfstate == 3 {//3
                //已经盖章 可打印
                alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                let delAction = UIAlertAction(title: "打印", style: .default) { (action) in
                    HCLog(message: "打印")

                    let printVC : UIPrintInteractionController = UIPrintInteractionController.shared
                    printVC.delegate = self



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
                    self.type = .save
                    self.navigationBar_rightBtn_title(name: "保存")
                    self.gaizhang()
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
    }

    func requestSucceed_work2(data: Any, type: Work2RequestVC_enum) {
        if type == .doc_del || type == .doc_applysave {
            self.delDocSucessBlock()
            self.navigationLeftBtnClick()
        }
    }


    func requestFail_work2() {

    }

    func gaizhang()  {
        if let str  = zhang{
            zhangImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: ip6(75), height: ip6(75)))
            zhangImageView.isUserInteractionEnabled = true
            let imageUrl = base_imageOrFile_api + str
            self.zhangImageView.kf.setImage(with:URL(string: imageUrl))
            webView.addSubview(zhangImageView)

            let tap : UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(zhangClick(sender:)))
            zhangImageView.addGestureRecognizer(tap)
        }
    }

    func webViewDidStartLoad(_ webView: UIWebView) {
        SVPMessageShow.showLoad()

    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVPMessageShow.dismissSVP()
        imageSize = webView.sizeThatFits(CGSize.zero)
        HCLog(message: imageSize)

    }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVPMessageShow.dismissSVP()
    }



    func scrollViewDidScroll(_ scrollView: UIScrollView) {


        
    }


    @objc func zhangClick(sender : UIPanGestureRecognizer) {
        let view = sender.view

        if sender.state == .began || sender.state == .changed {
            let point : CGPoint = sender.translation(in:webView)
            HCLog(message: point.x)
            HCLog(message: point.y)
            view?.center = CGPoint(x: (view?.center.x)! + point.x, y: (view?.center.y)! + point.y)
            sender.setTranslation(CGPoint(x:0,y:0), in: webView)
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
