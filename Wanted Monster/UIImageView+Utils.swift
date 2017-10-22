//
//  UIImageView+Utils.swift
//  Wanted Monster
//
//  Created by Marjolaine Roux on 17/10/17.
//  Copyright © 2017 Marjolaine Roux. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

extension UIImageView{
    func setImage(withURLString urlStr: String?){
        if let urlStr = urlStr, let url = URL(string:urlStr){
            self.af_setImage(withURL: url)
        }
    }
}

