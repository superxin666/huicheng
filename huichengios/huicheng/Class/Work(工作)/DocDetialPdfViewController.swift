//
//  DocDetialPdfViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/8/9.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class DocDetialPdfViewController: BaseViewController,UIPrintInteractionControllerDelegate,Work2RequestVCDelegate,UIWebViewDelegate,UIScrollViewDelegate {


    var id : Int!

    var webView : UIWebView!

    var url : URL!

    var zhang : String!

    var zhangImageView : UIImageView!

    var requestVC : Work2RequestVC = Work2RequestVC()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.navigation_title_fontsize(name: "函件详情", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        let iteam1 = self.getUIBarButtonItem_title(title: "取章", action: #selector(getZhang), vc: self)
        let iteam2 = self.getUIBarButtonItem_title(title: "保存", action: #selector(saveClick), vc: self)




        self.navigationItem.rightBarButtonItems = [iteam2,iteam1]

        HCLog(message: url!)
        webView = UIWebView(frame: CGRect(x: 0, y:LNAVIGATION_HEIGHT, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT))
        webView.backgroundColor = .white
        webView.scrollView.delegate = self
        webView.loadRequest(URLRequest(url: self.url))
        self.view.addSubview(webView)

    }

    @objc func getZhang() {

    }

    @objc func saveClick() {

    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }

    func requestSucceed_work2(data: Any, type: Work2RequestVC_enum) {


    }

    func requestFail_work2() {

    }

    func webViewDidStartLoad(_ webView: UIWebView) {
        SVPMessageShow.showLoad()

    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVPMessageShow.dismissSVP()

    }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVPMessageShow.dismissSVP()

        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {



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
