//
//  AppDelegate.swift
//  huicheng
//
//  Created by lvxin on 2018/2/22.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    var window: UIWindow?
    var tab : UITabBarController!
    var fileManager = FileManager.default

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if UserInfoLoaclManger.getKey().count > 0 {
            self.showMain()
        } else {
            self.showLogin()
        }
        self.setUpUmeng(launchOptions: launchOptions)
        IQKeyboardManager.shared.enable = true
        return true
    }


    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        HCLog(message: application)
        self.getfile(url: url)
        return true
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        HCLog(message: application)
        self.getfile(url: url)
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        HCLog(message: app)
        self.getfile(url: url)
        return true
    }
    //MARK:文件导入
    func getfile(url : URL)  {

        HCLog(message: url)
        let str2 = url.absoluteString
        let str3 :String = str2.removingPercentEncoding!
        let arr = str3.components(separatedBy: "/")
        let nameStr = arr.last
        HCLog(message: nameStr!)

        if (self.window != nil) {
            if fileManager.fileExists(atPath: filePath) {
                HCLog(message: "文件夹已存在")
            } else {
                HCLog(message: "创建文件夹")
                do {
                    try fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
                } catch _ {
                    HCLog(message: "创建文件夹失败")
                }
            }
            let fileData = NSData(contentsOf: url)
            let filePathStr : String = filePath + "/" + nameStr!
            let isok =  fileData?.write(toFile: filePathStr, atomically: true)
            if let _ = isok {
                HCLog(message: "文件保存成功")
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadFile"), object: nil)
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "gorelease"), object: nil)

            } else {
                HCLog(message: "文件保存失败")
            }

            do {
                try fileManager.removeItem(at: url)
                HCLog(message: "源文件删除成功")
            } catch _ {
                HCLog(message: "源文件删除失败")
            }

        }
    }
    //MARK:tab
    /// 显示登录
    func showLogin()  {
        let vc = LogInViewController()
        self.window?.rootViewController = vc
    }
    
    /// tab
    func showMain()  {
        //消息
        let mesVc :MessageViewController = MessageViewController()
        let mesNv :UINavigationController = HCNavigationController(rootViewController: mesVc)
        let item1:UITabBarItem = UITabBarItem(title:"消息", image:#imageLiteral(resourceName: "mes_tab_nor").withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "mes_tab_sel").withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        mesNv.tabBarItem = item1
        
        //工作
        let workVc :Work2ViewController = Work2ViewController()
        let workNv :UINavigationController = HCNavigationController(rootViewController: workVc)
        let item2:UITabBarItem = UITabBarItem(title:"工作", image:#imageLiteral(resourceName: "work_tab_nor").withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "work_tab_sel").withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        workNv.tabBarItem = item2
        
        //便捷
        let convenVc :ConvenViewController = ConvenViewController()
        let convenNv :UINavigationController = HCNavigationController(rootViewController: convenVc)
        let item3:UITabBarItem = UITabBarItem(title:"便捷", image:#imageLiteral(resourceName: "con_tab_nor").withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "con_tab_sel").withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        convenNv.tabBarItem = item3
        
        //我的
        let minVc :MineViewController = MineViewController()
        let minNv :UINavigationController = HCNavigationController(rootViewController: minVc)
        let item4:UITabBarItem = UITabBarItem(title:"个人中心", image:#imageLiteral(resourceName: "mine_tab_nor").withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "mine_tab_sel").withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        minNv.tabBarItem = item4
        
        
        
        let vcArr = [mesNv,workNv,convenNv,minNv]
        tab = UITabBarController()
//        tab.tabBar.barTintColor = blue_COLOUR
        tab.delegate = self
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.hc_colorFromRGB(rgbValue: 0x5B6679)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.hc_colorFromRGB(rgbValue: 0xff6900)], for: .selected)
        tab.viewControllers = vcArr
        self.window?.rootViewController = tab
    }
    //MARK:友盟
    func setUpUmeng(launchOptions : [UIApplicationLaunchOptionsKey: Any]?) {
        UMConfigure.initWithAppkey(umemgKey, channel: "惠诚")

        UMConfigure.deviceIDForIntegration()
        let entity : UMessageRegisterEntity = UMessageRegisterEntity()

        entity.types = Int(UInt8(UMessageAuthorizationOptions.alert.rawValue) | UInt8(UMessageAuthorizationOptions.badge.rawValue)|UInt8(UMessageAuthorizationOptions.sound.rawValue))

        UMessage.registerForRemoteNotifications(launchOptions: launchOptions, entity: entity) { (granted, error) in
            if (granted) {

            } else {

            }
        }

    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let device = NSData(data: deviceToken)
        let deviceId = device.description.replacingOccurrences(of:"<", with:"").replacingOccurrences(of:">", with:"").replacingOccurrences(of:" ", with:"")
        HCLog(message: "token：")
        print(deviceId)
    }


    //MARK:友盟推送代理
    //iOS10以下使用这两个方法接收通知，
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        application.applicationIconBadgeNumber = 0        // 标签

        print(userInfo)

//        guard  let payloadStr : String = userInfo["payload"] as? String else {
//            return
//        }
//        KFBLog(message: "payloadStr " + payloadStr)
//        let data :Data = payloadStr.data(using: .utf8)!
//        let dict : [String : Any] = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]
//        let ID : Int =  dict["fenxId"] as! Int
//        KFBLog(message: "详情\(ID)")
//        let vc = TeachDetailViewController()
//        vc.fenxId = ID
//        vc.hidesBottomBarWhenPushed = true
//        let tab : UITabBarController = self.window?.rootViewController as! UITabBarController
//        tab.selectedIndex = 0
//        let nav : UINavigationController = tab.childViewControllers[0] as! UINavigationController
//        nav.pushViewController(vc, animated: true)


    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
         print(userInfo)
        // [ GTSdk ]：将收到的APNs信息传给个推统计
//        GeTuiSdk.handleRemoteNotification(userInfo);
//        KFBLog(message: "\n>>>[Receive RemoteNotification]:\(userInfo)\n\n")
//
//        completionHandler(UIBackgroundFetchResult.newData);
        UMessage.setAutoAlert(false)
        UMessage.didReceiveRemoteNotification(userInfo)
    }

    //iOS10新增：处理前台收到通知的代理方法
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {




    }
    //iOS10新增：处理后台点击通知的代理方法
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        print("didReceiveNotificationResponse: %@",response.notification.request.content.userInfo);
//        let payloadStr : String = response.notification.request.content.userInfo["payload"] as! String
//        KFBLog(message: "payloadStr " + payloadStr)
//        let data :Data = payloadStr.data(using: .utf8)!
//        let dict : [String : Any] = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]
//        let ID : Int =  dict["fenxId"] as! Int
//        KFBLog(message: "详情\(ID)")
//        let vc = TeachDetailViewController()
//        vc.fenxId = ID
//        vc.hidesBottomBarWhenPushed = true
//        let tab : UITabBarController = self.window?.rootViewController as! UITabBarController
//        tab.selectedIndex = 0
//        let nav : UINavigationController = tab.childViewControllers[0] as! UINavigationController
//        nav.pushViewController(vc, animated: true)
//
//        // [ GTSdk ]：将收到的APNs信息传给个推统计
//        GeTuiSdk.handleRemoteNotification(response.notification.request.content.userInfo);
//
        completionHandler();
    }

}

