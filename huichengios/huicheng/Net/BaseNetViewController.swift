//
//  BaseNetViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/5.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SwiftyJSON
protocol BaseNetViewControllerDelegate: NSObjectProtocol{
    func requestSucceed(response :Any) -> Void
    func requestFail(response :Any) -> Void
}
enum reponsetype {
    case datatype
    case alltyper
}

class BaseNetViewController: UIViewController {
    weak var delegate :BaseNetViewControllerDelegate!
    var fileManager = FileManager.default

    func request_api(url : String,type :  reponsetype = .datatype){

        var time = String.getDateNow()
        time = time.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url = base_api + url 


        HCLog(message: url)
        Alamofire.request(url, method: .post).responseJSON { (returnResult) in
            print("secondMethod --> get 请求 --> returnResult = \(returnResult)")
            if let json = returnResult.result.value {
                let model = Mapper<CodeData>().map(JSON: json as! [String : Any])!
                if model.code == 1 {
                    if self.delegate != nil {
                        if type == .datatype{
                            if let data = model.data {
                                self.delegate.requestSucceed(response: data)
                            } else {
                                self.delegate.requestSucceed(response: json)
                            }
                        } else {
                            self.delegate.requestSucceed(response: json)
                        }
                     }
                } else {
                    SVPMessageShow .showErro(infoStr: model.msg)
                    self.delegate.requestFail(response:json)
                }
                
            } else {
                
                HCLog(message: "请求错误1："+returnResult.debugDescription)
                if self.delegate != nil {
                    SVPMessageShow .showErro(infoStr: "请求失败")
                }
            }
        }
        
    }


    static func uploadfile(fileName:String,t:String, isFile : Bool  = true,imageData : Data = Data(),completion : @escaping (_ data : Any) ->(), failure : @escaping (_ error : Any)->()) {
        //
        let urlStr = base_api + uploadfile_api + "t=\(t)&k=\(UserInfoLoaclManger.getKey())"

        if isFile == true {
            //长传文件
            HCLog(message:  "上传文件开始")
            let filePathStr : String = filePath + "/" + fileName
            let url :URL = URL(fileURLWithPath: filePathStr)
            let fileData:Data = try! Data(contentsOf: url)
            let nameStr : String = fileName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            var model:CodeData = CodeData()
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(fileData, withName: "attachs", fileName: nameStr, mimeType: "file/*")

            },
                to: urlStr,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            if let json = response.result.value {

                                model = Mapper<CodeData>().map(JSON: json as! [String : Any])!
                                completion(model)
                            } else {
                                failure("请求失败")
                            }
                        }
                    case .failure(let encodingError):
                        failure("请求失败")
                        print(encodingError)
                    }
            }
            )
        } else {
            //上传图片
            HCLog(message: "上传图片")
            var model:CodeData = CodeData()
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(imageData, withName: "attachs", fileName: "img1", mimeType: "image/*")

            },
                to: urlStr,
                encodingCompletion: { encodingResult in

                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            if let json = response.result.value {
                                model = Mapper<CodeData>().map(JSON: json as! [String : Any])!
                                completion(model)
                            } else {
                                failure("请求失败")
                            }
                        }
                    case .failure(let encodingError):
                        failure("请求失败")
                        print(encodingError)
                    }
            }
            )

        }
        
    }

     func downLoadFile(path : String,name : String, completion : @escaping (_ data : Any) ->(), failure : @escaping (_ error : Any)->()) {
        //

        if fileManager.fileExists(atPath: filePath_downLoad) {
            HCLog(message: "文件夹已存在")
        } else {
            HCLog(message: "创建文件夹")
            do {
                try fileManager.createDirectory(atPath: filePath_downLoad, withIntermediateDirectories: true, attributes: nil)
            } catch _ {
                HCLog(message: "创建文件夹失败")
            }
        }

        //检查文件是否下载过
        HCLog(message: path)
        HCLog(message: name)
        let filePathStr : String = filePath_downLoad + "/" + name
        HCLog(message: filePathStr)
        if fileManager.fileExists(atPath: filePathStr) {
            HCLog(message: "文件已存在")
            completion(filePathStr)

        } else {
            //需要下载

//            let vc = BaseViewController()
//            //            self.downLoadFileRequest(ulrStr: filePathStr, downUrl: path)
//
//            vc.SVshowLoad()
            SVPMessageShow.showLoad()


            let filePathStr : String = filePath_downLoad + "/" + name
            let url  = URL(string: base_imageOrFile_api + path)

            DispatchQueue.global().async {
                let fileData = NSData(contentsOf: url!)
                HCLog(message: "下载文件")
                HCLog(message: fileData?.length)
                let isok =  fileData?.write(toFile: filePathStr, atomically: true)
                DispatchQueue.main.async{
                    SVPMessageShow.dismissSVP()
                    if let _ = isok {
                        HCLog(message: "文件保存成功")
                        completion(filePathStr)
                    } else {

                        HCLog(message: "文件保存失败")
                    }
                }
            }
            //
        }

    }



}
