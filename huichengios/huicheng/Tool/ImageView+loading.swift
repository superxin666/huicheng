//
//  ImageView+loading.swift
//  xueji
//
//  Created by lvxin on 2017/11/6.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage_kf(imageName : String,placeholderImage:UIImage)  {
        let imageUrl = base_imageOrFile_api + imageName
        HCLog(message: "图片\(imageUrl)")
        self.kf.setImage(with:  URL(string: imageUrl), placeholder: placeholderImage, options: [.transition(.fade((1)))], progressBlock: nil, completionHandler: nil)
    }

    func setImage_kf2(imageName : String)  {
        let imageUrl = base_imageOrFile_api + imageName
        HCLog(message: "图片\(imageUrl)")
        self.kf.setImage(with:  URL(string: imageUrl), placeholder: UIImage(), options: [.transition(.fade((1)))], progressBlock: nil, completionHandler: nil)
    }


    
}
