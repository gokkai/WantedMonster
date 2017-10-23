//
//  HomeCell.swift
//  Wanted Monster
//
//  Created by Marjolaine Roux on 3/10/17.
//  Copyright © 2017 Marjolaine Roux. All rights reserved.
//

import UIKit
import AlamofireImage
import CoreLocation

class HomeCell: UITableViewCell {
    @IBOutlet weak var monsterImage: UIImageView!
    @IBOutlet weak var monsterType: UILabel!
    @IBOutlet weak var monsterPostalCode: UILabel!
    
    
    func setMonster(monster: Monster){
        
        monsterImage.setImage(withURLString: monster.downlodingImageUrl)
        monsterType.text="Type: \(monster.typeOfMonster.rawValue)"
        reverseGeocoding(latitude: monster.latitudeOfMonster, longitude: monster.longitudeOfMonster)
    }
    
    func reverseGeocoding(latitude:Double,longitude:Double)
    {
        let location=CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location){(placemark,error) in
            if error != nil
            {
                print("Oups can't reverse coordinate")
            }
            else
            {
                if let place=placemark?[0]
                {
                    if let checker=place.subThoroughfare
                    {
                        self.monsterPostalCode.text=("Zip Code: \(place.postalCode!)")
                    }
                }
            }
        }
    }

}
