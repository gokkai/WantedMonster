
//
//  AddViewController.swift
//  Wanted Monster
//
//  Created by Marjolaine Roux on 9/10/17.
//  Copyright © 2017 Marjolaine Roux. All rights reserved.
//

import UIKit
import FirebaseDatabase
import CoreLocation

class AddViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource, UINavigationControllerDelegate,UIImagePickerControllerDelegate,CLLocationManagerDelegate
{
    let manager=CLLocationManager()
    var latitudeMonster:Double=0
    var longitudeMonster:Double=0
    var typeOfMonsterSelected:TypeMonster?
    var location=CLLocation()
    
    @IBOutlet weak var monsterImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typePicker: UIPickerView!
  
    
    @IBAction func takePhoto(_ sender: Any)
    {
        let image=UIImagePickerController()
        image.delegate=self
        image.sourceType=UIImagePickerControllerSourceType.camera
        image.allowsEditing=false
        self.present(image, animated: true)
        {
            //After it is complete
        }
    }
    
    @IBAction func importImage(_ sender: Any)
    {
        let image=UIImagePickerController()
        image.delegate=self
        image.sourceType=UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing=false
        self.present(image, animated: true)
        {
            //After it is complete
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image=info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            monsterImage.image=image
        }
        else
        {
            //TODO
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addMonster(_ sender: Any)
    {
        guard let unwrappedTypeOfMonsterSelected=typeOfMonsterSelected else
        {
         return
        }
        guard let  imageMonsterSelected=monsterImage.image else
        {
            let alertController = UIAlertController(title: "Hey", message: "You need to add a picture please", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
       
        let someMonster=Monster(typeOfMonster: unwrappedTypeOfMonsterSelected, pictureOfMonster: imageMonsterSelected, latitudeOfMonster: latitudeMonster, longitudeOfMonster: longitudeMonster)
        FirebaseManager.addImageOfMonster(monster:someMonster)
        let alertController = UIAlertController(title: "Monster added", message:
            "Thank you for participating", preferredStyle: UIAlertControllerStyle.alert)
        let addAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.tabBarController?.selectedIndex=0

            
        }
        alertController.addAction(addAction)
        self.present(alertController, animated: true, completion: nil)
    }
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return typeArray[row].rawValue
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return typeArray.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        typeOfMonsterSelected = typeArray[row]
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        manager.delegate=self
        manager.desiredAccuracy=kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
      
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
     location=locations[0]
        //let span:MKCoordinateSpan=MKCoordinateSpanMake(0.01,0.01)
        //let myLocation:CLLocationCoordinate2D=CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        latitudeMonster=location.coordinate.latitude
        longitudeMonster=location.coordinate.longitude
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
 
    }
}

