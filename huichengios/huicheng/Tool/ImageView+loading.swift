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
        self.kf.setImage(with:  URL(string: imageName), placeholder: placeholderImage, options: [.transition(.fade((1)))], progressBlock: nil, completionHandler: nil)
    }
    
}
