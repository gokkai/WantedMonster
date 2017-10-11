//
//  HomeCell.swift
//  Wanted Monster
//
//  Created by Marjolaine Roux on 3/10/17.
//  Copyright © 2017 Marjolaine Roux. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
    @IBOutlet weak var monsterImage: UIImageView!
    @IBOutlet weak var monsterType: UILabel!
    
    func setMonster(monster: Monster){
        monsterImage.image=monster.pictureOfMonster
        monsterType.text=monster.typeOfMonster.description
    }
    

}
