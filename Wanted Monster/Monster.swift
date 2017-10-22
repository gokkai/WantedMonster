//
//  Monster.swift
//  Wanted Monster
//
//  Created by Marjolaine Roux on 3/10/17.
//  Copyright © 2017 Marjolaine Roux. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreLocation

enum TypeMonster: String{
    case pile = "pile"
    case couch = "couch"
    case chair = "chair"
    case decoration = "decoration"
}

let typeArray=[TypeMonster.pile,TypeMonster.couch,TypeMonster.chair,TypeMonster.decoration]
class Monster{
    var typeOfMonster: TypeMonster
    var pictureOfMonster: UIImage?
    var latitudeOfMonster:Double
    var longitudeOfMonster:Double
    var downlodingImageUrl: String?
    var monsterId:String?
    
    init(typeOfMonster:TypeMonster, pictureOfMonster:UIImage, latitudeOfMonster:Double,longitudeOfMonster:Double) {
        self.typeOfMonster=typeOfMonster
        self.pictureOfMonster=pictureOfMonster
        self.latitudeOfMonster=latitudeOfMonster
        self.longitudeOfMonster=longitudeOfMonster
        
        
    }
    
    init?(id: String, json: JSON){
        guard let typeMonster = TypeMonster(rawValue: json["typeOfMonster"].stringValue) else{return nil}
        self.typeOfMonster = typeMonster
        self.latitudeOfMonster = json["latitudeOfMonster"].doubleValue
        self.longitudeOfMonster = json["longitudeOfMonster"].doubleValue
        self.downlodingImageUrl = json["downloadingImageUrl"].string
        self.monsterId = id
        
    }
}
