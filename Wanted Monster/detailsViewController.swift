//
//  detailsViewController.swift
//  Wanted Monster
//
//  Created by Marjolaine Roux on 9/10/17.
//  Copyright © 2017 Marjolaine Roux. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var typeOfMonsterLabel: UILabel!
    @IBOutlet weak var monsterImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    
    var monster: Monster?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    
    }
    
    func setUI(){
        monsterImage.image=monster?.pictureOfMonster
        typeOfMonsterLabel.text=monster?.typeOfMonster.description
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

}
