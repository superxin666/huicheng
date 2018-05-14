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

    func request_api(url : String,type :  reponsetype = .datatype){
        let url = base_api + url
        HCLog(message: url)
        Alamofire.request(url, method: .get).responseJSON { (returnResult) in
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


    static func uploadfile(fileName:String,t:String, completion : @escaping (_ data : Any) ->(), failure : @escaping (_ error : Any)->()) {
        //

        HCLog(message:  "上传文件开始")
        let urlStr = base_api + uploadfile_api + "t=\(t)&k=\(UserInfoLoaclManger.getKey())"
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
    }

}
