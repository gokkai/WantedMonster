//
//  detailsViewController.swift
//  Wanted Monster
//
//  Created by Marjolaine Roux on 9/10/17.
//  Copyright © 2017 Marjolaine Roux. All rights reserved.
//

import UIKit
import CoreLocation

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var typeOfMonsterLabel: UILabel!
    @IBOutlet weak var monsterImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
   
    
    var monster: Monster?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    
    }
    
    func setUI(){
        monsterImage.setImage(withURLString: monster?.downlodingImageUrl)
       
        typeOfMonsterLabel.text=monster?.typeOfMonster.rawValue

        reverseGeocoding(latitude: monster!.latitudeOfMonster, longitude: monster!.longitudeOfMonster)
        
        
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
                        self.adressLabel.text=("\(place.subThoroughfare!) \(place.thoroughfare!) \n \(place.locality!) \n \(place.country!)")
                    }
                }
            }
        }
    }
    @IBAction func DeleteMonster(_ sender: Any)
    {
        FirebaseManager.deleteMonster(monster: monster!)
        let alertController = UIAlertController(title: "Monster deleted", message:
            "Thank you for keeping us in the loop", preferredStyle: UIAlertControllerStyle.alert)
        let addAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            //self.tabBarController?.selectedIndex = 0
            self.navigationController?.popToRootViewController(animated: true)
        }
        alertController.addAction(addAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

}
