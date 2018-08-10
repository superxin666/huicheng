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

    var imageSize : CGSize!


    var requestVC : Work2RequestVC = Work2RequestVC()

    var selectedView : SelectedTableViewCell!



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
        webView = UIWebView(frame: CGRect(x: 0, y:LNAVIGATION_HEIGHT, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT - SelectedTableViewCellH))
        webView.backgroundColor = .white
        webView.scrollView.delegate = self
        webView.delegate = self
        webView.loadRequest(URLRequest(url: self.url))
        self.view.addSubview(webView)

        selectedView = SelectedTableViewCell(style: .default, reuseIdentifier: "123")
        selectedView.backgroundColor = .red
        selectedView.frame = CGRect(x: 0, y: webView.frame.maxY, width: KSCREEN_WIDTH, height: SelectedTableViewCellH)
        self.view.addSubview(selectedView)

    }

    @objc func getZhang() {
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

    @objc func saveClick() {
        HCLog(message: zhangImageView.frame)
        if  zhangImageView != nil {
            let teampX = imageSize.width/KSCREEN_WIDTH
            let xNum  = zhangImageView.frame.origin.x * teampX

            let teampY = KSCREEN_HEIGHT/imageSize.height
            let yNum = zhangImageView.frame.origin.y * teampY
            requestVC.delegate = self

            requestVC.doc_applysave(id: id, s: 3, n: "123", x: Int(xNum) * 2, y:Int(zhangImageView.frame.origin.y))
        }

    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }

    func requestSucceed_work2(data: Any, type: Work2RequestVC_enum) {
        self.navigationController?.popToRootViewController(animated: true)

    }

    func requestFail_work2() {

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
