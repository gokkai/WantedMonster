//
//  Monster.swift
//  Wanted Monster
//
//  Created by Marjolaine Roux on 3/10/17.
//  Copyright © 2017 Marjolaine Roux. All rights reserved.
//

import Foundation
import UIKit

enum typeMonster: CustomStringConvertible{
    case pile
    case couch
    case chair
    case decoration
    
    var description: String{
        switch self{
        case .pile: return "pile"
        case .couch: return "couch"
        case .chair: return "chair"
        case .decoration: return "decoration"
        }
    }
    
}
let typeArray=["pile","couch","chair","decoration"]
class Monster{
    let typeOfMonster: typeMonster
    let pictureOfMonster: UIImage
    init(typeOfMonster:typeMonster, pictureOfMonster:UIImage) {
        self.typeOfMonster=typeOfMonster
        self.pictureOfMonster=pictureOfMonster
    }
}
